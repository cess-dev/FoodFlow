package com.foodflow.controller;

import com.foodflow.dao.UserDAO;
import com.foodflow.model.User;
import com.foodflow.util.PasswordUtil;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.*;
import java.io.IOException;

@WebServlet("/auth")
public class AuthController extends HttpServlet {

    private UserDAO userDAO = new UserDAO();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Handle logout
        if ("logout".equals(action)) {
            HttpSession session = request.getSession(false);
            if (session != null) {
                session.invalidate();
            }
            response.sendRedirect("login.jsp");
            return;
        }

        // Handle signup page display
        if ("signup".equals(action) && "GET".equals(request.getMethod())) {
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Default: show login page
        request.getRequestDispatcher("/login.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String action = request.getParameter("action");

        // Handle signup
        if ("signup".equals(action)) {
            handleSignup(request, response);
            return;
        }

        // Default: handle login
        handleLogin(request, response);
    }

    private void handleLogin(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String username = request.getParameter("username");
        String password = request.getParameter("password");

        System.out.println("=== LOGIN ATTEMPT ===");
        System.out.println("Username: " + username);
        System.out.println("Password provided: " + (password != null ? "Yes" : "No"));

        // Basic validation
        if (username == null || password == null ||
                username.trim().isEmpty() || password.trim().isEmpty()) {

            request.setAttribute("error", "Username and password required.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
            return;
        }

        // Fetch user
        User user = userDAO.getUserByUsername(username);
        System.out.println("User found: " + (user != null ? "Yes" : "No"));
        
        if (user != null) {
            System.out.println("User ID: " + user.getUserId());
            System.out.println("User Name: " + user.getFullName());
            System.out.println("User Role: " + user.getRole());
            System.out.println("User Active: " + user.isActive());
            System.out.println("Stored password hash: " + user.getPassword());
        }

        // Validate user + password
        if (user != null && PasswordUtil.verifyPassword(password, user.getPassword())) {

            if (!user.isActive()) {
                request.setAttribute("error", "Account is deactivated.");
                request.setAttribute("username", username);
                request.getRequestDispatcher("/login.jsp").forward(request, response);
                return;
            }

            System.out.println("Login successful for: " + user.getFullName());

            // Successful login
            HttpSession session = request.getSession();
            session.setAttribute("user", user);
            session.setAttribute("role", user.getRole());
            session.setMaxInactiveInterval(30 * 60); // 30 mins

            userDAO.resetLoginAttempts(user.getUserId());
            userDAO.updateLastLogin(user.getUserId());
            userDAO.logUserActivity(
                    user.getUserId(),
                    "LOGIN",
                    "auth",
                    "User logged in",
                    request.getRemoteAddr()
            );

            response.sendRedirect("home.jsp");

        } else {
            // Failed login
            System.out.println("Login FAILED - Invalid credentials");
            userDAO.incrementLoginAttempts(username);

            request.setAttribute("error", "Invalid username or password.");
            request.setAttribute("username", username);
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        }
    }

    private void handleSignup(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        String fullName = request.getParameter("fullName");
        String username = request.getParameter("username");
        String email = request.getParameter("email");
        String password = request.getParameter("password");
        String confirmPassword = request.getParameter("confirmPassword");
        String roleStr = request.getParameter("role");

        System.out.println("=== SIGNUP ATTEMPT ===");
        System.out.println("Full Name: " + fullName);
        System.out.println("Username: " + username);
        System.out.println("Email: " + email);
        System.out.println("Role: " + roleStr);

        // Preserve form data for EL
        request.setAttribute("fullName", fullName);
        request.setAttribute("username", username);
        request.setAttribute("email", email);
        request.setAttribute("role", roleStr);

        // Validation
        if (fullName == null || fullName.trim().isEmpty() ||
            username == null || username.trim().isEmpty() ||
            email == null || email.trim().isEmpty() ||
            password == null || password.isEmpty()) {
            
            System.out.println("Signup FAILED - Missing fields");
            request.setAttribute("error", "All fields are required.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Validate password match
        if (!password.equals(confirmPassword)) {
            System.out.println("Signup FAILED - Passwords don't match");
            request.setAttribute("error", "Passwords do not match.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Validate password length
        if (password.length() < 8) {
            System.out.println("Signup FAILED - Password too short");
            request.setAttribute("error", "Password must be at least 8 characters long.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Validate email format
        if (!email.matches("^[A-Za-z0-9+_.-]+@(.+)$")) {
            System.out.println("Signup FAILED - Invalid email format");
            request.setAttribute("error", "Invalid email format.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Check if username already exists
        if (userDAO.getUserByUsername(username) != null) {
            System.out.println("Signup FAILED - Username already exists: " + username);
            request.setAttribute("error", "Username already exists.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Check if email already exists
        if (userDAO.getUserByEmail(email) != null) {
            System.out.println("Signup FAILED - Email already exists: " + email);
            request.setAttribute("error", "Email already registered.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
            return;
        }

        // Create new user
        User newUser = new User();
        newUser.setFullName(fullName);
        newUser.setUsername(username);
        newUser.setEmail(email);
        String hashedPassword = PasswordUtil.hashPassword(password);
        newUser.setPassword(hashedPassword);
        
        System.out.println("Password to hash: " + password);
        System.out.println("Hashed password: " + hashedPassword);
        
        // Set role
        try {
            User.Role role = User.Role.valueOf(roleStr);
            newUser.setRole(role);
            System.out.println("Role set to: " + role);
        } catch (Exception e) {
            newUser.setRole(User.Role.STOREKEEPER); // Default role
            System.out.println("Role defaulted to: STOREKEEPER");
        }

        newUser.setActive(true);

        // Save user
        System.out.println("Attempting to create user in database...");
        boolean success = userDAO.createUser(newUser);
        System.out.println("User creation successful: " + success);

        if (success) {
            // Log the activity
            User createdUser = userDAO.getUserByUsername(username);
            if (createdUser != null) {
                System.out.println("User created with ID: " + createdUser.getUserId());
                userDAO.logUserActivity(
                        createdUser.getUserId(),
                        "SIGNUP",
                        "auth",
                        "New user account created",
                        request.getRemoteAddr()
                );
            }

            request.setAttribute("success", "Account created successfully! Please login.");
            request.getRequestDispatcher("/login.jsp").forward(request, response);
        } else {
            System.out.println("Signup FAILED - Database error");
            request.setAttribute("error", "Failed to create account. Please try again.");
            request.getRequestDispatcher("/signup.jsp").forward(request, response);
        }
    }
}
