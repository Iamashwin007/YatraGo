<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Bus Management — YatraGo Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<nav class="navbar admin-navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            Yatra<span>Go</span><span class="admin-panel-badge">Admin</span>
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bus-list" class="nav-link active">Buses</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/route-list" class="nav-link">Routes</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/schedule-list" class="nav-link">Schedules</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
        </ul>
    </div>
</nav>

<main>
    <div class="admin-content">

        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">Bus Management</h1>
                <p class="admin-page-subtitle">Manage all registered buses in the system</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/add-bus" class="btn btn-primary">+ Add New Bus</a>
        </div>

        <div class="table-card">
            <c:choose>
                <c:when test="${empty buses}">
                    <div class="empty-state">
                        <div class="empty-state-icon">&#128652;</div>
                        <p class="empty-state-title">No buses registered yet</p>
                        <p>Click "Add New Bus" to get started.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Bus Number</th>
                                <th>Operator</th>
                                <th>Type</th>
                                <th>Seats</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="bus" items="${buses}">
                                <tr>
                                    <td data-label="ID">${bus.id}</td>
                                    <td data-label="Bus Number">${bus.busNumber}</td>
                                    <td data-label="Operator">${bus.operatorName}</td>
                                    <td data-label="Type">${bus.busType}</td>
                                    <td data-label="Seats">${bus.totalSeats}</td>
                                    <td data-label="Status">
                                        <span class="badge badge-${bus.status}">${bus.status}</span>
                                    </td>
                                    <td data-label="Actions">
                                        <div class="table-actions">
                                            <a href="${pageContext.request.contextPath}/admin/update-bus?id=${bus.id}"
                                               class="btn btn-secondary btn-sm">Edit</a>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/admin/delete-bus"
                                                  onsubmit="return confirm('Delete bus ${bus.busNumber}? This cannot be undone.');">
                                                <input type="hidden" name="id" value="${bus.id}">
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
