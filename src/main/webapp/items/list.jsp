<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ page import="java.util.List" %>
<%@ page import="com.foodflow.model.Item" %>
<%
    List<Item> items = (List<Item>) request.getAttribute("items");
    Boolean canManageInventory = (Boolean) request.getAttribute("canManageInventory");
    String query = (String) request.getAttribute("query");
%>
<!DOCTYPE html>
<html>
<head>
    <title>Inventory Items</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="../assets/css/app.css">
</head>
<body>
<main class="shell">
    <section class="page-card page-head">
        <div>
            <p class="eyebrow">Inventory</p>
            <h1>Item list and store status</h1>
            <p>Supports the Store Keeper flow for viewing items, searching inventory, and recording current stock status.</p>
        </div>
        <div class="nav-links">
            <a class="button secondary" href="../dashboard">Dashboard</a>
            <a class="button secondary" href="../requests">Store requests</a>
        </div>
    </section>

    <section class="form-card">
        <form method="get" action="../items">
            <label>
                Search items
                <input type="text" name="q" value="<%= query == null ? "" : query %>" placeholder="Search by item or category">
            </label>
            <button type="submit">Search</button>
        </form>
    </section>

    <section class="content-grid">
        <article class="table-card">
            <h2>Current inventory</h2>
            <table>
                <thead>
                <tr>
                    <th>Item</th>
                    <th>Category</th>
                    <th>Type</th>
                    <th>Stock</th>
                    <th>Unit</th>
                    <th>Status</th>
                </tr>
                </thead>
                <tbody>
                <% if (items != null && !items.isEmpty()) { %>
                    <% for (Item item : items) { %>
                    <tr>
                        <td><%= item.getName() %></td>
                        <td><%= item.getCategory() %></td>
                        <td><%= item.getItemType() %></td>
                        <td><%= item.getCurrentStock() %></td>
                        <td><%= item.getUnitOfMeasure() %></td>
                        <td class="<%= item.isLowStock() ? "status-low" : "status-ok" %>"><%= item.getStatus() %></td>
                    </tr>
                    <% } %>
                <% } else { %>
                    <tr><td colspan="6">No items found.</td></tr>
                <% } %>
                </tbody>
            </table>
        </article>

        <% if (Boolean.TRUE.equals(canManageInventory)) { %>
        <article class="form-card">
            <h2>Add item</h2>
            <form method="post" action="../items">
                <input type="hidden" name="action" value="add">
                <label>Item name<input type="text" name="itemName" required></label>
                <label>Category<input type="text" name="category" placeholder="Food, Utensils, Cleaning" required></label>
                <label>
                    Item type
                    <select name="itemType" required>
                        <option value="FOOD">Food</option>
                        <option value="UTENSIL">Utensil</option>
                        <option value="TOOL">Tool</option>
                    </select>
                </label>
                <label>Opening stock<input type="number" name="quantity" step="0.01" required></label>
                <label>Unit of measure<input type="text" name="unitOfMeasure" placeholder="kg, pcs, liters" required></label>
                <label>Description<textarea name="description" placeholder="Optional item description"></textarea></label>
                <button type="submit">Add item</button>
            </form>
        </article>
        <% } %>
    </section>
</main>
</body>
</html>
