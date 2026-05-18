<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — YatraGo</title>
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
                    <li><a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<main class="auth-split">
    <div class="auth-panel-left">
        <div class="auth-panel-content">
            <a href="${pageContext.request.contextPath}/" class="auth-panel-logo">Yatra<span>Go</span></a>
            <h2 class="auth-panel-heading">Join YatraGo</h2>
            <p class="auth-panel-sub">Book your next Nepal bus journey in minutes.</p>
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
            <h1 class="auth-title">Create an account</h1>
            <p class="auth-subtitle">Join YatraGo and book smarter</p>

            <c:if test="${not empty error}">
                <div class="alert alert-error">
                    <span class="alert-icon">&#9888;</span>
                    <span>${error}</span>
                </div>
            </c:if>

            <form action="${pageContext.request.contextPath}/register" method="post" id="registerForm" novalidate>
                <div class="form-group">
                    <label class="form-label" for="name">Full name</label>
                    <div class="input-with-icon">
                        <span class="input-icon">&#128100;</span>
                        <input
                            class="form-input"
                            type="text"
                            id="name"
                            name="name"
                            placeholder="Ashwin Pokhrel"
                            required
                            autocomplete="name"
                            autofocus
                        >
                    </div>
                </div>
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
                            required
                            autocomplete="email"
                        >
                    </div>
                </div>
                <div class="form-group">
                    <label class="form-label" for="phone">Phone number</label>
                    <div class="input-with-icon">
                        <span class="input-icon">&#128222;</span>
                        <input
                            class="form-input"
                            type="tel"
                            id="phone"
                            name="phone"
                            placeholder="9800000000"
                            pattern="^9[0-9]{9}$"
                            title="Enter a valid Nepal phone number (10 digits starting with 9)"
                            required
                            autocomplete="tel"
                        >
                    </div>
                    <span class="form-hint">Nepal format: 10 digits starting with 9</span>
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
                            placeholder="Min 8 chars, letters &amp; numbers"
                            required
                            minlength="8"
                            autocomplete="new-password"
                        >
                        <button class="password-toggle" type="button" data-target="password" aria-label="Show password">&#128065;</button>
                    </div>
                    <div class="password-strength" aria-live="polite">
                        <span class="password-strength-bar"></span>
                    </div>
                    <span id="pwStrengthText" class="form-hint">Use at least 8 characters with letters and numbers.</span>
                </div>
                <div class="form-group">
                    <label class="form-label" for="confirmPassword">Confirm password</label>
                    <div class="input-with-icon">
                        <span class="input-icon">&#128274;</span>
                        <input
                            class="form-input"
                            type="password"
                            id="confirmPassword"
                            name="confirmPassword"
                            placeholder="Repeat your password"
                            required
                            autocomplete="new-password"
                        >
                        <button class="password-toggle" type="button" data-target="confirmPassword" aria-label="Show password">&#128065;</button>
                    </div>
                    <span id="pwMismatch" class="form-hint" style="color:var(--clr-error);display:none;">
                        Passwords do not match.
                    </span>
                </div>

                <button type="submit" class="btn btn-primary btn-block btn-lg">Create Account</button>
            </form>

            <p class="auth-footer">
                Already have an account? <a href="${pageContext.request.contextPath}/login">Sign in</a>
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

    var password = document.getElementById('password');
    var strength = document.querySelector('.password-strength');
    var strengthText = document.getElementById('pwStrengthText');
    if (password && strength && strengthText) {
        password.addEventListener('input', function () {
            var value = password.value;
            var score = 0;
            if (value.length >= 8) score++;
            if (/[A-Za-z]/.test(value)) score++;
            if (/[0-9]/.test(value)) score++;
            if (/[^A-Za-z0-9]/.test(value)) score++;
            strength.dataset.level = value.length ? String(score) : '0';
            strengthText.textContent = score <= 1 ? 'Weak password' : score === 2 ? 'Good start, add more variety.' : 'Strong password';
        });
    }

    document.getElementById('registerForm').addEventListener('submit', function (e) {
        var pw  = password.value;
        var cpw = document.getElementById('confirmPassword').value;
        var msg = document.getElementById('pwMismatch');
        if (pw !== cpw) {
            e.preventDefault();
            msg.style.display = 'block';
            document.getElementById('confirmPassword').focus();
        } else {
            msg.style.display = 'none';
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
