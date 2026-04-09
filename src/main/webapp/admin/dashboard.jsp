<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    com.foodflow.model.User user = (com.foodflow.model.User) session.getAttribute("user");
    if (user == null) {
        response.sendRedirect(request.getContextPath() + "/login.jsp");
        return;
    }
    if (user.getRole() != com.foodflow.model.User.Role.ADMIN) {
        response.sendRedirect(request.getContextPath() + "/dashboard");
        return;
    }
    request.getRequestDispatcher("/home.jsp").forward(request, response);
%>
