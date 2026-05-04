<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Profile — YatraGo</title>
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
                    <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<main class="auth-page">
    <div class="auth-card">
        <h1 class="auth-title">My Profile</h1>
        <p class="auth-subtitle">Your account details</p>

        <div class="profile-info">
            <div class="profile-row">
                <span class="profile-label">Name</span>
                <span class="profile-value">${sessionScope.user.name}</span>
            </div>
            <div class="profile-row">
                <span class="profile-label">Email</span>
                <span class="profile-value">${sessionScope.user.email}</span>
            </div>
            <div class="profile-row">
                <span class="profile-label">Role</span>
                <span class="profile-value">
                    <c:choose>
                        <c:when test="${sessionScope.user.role == 'admin'}">Admin</c:when>
                        <c:otherwise>User</c:otherwise>
                    </c:choose>
                </span>
            </div>
            <div class="profile-row">
                <span class="profile-label">Joined</span>
                <span class="profile-value">
                    <fmt:formatDate value="${sessionScope.user.createdAt}" pattern="MMMM d, yyyy" />
                </span>
            </div>
        </div>
    </div>
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span style="color:#e85d04;">Go</span></span>
    &copy; 2026 YatraGo. Built for Nepal.
</footer>

</body>
</html>
