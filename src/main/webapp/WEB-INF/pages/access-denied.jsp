<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Access Denied — YatraGo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .access-page {
            min-height: calc(100vh - var(--nav-h));
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 1.5rem;
        }
        .access-card {
            max-width: 560px;
            text-align: center;
        }
        .access-code {
            font-size: clamp(3.5rem, 7vw, 5rem);
            font-weight: 800;
            color: var(--clr-primary);
            margin-bottom: 0.5rem;
        }
        .access-title {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--clr-text);
            margin-bottom: 0.5rem;
        }
        .access-subtitle {
            font-size: 1rem;
            color: var(--clr-text-muted);
            margin-bottom: 0.75rem;
        }
        .access-desc {
            font-size: 0.9375rem;
            color: var(--clr-text-muted);
            margin-bottom: 1.75rem;
            line-height: 1.6;
        }
        .access-actions {
            display: flex;
            gap: 0.75rem;
            justify-content: center;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">Yatra<span>Go</span></a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <li><a href="${pageContext.request.contextPath}/" class="nav-link">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/about" class="nav-link">About</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/contact" class="nav-link">Contact</a></li>
            <c:if test="${not empty sessionScope.user and sessionScope.user.role == 'admin'}">
                <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Admin Dashboard</a></li>
            </c:if>
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li><a href="${pageContext.request.contextPath}/search" class="nav-link">Search</a></li>
                    <li><a href="${pageContext.request.contextPath}/my-bookings" class="nav-link">My Bookings</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile" class="nav-link">Profile</a></li>
                    <li><span class="nav-greeting">Hi, ${sessionScope.user.name}</span></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<main>
    <div class="access-page">
        <div class="card access-card">
            <div class="access-code">403</div>
            <h1 class="access-title">Access Denied</h1>
            <p class="access-subtitle">You don't have permission to view this page.</p>
            <p class="access-desc">
                This area is restricted to administrators only. If you believe this is a mistake, please contact support.
            </p>
            <div class="access-actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn--primary">Go to Home</a>
                <a href="${pageContext.request.contextPath}/logout" class="btn btn--danger">Logout</a>
            </div>
        </div>
    </div>
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

<c:if test="${not empty sessionScope.flashMessage}">
    <div id="flash-data" data-type="${sessionScope.flashType}" data-message="${sessionScope.flashMessage}" style="display:none;"></div>
    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>
<div id="toast-container"></div>
<script src="${pageContext.request.contextPath}/js/toasts.js"></script>

</body>
</html>
