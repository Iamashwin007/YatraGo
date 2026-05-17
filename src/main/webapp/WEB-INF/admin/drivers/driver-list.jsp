<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 5/17/2026
  Time: 4:16 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Drivers — YatraGo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<nav class="navbar admin-navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            Yatra<span>Go</span><span class="admin-panel-badge">Admin</span>
        </a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bus-list" class="nav-link">Buses</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/driver-list" class="nav-link active">Drivers</a></li>
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
                <h1 class="admin-page-title">Drivers</h1>
                <p class="admin-page-subtitle">All registered drivers in the system</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/add-driver" class="btn btn-primary">+ Add Driver</a>
        </div>

        <c:if test="${not empty flash_success}">
            <div class="alert alert-success">${flash_success}</div>
        </c:if>

        <div class="table-card">
            <table class="table">
                <thead>
                <tr>
                    <th>#</th>
                    <th>Name</th>
                    <th>License Number</th>
                    <th>Phone</th>
                    <th>Experience</th>
                    <th>Assigned Bus</th>
                    <th>Status</th>
                    <th>Actions</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="driver" items="${drivers}" varStatus="loop">
                    <tr>
                        <td>${loop.count}</td>
                        <td>${driver.name}</td>
                        <td>${driver.licenseNumber}</td>
                        <td>${driver.phone}</td>
                        <td>${driver.experienceYears} yrs</td>
                        <td>
                            <c:choose>
                                <c:when test="${not empty driver.busNumber}">
                                    ${driver.busNumber}
                                </c:when>
                                <c:otherwise>
                                    <span class="text-muted">Unassigned</span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                            <span class="badge badge-${driver.status}">${driver.status}</span>
                        </td>
                        <td class="table-actions">
                            <a href="${pageContext.request.contextPath}/admin/update-driver?id=${driver.id}"
                               class="btn btn-sm btn-outline">Edit</a>
                            <form action="${pageContext.request.contextPath}/admin/delete-driver"
                                  method="post" style="display:inline"
                                  onsubmit="return confirm('Delete ${driver.name}? This cannot be undone.')">
                                <input type="hidden" name="id" value="${driver.id}">
                                <button type="submit" class="btn btn-sm btn-danger">Delete</button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>

                <c:if test="${empty drivers}">
                    <tr>
                        <td colspan="8" class="empty-state">
                            <div class="empty-state-icon">🚗</div>
                            <div class="empty-state-title">No drivers yet</div>
                            <p>Click "Add Driver" to register the first one.</p>
                        </td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>

    </div>
</main>

<script src="${pageContext.request.contextPath}/js/toasts.js"></script>
</body>
</html>