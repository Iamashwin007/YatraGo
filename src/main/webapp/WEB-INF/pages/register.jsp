<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Register — YatraGo</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">Yatra<span>Go</span></a>
        <ul class="navbar-nav">
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

<main class="auth-page">
    <div class="auth-card">
        <a href="${pageContext.request.contextPath}/" class="auth-logo">Yatra<span>Go</span></a>
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
                <input
                    class="form-input"
                    type="text"
                    id="name"
                    name="name"
                    placeholder="Ashwin Pokhrel"
                    required
                    autocomplete="name"
                >
            </div>
            <div class="form-group">
                <label class="form-label" for="email">Email address</label>
                <input
                    class="form-input"
                    type="email"
                    id="email"
                    name="email"
                    placeholder="you@example.com"
                    required
                    autocomplete="email"
                >
            </div>
            <div class="form-group">
                <label class="form-label" for="phone">Phone number</label>
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
                <span class="form-hint">Nepal format: 10 digits starting with 9</span>
            </div>
            <div class="form-group">
                <label class="form-label" for="password">Password</label>
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
            </div>
            <div class="form-group">
                <label class="form-label" for="confirmPassword">Confirm password</label>
                <input
                    class="form-input"
                    type="password"
                    id="confirmPassword"
                    name="confirmPassword"
                    placeholder="Repeat your password"
                    required
                    autocomplete="new-password"
                >
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
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span style="color:#e85d04;">Go</span></span>
    &copy; 2026 YatraGo. Built for Nepal.
</footer>

<script>
    document.getElementById('registerForm').addEventListener('submit', function (e) {
        var pw  = document.getElementById('password').value;
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
</script>

</body>
</html>
