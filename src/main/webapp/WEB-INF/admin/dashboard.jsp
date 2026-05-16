<%@ page contentType="text/html;charset=UTF-8" %>
<%-- JSTL core: gives us <c:forEach>, <c:if>, <c:choose> for loops and conditional logic in the JSP. --%>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%-- JSTL fmt: gives us <fmt:formatNumber> to format the revenue figure with commas and no decimal places. --%>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Admin Dashboard — YatraGo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <%-- pageContext.request.contextPath is the app's root path on the server (e.g. /yatrago).
         Using it instead of a hardcoded "/" means all links still work if Tomcat deploys the app in a sub-folder. --%>
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
                <%-- sessionScope.user is the UserModel object the LoginServlet stored in the session.
                     Reading .name from it here personalises the greeting without another database call. --%>
                <p class="admin-page-subtitle">Welcome back, ${sessionScope.user.name}</p>
            </div>
        </div>

        <%-- System stats grid: each ${...} value was placed on the request by AdminDashboardServlet
             using req.setAttribute(). The HTML entity codes (e.g. &#128652;) are standard Unicode
             emoji rendered as icons — they are not broken characters. --%>
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

        <p class="quick-actions-title">Bookings &amp; Revenue</p>

        <div class="stat-grid">
            <div class="stat-card">
                <div class="stat-icon stat-icon-blue">&#128203;</div>
                <div>
                    <div class="stat-value">${totalBookings}</div>
                    <div class="stat-label">Total Bookings</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon stat-icon-green">&#9989;</div>
                <div>
                    <div class="stat-value">${confirmedBookings}</div>
                    <div class="stat-label">Confirmed Bookings</div>
                </div>
            </div>
            <div class="stat-card">
                <div class="stat-icon stat-icon-orange">&#128176;</div>
                <div>
                    <%-- fmt:formatNumber adds thousand-separator commas and maxFractionDigits="0"
                         removes the decimal places — so 150000.0 displays as "NPR 150,000". --%>
                    <div class="stat-value">NPR <fmt:formatNumber value="${totalRevenue}" maxFractionDigits="0" /></div>
                    <div class="stat-label">Total Revenue</div>
                </div>
            </div>
        </div>

        <div class="table-card" style="margin-bottom: 2rem;">
            <div style="padding: 1.25rem 1.125rem;">
                <p class="quick-actions-title">Bookings per Route</p>
            </div>
            <table class="data-table">
                <thead>
                    <tr>
                        <th>Route</th>
                        <th>Bookings</th>
                    </tr>
                </thead>
                <tbody>
                    <%-- c:choose works like if/else: c:when is the "if" branch, c:otherwise is the "else".
                         We use it (rather than just c:if) because we need TWO outcomes:
                         show a "no bookings" message OR render the data rows — never both. --%>
                    <c:choose>
                        <c:when test="${empty bookingsPerRoute}">
                            <tr>
                                <td colspan="2" style="text-align: center; color: var(--clr-text-muted);">No bookings yet</td>
                            </tr>
                        </c:when>
                        <c:otherwise>
                            <%-- Each "row" is a String[] returned by BookingDAO.getBookingsPerRoute().
                                 row[0] = route label (e.g. "Kathmandu to Pokhara"), row[1] = booking count. --%>
                            <c:forEach var="row" items="${bookingsPerRoute}">
                                <tr>
                                    <td>${row[0]}</td>
                                    <td>${row[1]}</td>
                                </tr>
                            </c:forEach>
                        </c:otherwise>
                    </c:choose>
                </tbody>
            </table>
        </div>

        <div class="quick-actions">
            <p class="quick-actions-title">Quick Actions</p>
            <div class="quick-actions-row">
                <a href="${pageContext.request.contextPath}/admin/add-bus"    class="btn btn-primary">Add Bus</a>
                <a href="${pageContext.request.contextPath}/admin/bus-list"   class="btn btn-secondary">View Buses</a>
                <a href="${pageContext.request.contextPath}/admin/add-route"  class="btn btn-primary">Add Route</a>
                <a href="${pageContext.request.contextPath}/admin/route-list" class="btn btn-secondary">View Routes</a>
                <%-- "Manage Users" is a <span>, not an <a>, because user management is not yet
                     implemented in Milestone 1. The span keeps the layout consistent without
                     linking to a page that doesn't exist yet. --%>
                <span class="btn btn-secondary nav-link-placeholder">Manage Users</span>
            </div>
        </div>

    </div>
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span>Go</span></span>
    &copy; 2026 YatraGo. Admin Panel.
</footer>

<%-- JavaScript for two navbar behaviours:
     1. Adds a "scrolled" CSS class to the navbar when the user scrolls down (CSS uses this to add a shadow).
     2. Toggles the mobile hamburger menu open and closed on click.
     The whole block is wrapped in an IIFE (a function that calls itself immediately) so the local
     variables (nav, toggle, menu) don't accidentally overwrite anything in the global window scope. --%>
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

<%-- Flash message system: a servlet calls FlashUtil.setMessage() to store a one-time message in the session.
     The hidden div carries the message as data attributes; toasts.js reads those attributes and renders
     a visible toast notification — the div itself is never shown (display:none).
     <c:remove> clears the message from the session right away so it only appears once, not on every reload. --%>
<c:if test="${not empty sessionScope.flashMessage}">
    <div id="flash-data" data-type="${sessionScope.flashType}" data-message="${sessionScope.flashMessage}" style="display:none;"></div>
    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>
<%-- toast-container is the empty div that toasts.js injects the visible notification elements into. --%>
<div id="toast-container"></div>
<script src="${pageContext.request.contextPath}/js/toasts.js"></script>

</body>
</html>
