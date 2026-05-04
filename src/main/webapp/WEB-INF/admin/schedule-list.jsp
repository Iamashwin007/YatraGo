<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Schedule Management — YatraGo Admin</title>
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
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"     class="nav-link">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bus-list"      class="nav-link">Buses</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/route-list"    class="nav-link">Routes</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/schedule-list" class="nav-link active">Schedules</a></li>
            <li><a href="${pageContext.request.contextPath}/logout"              class="nav-link">Logout</a></li>
        </ul>
    </div>
</nav>

<main>
    <div class="admin-content">

        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">Schedule Management</h1>
                <p class="admin-page-subtitle">Manage all bus schedules in the system</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/add-schedule" class="btn btn-primary">+ Add New Schedule</a>
        </div>

        <div class="table-card">
            <c:choose>
                <c:when test="${empty schedules}">
                    <div class="empty-state">
                        <div class="empty-state-icon">&#128197;</div>
                        <p class="empty-state-title">No schedules added yet</p>
                        <p>Click &ldquo;Add New Schedule&rdquo; to get started.</p>
                    </div>
                </c:when>
                <c:otherwise>
                    <table class="data-table">
                        <thead>
                            <tr>
                                <th>ID</th>
                                <th>Bus</th>
                                <th>Route</th>
                                <th>Date</th>
                                <th>Departure</th>
                                <th>Arrival</th>
                                <th>Fare (NPR)</th>
                                <th>Seats</th>
                                <th>Status</th>
                                <th>Actions</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="schedule" items="${schedules}">
                                <tr>
                                    <td data-label="ID">${schedule.id}</td>
                                    <td data-label="Bus">
                                        <strong>${schedule.busNumber}</strong><br>
                                        <span class="text-muted" style="font-size:0.8125rem;">${schedule.operatorName}</span>
                                    </td>
                                    <td data-label="Route">${schedule.routeOrigin} &rarr; ${schedule.routeDestination}</td>
                                    <td data-label="Date">${schedule.journeyDate}</td>
                                    <td data-label="Departure">${schedule.departureTime}</td>
                                    <td data-label="Arrival">${schedule.arrivalTime}</td>
                                    <td data-label="Fare (NPR)">${schedule.fare}</td>
                                    <td data-label="Seats">${schedule.availableSeats}</td>
                                    <td data-label="Status">
                                        <span class="badge badge-${schedule.status}">${schedule.status}</span>
                                    </td>
                                    <td data-label="Actions">
                                        <div class="table-actions">
                                            <a href="${pageContext.request.contextPath}/admin/update-schedule?id=${schedule.id}"
                                               class="btn btn-secondary btn-sm">Edit</a>
                                            <form method="post"
                                                  action="${pageContext.request.contextPath}/admin/delete-schedule"
                                                  onsubmit="return confirm('Delete this schedule? This cannot be undone.');">
                                                <input type="hidden" name="id" value="${schedule.id}">
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
    <span class="footer-brand">Yatra<span>Go</span></span>
    &copy; 2026 YatraGo. Admin Panel.
</footer>

<script>
(function () {
    var nav    = document.querySelector('.navbar');
    var toggle = document.getElementById('navToggle');
    var menu   = document.getElementById('mainNav');
    if (nav) {
        window.addEventListener('scroll', function () {
            nav.classList.toggle('scrolled', window.scrollY > 8);
        }, { passive: true });
    }
    if (toggle && menu) {
        toggle.addEventListener('click', function () {
            menu.classList.toggle('nav-open');
        });
    }
}());
</script>

</body>
</html>
