<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — YatraGo</title>
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
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Admin Dashboard</a></li>
                    </c:if>
                    <li><a href="${pageContext.request.contextPath}/profile" class="nav-link">Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<main class="auth-split">
    <div class="auth-panel-left">
        <div class="auth-panel-content">
            <a href="${pageContext.request.contextPath}/" class="auth-panel-logo">Yatra<span>Go</span></a>
            <h2 class="auth-panel-heading">Welcome back to YatraGo</h2>
            <p class="auth-panel-sub">Nepal's smartest way to book your bus journey.</p>
            <div class="auth-panel-illus">&#128652;</div>
        </div>
    </div>
    <div class="auth-panel-right">
        <div class="auth-panel-content">
            <h1 class="auth-title">Sign in</h1>
            <p class="auth-subtitle">Enter your details to continue</p>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span class="alert-icon">&#9888;</span>
                    <span>${error}</span>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/login" method="post" novalidate>
                <div class="form-group">
                    <label class="form-label" for="email">Email address</label>
                    <input
                        class="form-input"
                        type="email"
                        id="email"
                        name="email"
                        placeholder="you@example.com"
                        value="${not empty cookie.email ? cookie.email.value : ''}"
                        required
                        autocomplete="email"
                        autofocus
                    >
                </div>
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <input
                        class="form-input"
                        type="password"
                        id="password"
                        name="password"
                        placeholder="Enter your password"
                        required
                        autocomplete="current-password"
                    >
                </div>
                <button type="submit" class="btn btn-primary btn-block btn-lg">Sign In</button>
            </form>

            <p class="auth-footer">
                Don&apos;t have an account?
                <a href="${pageContext.request.contextPath}/register">Create one</a>
            </p>
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
