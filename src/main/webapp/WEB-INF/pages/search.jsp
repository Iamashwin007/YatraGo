<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Search Buses — YatraGo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">Yatra<span>Go</span></a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li><span class="nav-greeting">Hi, ${sessionScope.user.name}</span></li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Admin Dashboard</a></li>
                    </c:if>
                    <li><a href="${pageContext.request.contextPath}/search" class="nav-link active">Search</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile" class="nav-link">Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/search" class="nav-link active">Search</a></li>
                    <li><a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<main>
    <section class="search-hint" style="padding-top:4rem;padding-bottom:4rem;">
        <div class="container">
            <div class="section-header" style="margin-bottom:2rem;">
                <h1 class="section-title">Find Your Bus</h1>
                <p class="section-subtitle">Pick your route and travel date to see available buses</p>
            </div>

            <form id="searchForm" action="${pageContext.request.contextPath}/search" method="post" novalidate>
                <div class="search-hint-card">
                    <div class="search-hint-field">
                        <label class="search-hint-label" for="origin">From</label>
                        <select class="form-input" id="origin" name="origin">
                            <option value="">Select origin</option>
                            <c:forEach var="r" items="${routes}">
                                <option value="${r.origin}">${r.origin}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="search-hint-sep">&#8594;</div>

                    <div class="search-hint-field">
                        <label class="search-hint-label" for="destination">To</label>
                        <select class="form-input" id="destination" name="destination">
                            <option value="">Select destination</option>
                            <c:forEach var="r" items="${routes}">
                                <option value="${r.destination}">${r.destination}</option>
                            </c:forEach>
                        </select>
                    </div>

                    <div class="search-hint-field">
                        <label class="search-hint-label" for="journeyDate">Date</label>
                        <input class="form-input" type="date" id="journeyDate" name="journeyDate">
                    </div>

                    <div class="search-hint-actions">
                        <button type="submit" class="btn btn-primary btn-lg">Search Buses</button>
                    </div>
                </div>

                <p id="search-error" style="color:var(--clr-error);text-align:center;display:none;margin-top:1rem;font-size:0.9rem;font-weight:500;"></p>
            </form>
        </div>
    </section>
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span>Go</span></span>
    &copy; 2026 YatraGo. Built for Nepal.
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

<script>
(function () {
    var today    = new Date();
    var yyyy     = today.getFullYear();
    var mm       = String(today.getMonth() + 1).padStart(2, '0');
    var dd       = String(today.getDate()).padStart(2, '0');
    var todayStr = yyyy + '-' + mm + '-' + dd;

    var dateInput = document.getElementById('journeyDate');
    if (dateInput) dateInput.min = todayStr;

    var form  = document.getElementById('searchForm');
    var error = document.getElementById('search-error');

    form.addEventListener('submit', function (e) {
        var origin      = document.getElementById('origin').value;
        var destination = document.getElementById('destination').value;
        var date        = document.getElementById('journeyDate').value;

        if (!origin || !destination || !date) {
            e.preventDefault();
            error.textContent = 'Please select an origin, destination, and travel date.';
            error.style.display = 'block';
            return;
        }

        if (date < todayStr) {
            e.preventDefault();
            error.textContent = 'Travel date cannot be in the past.';
            error.style.display = 'block';
            return;
        }

        error.style.display = 'none';
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
