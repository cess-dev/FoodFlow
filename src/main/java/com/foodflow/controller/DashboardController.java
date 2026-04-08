package com.foodflow.controller;

import com.foodflow.dao.ItemDAO;
import com.foodflow.dao.DamageDAO;
import com.foodflow.dao.StoreRequestDAO;
import com.foodflow.model.User;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;
import java.util.List;

@WebServlet("/dashboard")
public class DashboardController extends HttpServlet {
    private final ItemDAO itemDAO = new ItemDAO();
    private final DamageDAO damageDAO = new DamageDAO();
    private final StoreRequestDAO storeRequestDAO = new StoreRequestDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        
        // Load dashboard data
        try {
            request.setAttribute("user", user);
            request.setAttribute("role", user.getRole());
            request.setAttribute("pendingRequestCount", storeRequestDAO.countPendingRequests());
            request.setAttribute("items", itemDAO.getAllItems());
            request.setAttribute("damages", damageDAO.getAllDamage());
            
            // Forward to unified dashboard JSP
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
            
        } catch (Exception e) {
            System.err.println("Error loading dashboard: " + e.getMessage());
            e.printStackTrace();
            request.setAttribute("error", "Failed to load dashboard data");
            request.getRequestDispatcher("/jsp/dashboard.jsp").forward(request, response);
        }
    }
}
