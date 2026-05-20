<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">Yatra<span>Go</span></a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <c:choose>
                <c:when test="${not empty sessionScope.user and sessionScope.user.role == 'admin'}">
                    <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Admin Dashboard</a></li>
                    <li><span class="nav-greeting">Hi, ${sessionScope.user.name}</span></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
                </c:when>
                <c:when test="${not empty sessionScope.user}">
                    <li><a href="${pageContext.request.contextPath}/" class="nav-link">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/about" class="nav-link">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/contact" class="nav-link">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/search" class="nav-link">Search</a></li>
                    <li><a href="${pageContext.request.contextPath}/my-bookings" class="nav-link">My Bookings</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile" class="nav-link">Profile</a></li>
                    <li><span class="nav-greeting">Hi, ${sessionScope.user.name}</span></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/" class="nav-link">Home</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/about" class="nav-link">About</a></li>
                    <li><a href="${pageContext.request.contextPath}/pages/contact" class="nav-link">Contact</a></li>
                    <li><a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>
