<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Login — YatraGo</title>
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
                    <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<main class="auth-page">
    <div class="auth-card">
        <a href="${pageContext.request.contextPath}/" class="auth-logo">Yatra<span>Go</span></a>
        <h1 class="auth-title">Welcome back</h1>
        <p class="auth-subtitle">Sign in to your account to continue</p>

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
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span style="color:#e85d04;">Go</span></span>
    &copy; 2026 YatraGo. Built for Nepal.
</footer>

</body>
</html>
