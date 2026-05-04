<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Update Bus — YatraGo Admin</title>
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
                <h1 class="admin-page-title">Update Bus</h1>
                <p class="admin-page-subtitle">Editing: ${bus.busNumber}</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/bus-list" class="btn btn-secondary">Back to List</a>
        </div>

        <div class="form-card">
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span class="alert-icon">&#9888;</span> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/update-bus" method="post" novalidate id="updateBusForm">
                <input type="hidden" name="id" value="${bus.id}">

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="busNumber">Bus Number *</label>
                        <input type="text" id="busNumber" name="busNumber" class="form-input"
                               value="${bus.busNumber}" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="operatorName">Operator Name *</label>
                        <input type="text" id="operatorName" name="operatorName" class="form-input"
                               value="${bus.operatorName}" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="busType">Bus Type *</label>
                        <select id="busType" name="busType" class="form-input" required>
                            <option value="AC Deluxe"  <c:if test="${bus.busType == 'AC Deluxe'}">selected</c:if>>AC Deluxe</option>
                            <option value="AC Sleeper" <c:if test="${bus.busType == 'AC Sleeper'}">selected</c:if>>AC Sleeper</option>
                            <option value="Non-AC"     <c:if test="${bus.busType == 'Non-AC'}">selected</c:if>>Non-AC</option>
                            <option value="Tourist"    <c:if test="${bus.busType == 'Tourist'}">selected</c:if>>Tourist</option>
                            <option value="Micro"      <c:if test="${bus.busType == 'Micro'}">selected</c:if>>Micro</option>
                        </select>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="totalSeats">Total Seats *</label>
                        <input type="number" id="totalSeats" name="totalSeats" class="form-input"
                               value="${bus.totalSeats}" min="1" required>
                    </div>
                </div>

                <div class="form-group">
                    <label class="form-label" for="amenities">Amenities</label>
                    <input type="text" id="amenities" name="amenities" class="form-input"
                           value="${bus.amenities}">
                    <span class="form-hint">Optional — comma-separated list</span>
                </div>

                <div class="form-group">
                    <label class="form-label" for="status">Status *</label>
                    <select id="status" name="status" class="form-input" required>
                        <option value="active"      <c:if test="${bus.status == 'active'}">selected</c:if>>Active</option>
                        <option value="maintenance" <c:if test="${bus.status == 'maintenance'}">selected</c:if>>Maintenance</option>
                        <option value="inactive"    <c:if test="${bus.status == 'inactive'}">selected</c:if>>Inactive</option>
                    </select>
                </div>

                <div class="mt-3">
                    <button type="submit" class="btn btn-primary">Save Changes</button>
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
    document.getElementById('updateBusForm').addEventListener('submit', function (e) {
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

</body>
</html>
