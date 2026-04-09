<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>FoodFlow - School Inventory System</title>
    <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;600;700;900&family=JetBrains+Mono:wght@400;600&display=swap" rel="stylesheet" />
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/index.css?v=20260409" />
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/landing.css?v=20260409" />
</head>
<body class="landing-body">
    <main class="landing-shell">
        <section class="landing-hero card-panel">
            <span class="landing-badge">FoodFlow</span>
            <h1>School Inventory Management</h1>
            <p>
                FoodFlow supports stock accountability across school departments with role-based access,
                damage tracking, issue logs, and dashboard visibility for day-to-day operations.
            </p>
            <div class="landing-actions">
                <a class="btn-primary-action" href="<%= request.getContextPath() %>/login.jsp">
                    <i class="fa-solid fa-right-to-bracket"></i> Log In
                </a>
            </div>
        </section>

        <section class="landing-grid">
            <article class="card-panel landing-card">
                <h2><i class="fa-solid fa-users"></i> System Roles</h2>
                <ul>
                    <li><strong>Admin (ICT):</strong> oversees platform access and controls.</li>
                    <li><strong>Department Head:</strong> approves and reviews requests.</li>
                    <li><strong>Storekeeper:</strong> manages stock, issues, and damage records.</li>
                </ul>
            </article>

            <article class="card-panel landing-card">
                <h2><i class="fa-solid fa-chart-column"></i> Snapshot</h2>
                <div class="landing-metrics">
                    <div class="metric-box">
                        <span class="metric-value">3</span>
                        <span class="metric-label">Active Roles</span>
                    </div>
                    <div class="metric-box">
                        <span class="metric-value">9</span>
                        <span class="metric-label">Core Tables</span>
                    </div>
                    <div class="metric-box">
                        <span class="metric-value">4</span>
                        <span class="metric-label">API Modules</span>
                    </div>
                </div>
            </article>

            <article class="card-panel landing-card">
                <h2><i class="fa-solid fa-shield-halved"></i> Access Model</h2>
                <p>
                    Accounts are administrator-managed for this case study. Public access is limited to
                    the landing and login pages, while operational routes require authenticated sessions.
                </p>
            </article>
        </section>
    </main>
</body>
</html>
