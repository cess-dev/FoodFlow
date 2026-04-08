<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="jakarta.tags.core" %>
<%@ taglib prefix="fmt" uri="jakarta.tags.fmt" %>
<%
  // Get real data from controller
  com.foodflow.model.User user = (com.foodflow.model.User) request.getAttribute("user");
  com.foodflow.model.User.Role role = (com.foodflow.model.User.Role) request.getAttribute("role");
  java.util.List<com.foodflow.model.Item> items = (java.util.List<com.foodflow.model.Item>) request.getAttribute("items");
  java.util.List<com.foodflow.model.Damage> damages = (java.util.List<com.foodflow.model.Damage>) request.getAttribute("damages");
  Integer pendingRequestCount = (Integer) request.getAttribute("pendingRequestCount");
  
  // Calculate statistics from real data
  java.text.SimpleDateFormat dateFormat = new java.text.SimpleDateFormat("EEE, dd MMM yyyy");
  String serverDate = dateFormat.format(new java.util.Date());
  
  int totalItems = (items != null) ? items.size() : 0;
  int inStockCount = 0;
  int outOfStockCount = 0;
  int lowStockCount = 0;
  int damagedCount = (damages != null) ? damages.size() : 0;
  
  if (items != null) {
    for (com.foodflow.model.Item item : items) {
      if (item.getCurrentStock() > 0) {
        inStockCount++;
      } else {
        outOfStockCount++;
      }
      if (item.isLowStock()) {
        lowStockCount++;
      }
    }
  }
  
  String username = (user != null) ? user.getFullName() : "Unknown";
  String userRole = (role != null) ? role.toString() : "Unknown";
  
  // Set attributes for EL access
  request.setAttribute("serverDate", serverDate);
  request.setAttribute("username", username);
  request.setAttribute("userRole", userRole);
  request.setAttribute("totalItems", totalItems);
  request.setAttribute("inStockCount", inStockCount);
  request.setAttribute("damagedCount", damagedCount);
  request.setAttribute("lowStockCount", lowStockCount);
  request.setAttribute("outOfStockCount", outOfStockCount);
  request.setAttribute("pendingRequestCount", pendingRequestCount != null ? pendingRequestCount : 0);
%>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8"/>
  <meta name="viewport" content="width=device-width, initial-scale=1.0"/>
  <title>Invetory — Server Dashboard</title>
  <link href="https://fonts.googleapis.com/css2?family=Exo+2:wght@300;400;600;700;900&family=JetBrains+Mono:wght@400;600&display=swap" rel="stylesheet"/>
  <link href="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/css/bootstrap.min.css" rel="stylesheet"/>
  <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.5.0/css/all.min.css" rel="stylesheet"/>
  <link rel="stylesheet" href="../css/style.css"/>
  <link rel="stylesheet" href="../css/animations.css"/>
</head>
<body>

<div class="container-fluid p-0">
  <div class="main-wrapper" style="margin-left:0">

    <!-- Top bar (server rendered) -->
    <header class="topbar">
      <div class="topbar-left">
        <h2 class="page-title">FoodFlow Dashboard</h2>
        <div class="breadcrumb-wrap">
          <span class="bc-item">INVENTORY MANAGEMENT</span>
          <i class="fa-solid fa-chevron-right bc-sep"></i>
          <span class="bc-item active">Dashboard</span>
        </div>
      </div>
      <div class="topbar-right">
        <div class="date-badge">
          <i class="fa-regular fa-calendar"></i>
          <span>${serverDate}</span>
        </div>
        <div class="date-badge">
          <i class="fa-solid fa-user-tie"></i>
          <span>${username} — ${userRole}</span>
        </div>
        <a href="${pageContext.request.contextPath}/auth?action=logout" class="btn-primary-action" style="text-decoration:none;">
          <i class="fa-solid fa-sign-out-alt"></i> Logout
        </a>
      </div>
    </header>

    <div class="page-container">

      <!-- JSP Info Banner -->
      <div class="alert-item" style="margin-bottom:24px;border-left:3px solid var(--accent-cyan);border-radius:var(--radius-md);background:rgba(6,182,212,0.08);">
        <span class="alert-item-icon" style="color:var(--accent-cyan);font-size:18px;"><i class="fa-brands fa-java"></i></span>
        <div style="flex:1">
          <strong style="color:var(--accent-cyan)">Server-Side JSP Rendering</strong>
          <div style="font-size:12px;color:var(--text-muted);margin-top:3px;">
            This page demonstrates how InvenTrack Pro data would be rendered server-side using Java Server Pages.
            In production, data is fetched from a database via a Java service layer and injected into the JSP context.
          </div>
        </div>
      </div>

      <!-- Stats Row -->
      <div class="row g-4 mb-4">
        <div class="col-xl-3 col-md-6">
          <div class="stat-card shake-card" data-color="blue">
            <div class="stat-icon"><i class="fa-solid fa-boxes-stacked"></i></div>
            <div class="stat-info">
              <span class="stat-label">Total Items</span>
              <span class="stat-value">${totalItems}</span>
              <span class="stat-trend up"><i class="fa-solid fa-arrow-trend-up"></i> Server rendered</span>
            </div>
            <div class="stat-bg-icon"><i class="fa-solid fa-boxes-stacked"></i></div>
          </div>
        </div>
        <div class="col-xl-3 col-md-6">
          <div class="stat-card shake-card" data-color="green">
            <div class="stat-icon"><i class="fa-solid fa-circle-check"></i></div>
            <div class="stat-info">
              <span class="stat-label">In Stock</span>
              <span class="stat-value">${inStockCount}</span>
              <span class="stat-trend up"><i class="fa-solid fa-arrow-trend-up"></i> Java rendered</span>
            </div>
            <div class="stat-bg-icon"><i class="fa-solid fa-circle-check"></i></div>
          </div>
        </div>
        <div class="col-xl-3 col-md-6">
          <div class="stat-card shake-card" data-color="red">
            <div class="stat-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
            <div class="stat-info">
              <span class="stat-label">Damaged Items</span>
              <span class="stat-value">${damagedCount}</span>
              <span class="stat-trend down"><i class="fa-solid fa-arrow-trend-down"></i> DB count</span>
            </div>
            <div class="stat-bg-icon"><i class="fa-solid fa-triangle-exclamation"></i></div>
          </div>
        </div>
        <div class="col-xl-3 col-md-6">
          <div class="stat-card shake-card" data-color="amber">
            <div class="stat-icon"><i class="fa-solid fa-clipboard-list"></i></div>
            <div class="stat-info">
              <span class="stat-label">Pending Requests</span>
              <span class="stat-value">${pendingRequestCount}</span>
              <span class="stat-trend up"><i class="fa-solid fa-arrow-trend-up"></i> Awaiting approval</span>
            </div>
            <div class="stat-bg-icon"><i class="fa-solid fa-clipboard-list"></i></div>
          </div>
        </div>
      </div>

      <div class="row g-4">
        <!-- Low Stock Table (server rendered) -->
        <div class="col-xl-7">
          <div class="card-panel shake-card">
            <div class="panel-header">
              <h5><i class="fa-solid fa-triangle-exclamation"></i> Low Stock Items (Server Rendered)</h5>
              <span class="badge badge-warn">${lowStockCount + outOfStockCount} Alerts</span>
            </div>
            <div class="table-responsive">
              <table class="table table-dark-custom">
                <thead>
                  <tr>
                    <th>Item Name</th>
                    <th>Current Qty</th>
                    <th>Unit</th>
                    <th>Status</th>
                  </tr>
                </thead>
                <tbody>
                  <c:forEach var="item" items="${items}">
                    <c:if test="${item.lowStock}">
                      <c:set var="statusClass" value="${item.status eq 'OUT_OF_STOCK' ? 'red' : 'amber'}" />
                      <tr>
                        <td><strong>${item.name}</strong></td>
                        <td style="font-family:'JetBrains Mono',monospace">${item.currentStock}</td>
                        <td style="font-family:'JetBrains Mono',monospace;color:var(--text-muted)">${item.unitOfMeasure}</td>
                        <td><span class="badge badge-${statusClass}">${item.status}</span></td>
                      </tr>
                    </c:if>
                  </c:forEach>
                  <c:if test="${lowStockCount == 0}">
                    <tr>
                      <td colspan="4" style="text-align:center;color:var(--text-muted)">No low stock items</td>
                    </tr>
                  </c:if>
                </tbody>
              </table>
            </div>
          </div>
        </div>

        <!-- Recent Activity (server rendered) -->
        <div class="col-xl-5">
          <div class="card-panel shake-card">
            <div class="panel-header">
              <h5><i class="fa-solid fa-clock-rotate-left"></i> Recent Damage Reports</h5>
            </div>
            <div class="activity-list">
              <c:forEach var="damage" items="${damages}" end="4">
                <div class="activity-item">
                  <div class="activity-icon damage">
                    <i class="fa-solid fa-triangle-exclamation"></i>
                  </div>
                  <div class="activity-text">
                    Damage: <strong>${damage.itemName}</strong> (${damage.quantity} units)
                  </div>
                  <div class="activity-time">${damage.reportDate}</div>
                </div>
              </c:forEach>
              <c:if test="${damagedCount == 0}">
                <div style="text-align:center;color:var(--text-muted);padding:20px;">
                  <i class="fa-solid fa-check-circle" style="font-size:32px;margin-bottom:10px;display:block;"></i>
                  No damage reports
                </div>
              </c:if>
            </div>
          </div>
        </div>
      </div>

      <!-- Server Info Card -->
      <div class="row g-4 mt-0">
        <div class="col-12">
          <div class="card-panel shake-card" style="border-left:3px solid var(--navy-400)">
            <div class="panel-header">
              <h5><i class="fa-brands fa-java"></i> JSP Integration Notes</h5>
            </div>
            <div class="row g-3" style="font-size:13px;color:var(--text-secondary)">
              <div class="col-md-4">
                <div style="padding:14px;background:var(--navy-800);border-radius:var(--radius-sm);border:1px solid var(--border-color)">
                  <div style="color:var(--accent-cyan);font-weight:700;margin-bottom:8px;font-size:12px;letter-spacing:1px;text-transform:uppercase">Database Layer</div>
                  Connect via JNDI DataSource or direct JDBC. Use PreparedStatements for all queries. Recommended: connection pooling with HikariCP or Tomcat JDBC Pool.
                </div>
              </div>
              <div class="col-md-4">
                <div style="padding:14px;background:var(--navy-800);border-radius:var(--radius-sm);border:1px solid var(--border-color)">
                  <div style="color:var(--accent-amber);font-weight:700;margin-bottom:8px;font-size:12px;letter-spacing:1px;text-transform:uppercase">Session Management</div>
                  Use <code style="color:var(--accent-cyan)">HttpSession</code> for user authentication. Store user role, permissions, and audit trail. Invalidate on logout.
                </div>
              </div>
              <div class="col-md-4">
                <div style="padding:14px;background:var(--navy-800);border-radius:var(--radius-sm);border:1px solid var(--border-color)">
                  <div style="color:var(--accent-green);font-weight:700;margin-bottom:8px;font-size:12px;letter-spacing:1px;text-transform:uppercase">API Endpoint</div>
                  <code style="color:var(--accent-cyan)">inventoryApi.jsp</code> handles all JSON REST calls. Frontend JS calls this endpoint for live CRUD operations in production.
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>

    </div><!-- page-container -->
  </div><!-- main-wrapper -->
</div>

<script src="https://cdn.jsdelivr.net/npm/bootstrap@5.3.2/dist/js/bootstrap.bundle.min.js"></script>
</body>
</html>
