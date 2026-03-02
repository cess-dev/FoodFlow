package com.catering.controller;

import com.catering.dao.UserDAO;
import com.catering.model.User;
import com.catering.util.PasswordUtil;
import javax.servlet.*;
import javax.servlet.http.*;
import javax.servlet.annotation.*;
import java.io.IOException;

@WebServlet("/login")
public class LoginController extends HttpServlet {
    
    private UserDAO userDAO = new UserDAO();
    
    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        
        String username = request.getParameter("username");
        String password = request.getParameter("password");
        
        // Validate input
        if (username == null || password == null || username.trim().isEmpty()) {
            request.setAttribute("error", "Username and password required");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }
        
        // Get user from database
        User user = userDAO.getUserByUsername(username);
        
        // Check if user exists and password matches
        if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {
            
            // Check if account is active
            if (!user.isActive()) {
                request.setAttribute("error", "Account is deactivated. Contact admin.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            // Check if account is locked
            if (user.isAccountLocked()) {
                request.setAttribute("error", "Account is locked. Contact admin.");
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }
            
            // Login successful
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("userRole", user.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 minutes
            
            // Reset login attempts
            userDAO.resetLoginAttempts(user.getUserId());
            
            // Update last login time
            userDAO.updateLastLogin(user.getUserId());
            
            // Log activity
            userDAO.logUserActivity(user.getUserId(), "LOGIN", "auth", 
                "User logged in successfully", request.getRemoteAddr());
            
            // Redirect based on role
            switch(user.getRole()) {
                case ADMIN:
                    response.sendRedirect("admin/dashboard.jsp");
                    break;
                case MANAGER:
                    response.sendRedirect("manager/dashboard.jsp");
                    break;
                case CLERK:
                    response.sendRedirect("clerk/dashboard.jsp");
                    break;
                default:
                    response.sendRedirect("dashboard.jsp");
            }
            
        } else {
            // Login failed
            // Track failed attempt
            userDAO.incrementLoginAttempts(username);
            
            request.setAttribute("error", "Invalid username or password");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }
    
    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response) 
            throws ServletException, IOException {
        // Show login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }
}
