<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%
    // Check if user is logged in
    if (session.getAttribute("user") == null) {
        response.sendRedirect("login.jsp");
        return;
    }
    
    com.foodflow.model.User user = (com.foodflow.model.User) session.getAttribute("user");
    String userName = user.getFullName();
    String userRole = user.getRole().toString();
    int userId = user.getUserId();
%>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
    <title>FoodFlow — Redirecting...</title>
    <script>
        // Store user info in sessionStorage
        var uName = "<%= userName %>";
        var uRole = "<%= userRole %>";
        var uId = "<%= userId %>";
        sessionStorage.setItem('userName', uName);
        sessionStorage.setItem('userRole', uRole);
        sessionStorage.setItem('userId', uId);
        
        // Redirect to main application
        window.location.href = '<%= request.getContextPath() %>/index.html?v=20260409';
    </script>
</head>
<body>
    <p>Redirecting to FoodFlow...</p>
</body>
</html>
