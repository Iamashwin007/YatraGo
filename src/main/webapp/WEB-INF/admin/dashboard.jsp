<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — YatraGo</title>
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
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link active">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bus-list" class="nav-link">Buses</a></li>
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
                <h1 class="admin-page-title">Dashboard</h1>
                <p class="admin-page-subtitle">Welcome back, ${sessionScope.user.name}</p>
            </div>
        </div>

        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-icon stat-icon-blue">&#128652;</div>
                <div>
                    <div class="stat-value">${busCount}</div>
                    <div class="stat-label">Total Buses</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon stat-icon-orange">&#128506;</div>
                <div>
                    <div class="stat-value">${routeCount}</div>
                    <div class="stat-label">Total Routes</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon stat-icon-purple">&#128197;</div>
                <div>
                    <div class="stat-value">${scheduleCount}</div>
                    <div class="stat-label">Total Schedules</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon stat-icon-green">&#128100;</div>
                <div>
                    <div class="stat-value">${userCount}</div>
                    <div class="stat-label">Registered Users</div>
                </div>
            </div>
        </div>

        <div class="quick-actions">
            <p class="quick-actions-title">Quick Actions</p>
            <div class="quick-actions-row">
                <a href="${pageContext.request.contextPath}/admin/add-bus"    class="btn btn-primary">Add Bus</a>
                <a href="${pageContext.request.contextPath}/admin/bus-list"   class="btn btn-secondary">View Buses</a>
                <a href="${pageContext.request.contextPath}/admin/add-route"  class="btn btn-primary">Add Route</a>
                <a href="${pageContext.request.contextPath}/admin/route-list" class="btn btn-secondary">View Routes</a>
                <span class="btn btn-secondary nav-link-placeholder">Manage Users</span>
            </div>
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
