<%@ page contentType="text/html;charset=UTF-8" %>
<nav class="navbar admin-navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            Yatra<span>Go</span><span class="admin-panel-badge">Admin</span>
        </a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"
                   class="nav-link${param.activeNav == 'dashboard' ? ' active' : ''}">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bus-list"
                   class="nav-link${param.activeNav == 'buses' ? ' active' : ''}">Buses</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/route-list"
                   class="nav-link${param.activeNav == 'routes' ? ' active' : ''}">Routes</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/schedule-list"
                   class="nav-link${param.activeNav == 'schedules' ? ' active' : ''}">Schedules</a></li>
            <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
        </ul>
    </div>
</nav>