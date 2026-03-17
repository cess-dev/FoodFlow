package com.foodflow.controller;

import com.foodflow.config.SecurityConfig;
import com.foodflow.dao.ItemDAO;
import com.foodflow.dao.UsageDAO;
import com.foodflow.model.User;
import com.foodflow.service.UsageService;

import jakarta.servlet.ServletException;
import jakarta.servlet.annotation.WebServlet;
import jakarta.servlet.http.HttpServlet;
import jakarta.servlet.http.HttpServletRequest;
import jakarta.servlet.http.HttpServletResponse;
import jakarta.servlet.http.HttpSession;

import java.io.IOException;

@WebServlet("/usage")
public class UsageController extends HttpServlet {

    private final UsageDAO usageDAO = new UsageDAO();
    private final ItemDAO itemDAO = new ItemDAO();
    private final UsageService usageService = new UsageService();

    @Override
    protected void doGet(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        request.setAttribute("items", itemDAO.getAllItems());
        request.setAttribute("usageEntries", usageDAO.getAllUsage());
        request.getRequestDispatcher("/usage/list.jsp").forward(request, response);
    }

    @Override
    protected void doPost(HttpServletRequest request, HttpServletResponse response)
            throws ServletException, IOException {

        HttpSession session = request.getSession(false);
        if (session == null || session.getAttribute("user") == null) {
            response.sendRedirect("login.jsp");
            return;
        }

        User user = (User) session.getAttribute("user");
        if (!SecurityConfig.canRecordOperationalData(user)) {
            response.sendRedirect("access-denied.jsp");
            return;
        }

        String itemId = request.getParameter("itemId");
        String quantityStr = request.getParameter("quantity");
        String issuedTo = request.getParameter("issuedTo");

        try {
            int quantity = Integer.parseInt(quantityStr);
            usageService.recordUsage(Integer.parseInt(itemId), quantity, user.getUserId(), issuedTo);
            response.sendRedirect("usage");
        } catch (NumberFormatException e) {
            request.setAttribute("error", "Invalid quantity");
            request.setAttribute("items", itemDAO.getAllItems());
            request.setAttribute("usageEntries", usageDAO.getAllUsage());
            request.getRequestDispatcher("/usage/list.jsp").forward(request, response);
        }
    }
}
