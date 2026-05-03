<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Route Management — YatraGo Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<nav class="navbar admin-navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            Yatra<span>Go</span><span class="admin-panel-badge">Admin</span>
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"  class="nav-link">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bus-list"   class="nav-link">Buses</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/route-list" class="nav-link active">Routes</a></li>
            <li><a href="#" class="nav-link nav-link-placeholder">Schedules</a></li>
            <li><a href="${pageContext.request.contextPath}/logout"           class="nav-link">Logout</a></li>
        </ul>
    </div>
</nav>

<main>
    <div class="admin-content">

        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">Route Management</h1>
                <p class="admin-page-subtitle">Manage all bus routes in the system</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/add-route" class="btn btn-primary">+ Add New Route</a>
        </div>

        <div class="table-card">
            <c:choose>
                <c:when test="${empty routes}">
                    <div class="empty-state">
                        <div class="empty-state-icon">&#128506;</div>
                        <p class="empty-state-title">No routes added yet</p>
                        <p>Click "Add New Route" to get started.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Origin</th>
                                <th>Destination</th>
                                <th>Distance (km)</th>
                                <th>Duration (hrs)</th>
                                <th>Base Fare (NPR)</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="route" items="${routes}">
                                <tr>
                                    <td data-label="ID">${route.id}</td>
                                    <td data-label="Origin">${route.origin}</td>
                                    <td data-label="Destination">${route.destination}</td>
                                    <td data-label="Distance (km)">${route.distanceKm}</td>
                                    <td data-label="Duration (hrs)">${route.durationHours}</td>
                                    <td data-label="Base Fare (NPR)">${route.baseFare}</td>
                                    <td data-label="Status">
                                        <span class="badge badge-${route.status}">${route.status}</span>
                                    </td>
                                    <td data-label="Actions">
                                        <div class="table-actions">
                                            <a href="${pageContext.request.contextPath}/admin/update-route?id=${route.id}"
                                               class="btn btn-secondary btn-sm">Edit</a>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/admin/delete-route"
                                                  onsubmit="return confirm('Delete route ${route.origin} → ${route.destination}? This cannot be undone.');">
                                                <input type="hidden" name="id" value="${route.id}">
                                                <button type="submit" class="btn btn-danger btn-sm">Delete</button>
                                            </form>
                                        </div>
                                    </td>
                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </c:otherwise>
            </c:choose>
        </div>

    </div>
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span style="color:#e85d04;">Go</span></span>
    &copy; 2026 YatraGo. Admin Panel.
</footer>

</body>
</html>
