<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Bus — YatraGo Admin</title>
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
                <h1 class="admin-page-title">Add New Bus</h1>
                <p class="admin-page-subtitle">Register a new bus in the system</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/bus-list" class="btn btn-secondary">Back to List</a>
        </div>

        <div class="form-card">
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span class="alert-icon">&#9888;</span> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/add-bus" method="post" novalidate id="addBusForm">

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="busNumber">Bus Number *</label>
                        <input type="text" id="busNumber" name="busNumber" class="form-input"
                               placeholder="e.g. BA-1-KHA-1234" required autofocus>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="operatorName">Operator Name *</label>
                        <input type="text" id="operatorName" name="operatorName" class="form-input"
                               placeholder="e.g. Naya Yatayat" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="busType">Bus Type *</label>
                        <select id="busType" name="busType" class="form-input" required>
                            <option value="">Select Type</option>
                            <option value="AC Deluxe">AC Deluxe</option>
                            <option value="AC Sleeper">AC Sleeper</option>
                            <option value="Non-AC">Non-AC</option>
                            <option value="Tourist">Tourist</option>
                            <option value="Micro">Micro</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="totalSeats">Total Seats *</label>
                        <input type="number" id="totalSeats" name="totalSeats" class="form-input"
                               placeholder="e.g. 40" min="1" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="amenities">Amenities</label>
                    <input type="text" id="amenities" name="amenities" class="form-input"
                           placeholder="e.g. WiFi, USB charging, Snacks">
                    <span class="form-hint">Optional. Comma-separated list.</span>
                </div>

                <div class="form-group">
                    <label class="form-label" for="status">Status *</label>
                    <select id="status" name="status" class="form-input" required>
                        <option value="active">Active</option>
                        <option value="maintenance">Maintenance</option>
                        <option value="inactive">Inactive</option>
                    </select>
                </div>

                <div class="mt-3">
                    <button type="submit" class="btn btn-primary">Add Bus</button>
                    <a href="${pageContext.request.contextPath}/admin/bus-list"
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
    document.getElementById('addBusForm').addEventListener('submit', function (e) {
        var busNumber = document.getElementById('busNumber').value.trim();
        var operator  = document.getElementById('operatorName').value.trim();
        var busType   = document.getElementById('busType').value;
        var seats     = document.getElementById('totalSeats').value.trim();
        if (!busNumber || !operator || !busType || !seats) {
            e.preventDefault();
            alert('Please fill in all required fields.');
            return;
        }
        if (parseInt(seats) < 1) {
            e.preventDefault();
            alert('Total seats must be at least 1.');
        }
    });
}());
</script>

<c:if test="${not empty sessionScope.flashMessage}">
    <div id="flash-data" data-type="${sessionScope.flashType}" data-message="${sessionScope.flashMessage}" style="display:none;"></div>
    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>
<div id="toast-container"></div>
<script src="${pageContext.request.contextPath}/js/toasts.js"></script>

</body>
</html>
