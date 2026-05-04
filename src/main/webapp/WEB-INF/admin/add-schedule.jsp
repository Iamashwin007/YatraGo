<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Schedule — YatraGo Admin</title>
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
                <h1 class="admin-page-title">Add New Schedule</h1>
                <p class="admin-page-subtitle">Assign a bus to a route on a specific date</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/schedule-list" class="btn btn-secondary">Back to List</a>
        </div>

        <div class="form-card">
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span class="alert-icon">&#9888;</span> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/add-schedule" method="post" novalidate id="addScheduleForm">

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="busId">Bus *</label>
                        <select id="busId" name="busId" class="form-input" required>
                            <option value="">-- Select Bus --</option>
                            <c:forEach var="bus" items="${buses}">
                                <option value="${bus.id}">${bus.busNumber} — ${bus.operatorName}</option>
                            </c:forEach>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="routeId">Route *</label>
                        <select id="routeId" name="routeId" class="form-input" required>
                            <option value="">-- Select Route --</option>
                            <c:forEach var="route" items="${routes}">
                                <option value="${route.id}">${route.origin} &rarr; ${route.destination}</option>
                            </c:forEach>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="journeyDate">Journey Date *</label>
                        <input type="date" id="journeyDate" name="journeyDate" class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="status">Status *</label>
                        <select id="status" name="status" class="form-input" required>
                            <option value="scheduled">Scheduled</option>
                            <option value="running">Running</option>
                            <option value="completed">Completed</option>
                            <option value="cancelled">Cancelled</option>
                        </select>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="departureTime">Departure Time *</label>
                        <input type="time" id="departureTime" name="departureTime" class="form-input" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="arrivalTime">Arrival Time *</label>
                        <input type="time" id="arrivalTime" name="arrivalTime" class="form-input" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="fare">Fare (NPR) *</label>
                        <input type="number" id="fare" name="fare" class="form-input"
                               placeholder="e.g. 900.00" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="availableSeats">Available Seats *</label>
                        <input type="number" id="availableSeats" name="availableSeats" class="form-input"
                               placeholder="e.g. 40" min="0" required>
                    </div>
                </div>

                <div class="mt-3">
                    <button type="submit" class="btn btn-primary">Add Schedule</button>
                    <a href="${pageContext.request.contextPath}/admin/schedule-list"
                       class="btn btn-secondary" style="margin-left:0.5rem;">Cancel</a>
                </div>
            </form>
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
    document.getElementById('addScheduleForm').addEventListener('submit', function (e) {
        var busId   = document.getElementById('busId').value;
        var routeId = document.getElementById('routeId').value;
        var date    = document.getElementById('journeyDate').value.trim();
        var depart  = document.getElementById('departureTime').value.trim();
        var arrive  = document.getElementById('arrivalTime').value.trim();
        var fare    = document.getElementById('fare').value.trim();
        var seats   = document.getElementById('availableSeats').value.trim();
        if (!busId || !routeId || !date || !depart || !arrive || !fare || !seats) {
            e.preventDefault();
            alert('Please fill in all required fields.');
        }
    });
}());
</script>

</body>
</html>
