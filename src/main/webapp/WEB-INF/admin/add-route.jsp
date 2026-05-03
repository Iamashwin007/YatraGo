<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Add Route — YatraGo Admin</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<nav class="navbar admin-navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            Yatra<span>Go</span><span class="admin-panel-badge">Admin</span>
        </a>
        <ul class="navbar-nav">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard"  class="nav-link">Dashboard</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/bus-list"   class="nav-link">Buses</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/route-list" class="nav-link active">Routes</a></li>
            <li><a href="${pageContext.request.contextPath}/admin/schedule-list" class="nav-link">Schedules</a></li>
            <li><a href="${pageContext.request.contextPath}/logout"           class="nav-link">Logout</a></li>
        </ul>
    </div>
</nav>

<main>
    <div class="admin-content">

        <div class="admin-page-header">
            <div>
                <h1 class="admin-page-title">Add New Route</h1>
                <p class="admin-page-subtitle">Register a new bus route in the system</p>
            </div>
            <a href="${pageContext.request.contextPath}/admin/route-list" class="btn btn-secondary">Back to List</a>
        </div>

        <div class="form-card">
            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span class="alert-icon">&#9888;</span> ${error}
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/admin/add-route" method="post" novalidate id="addRouteForm">

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="origin">Origin *</label>
                        <input type="text" id="origin" name="origin" class="form-input"
                               placeholder="e.g. Kathmandu" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="destination">Destination *</label>
                        <input type="text" id="destination" name="destination" class="form-input"
                               placeholder="e.g. Pokhara" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="distanceKm">Distance (km) *</label>
                        <input type="number" id="distanceKm" name="distanceKm" class="form-input"
                               placeholder="e.g. 200.50" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="durationHours">Duration (hours) *</label>
                        <input type="number" id="durationHours" name="durationHours" class="form-input"
                               placeholder="e.g. 6.5" step="0.01" min="0" required>
                    </div>
                </div>

                <div class="form-row">
                    <div class="form-group">
                        <label class="form-label" for="baseFare">Base Fare (NPR) *</label>
                        <input type="number" id="baseFare" name="baseFare" class="form-input"
                               placeholder="e.g. 800.00" step="0.01" min="0" required>
                    </div>
                    <div class="form-group">
                        <label class="form-label" for="status">Status *</label>
                        <select id="status" name="status" class="form-input" required>
                            <option value="active">Active</option>
                            <option value="inactive">Inactive</option>
                        </select>
                    </div>
                </div>

                <div class="mt-3">
                    <button type="submit" class="btn btn-primary">Add Route</button>
                    <a href="${pageContext.request.contextPath}/admin/route-list"
                       class="btn btn-secondary" style="margin-left:0.5rem;">Cancel</a>
                </div>
            </form>
        </div>

    </div>
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span style="color:#e85d04;">Go</span></span>
    &copy; 2026 YatraGo. Admin Panel.
</footer>

<script>
    document.getElementById('addRouteForm').addEventListener('submit', function (e) {
        var origin      = document.getElementById('origin').value.trim();
        var destination = document.getElementById('destination').value.trim();
        var distance    = document.getElementById('distanceKm').value.trim();
        var duration    = document.getElementById('durationHours').value.trim();
        var fare        = document.getElementById('baseFare').value.trim();

        if (!origin || !destination || !distance || !duration || !fare) {
            e.preventDefault();
            alert('Please fill in all required fields.');
            return;
        }
        if (parseFloat(distance) < 0 || parseFloat(duration) < 0 || parseFloat(fare) < 0) {
            e.preventDefault();
            alert('Distance, duration, and fare must be non-negative.');
        }
    });
</script>

</body>
</html>
