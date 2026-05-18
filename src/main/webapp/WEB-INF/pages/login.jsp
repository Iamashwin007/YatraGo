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
            <div class="auth-illustration" aria-hidden="true">
                <svg viewBox="0 0 320 220">
                    <path class="auth-road" d="M24 174 C88 132 143 204 208 158 C247 131 273 124 302 138"/>
                    <rect class="auth-bus-body" x="66" y="70" width="188" height="86" rx="20"/>
                    <path class="auth-bus-top" d="M92 52h116c20 0 39 14 46 34H70c4-20 10-34 22-34z"/>
                    <rect class="auth-window" x="90" y="82" width="42" height="30" rx="8"/>
                    <rect class="auth-window" x="142" y="82" width="42" height="30" rx="8"/>
                    <rect class="auth-window" x="194" y="82" width="36" height="30" rx="8"/>
                    <circle class="auth-wheel" cx="110" cy="156" r="16"/>
                    <circle class="auth-wheel" cx="214" cy="156" r="16"/>
                    <path class="auth-mountain" d="M18 70 L64 24 L112 78 L148 38 L204 94 L18 94z"/>
                    <circle class="auth-sun" cx="258" cy="44" r="18"/>
                </svg>
            </div>
            <div class="auth-feature-list">
                <span>Easy online booking</span>
                <span>Live seat selection</span>
                <span>Instant e-ticket</span>
                <span>Secure payment</span>
            </div>
        </div>
    </div>
    <div class="auth-panel-right">
        <div class="auth-card auth-glass-card">
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
                    <div class="input-with-icon">
                        <span class="input-icon">&#9993;</span>
                        <input
                            class="form-input"
                            type="email"
                            id="email"
                            name="email"
                            placeholder="you@gmail.com"
                            value="${not empty cookie.email ? cookie.email.value : ''}"
                            required
                            autocomplete="email"
                            autofocus
                        >
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label" for="password">Password</label>
                    <div class="input-with-icon">
                        <span class="input-icon">&#128274;</span>
                        <input
                            class="form-input"
                            type="password"
                            id="password"
                            name="password"
                            placeholder="Enter your password"
                            required
                            autocomplete="current-password"
                        >
                        <button class="password-toggle" type="button" data-target="password" aria-label="Show password">&#128065;</button>
                    </div>
                </div>
                <div class="auth-form-row">
                    <label class="remember-me">
                        <input type="checkbox" name="remember" value="true">
                        <span>Remember me</span>
                    </label>
                    <a href="#" class="forgot-link">Forgot password?</a>
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
    document.querySelectorAll('.password-toggle').forEach(function (button) {
        button.addEventListener('click', function () {
            var input = document.getElementById(button.getAttribute('data-target'));
            if (!input) return;
            input.type = input.type === 'password' ? 'text' : 'password';
            button.classList.toggle('is-visible', input.type === 'text');
        });
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
