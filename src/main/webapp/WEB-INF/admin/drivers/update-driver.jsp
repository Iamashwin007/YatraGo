<%--
  Created by IntelliJ IDEA.
  User: Admin
  Date: 5/17/2026
  Time: 4:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Edit Driver — YatraGo</title>
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
                <h1 class="admin-page-title">Edit Driver</h1>
                <p class="admin-page-subtitle">Update details for ${driver.name}</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/driver-list" class="btn btn-outline">← Back to Drivers</a>
        </div>

        <c:if test="${not empty error}">
            <div class="alert alert-error">${error}</div>
        </c:if>

        <div class="form-card">
            <form action="${pageContext.request.contextPath}/admin/update-driver" method="post">

                <input type="hidden" name="id" value="${driver.id}">

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="name">Full Name *</label>
                        <input class="form-control" type="text" id="name" name="name"
                               value="${driver.name}" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="licenseNumber">License Number *</label>
                        <input class="form-control" type="text" id="licenseNumber" name="licenseNumber"
                               value="${driver.licenseNumber}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="phone">Phone Number *</label>
                        <input class="form-control" type="text" id="phone" name="phone"
                               value="${driver.phone}" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="experienceYears">Experience (Years) *</label>
                        <input class="form-control" type="number" id="experienceYears" name="experienceYears"
                               min="0" value="${driver.experienceYears}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="busId">Assigned Bus ID (optional)</label>
                        <input class="form-control" type="number" id="busId" name="busId"
                               min="1" value="${driver.busId}">
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="status">Status *</label>
                        <select class="form-control" id="status" name="status">
                            <option value="active"   ${driver.status == 'active'   ? 'selected' : ''}>Active</option>
                            <option value="inactive" ${driver.status == 'inactive' ? 'selected' : ''}>Inactive</option>
                        </select>
                    </div>
                </div>

                <div class="form-actions">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
                    <a href="${pageContext.request.contextPath}/admin/driver-list" class="btn btn-outline">Cancel</a>
                </div>

            </form>
        </div>

    </div>
</main>

<script src="${pageContext.request.contextPath}/js/toasts.js"></script>
</body>
</html>
