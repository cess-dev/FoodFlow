<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="com.foodflow.model.User" %>
<%
    User editUser = (User) request.getAttribute("user");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Edit User</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="auth-shell stack">
    <section class="page-card">
        <p class="eyebrow">Admin</p>
        <h1>Edit user</h1>
        <p class="muted">Update user identity, role, or password.</p>
    </section>

    <section class="form-card">
        <form method="post" action="users">
            <input type="hidden" name="action" value="edit">
            <input type="hidden" name="id" value="<%= editUser != null ? editUser.getUserId() : 0 %>">
            <label>Full name<input type="text" name="fullName" value="<%= editUser != null ? editUser.getFullName() : "" %>" required></label>
            <label>Email<input type="email" name="email" value="<%= editUser != null ? editUser.getEmail() : "" %>" required></label>
            <label>Password<input type="password" name="password" placeholder="Leave blank to keep current password"></label>
            <label>
                Role
                <select name="role">
                    <option value="ADMIN" <%= editUser != null && editUser.getRole() == User.Role.ADMIN ? "selected" : "" %>>Admin</option>
                    <option value="DEPARTMENT_HEAD" <%= editUser != null && editUser.getRole() == User.Role.DEPARTMENT_HEAD ? "selected" : "" %>>Department Head</option>
                    <option value="STOREKEEPER" <%= editUser != null && editUser.getRole() == User.Role.STOREKEEPER ? "selected" : "" %>>Store Keeper</option>
                </select>
            </label>
            <button type="submit">Save changes</button>
        </form>
    </section>
</main>
</body>
</html>
