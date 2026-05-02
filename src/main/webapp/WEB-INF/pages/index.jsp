<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YatraGo — Bus Booking Nepal</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<!-- Navigation -->
<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            Yatra<span>Go</span>
        </a>
        <ul class="navbar-nav">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li><span class="nav-greeting">Hi, ${sessionScope.user.name}</span></li>
                    <c:if test="${sessionScope.user.role == 'admin'}">
                        <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Dashboard</a></li>
                    </c:if>
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
    <!-- Hero -->
    <section class="hero">
        <div class="hero-inner">
            <span class="hero-badge">Nepal&#39;s Bus Booking Platform</span>
            <h1 class="hero-title">
                Book your bus journey<br>across <span>Nepal</span>
            </h1>
            <p class="hero-subtitle">
                Search routes, choose your seat, and get your e-ticket — all in minutes.
                No queues, no guesswork.
            </p>
            <div class="hero-actions">
                <a href="${pageContext.request.contextPath}/register" class="btn btn-accent btn-lg">Get Started</a>
                <a href="${pageContext.request.contextPath}/login"    class="btn btn-outline-white btn-lg">Sign In</a>
            </div>
        </div>
    </section>

    <!-- Features -->
    <section class="features">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Everything you need to travel smarter</h2>
                <p class="section-subtitle">From Kathmandu to Pokhara and beyond — YatraGo has you covered.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card">
                    <div class="feature-icon">&#128652;</div>
                    <h3 class="feature-title">Easy Bus Booking</h3>
                    <p class="feature-desc">
                        Search available buses by route and date. Pick your seat on an interactive
                        map and confirm in seconds.
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">&#127915;</div>
                    <h3 class="feature-title">Instant E-Tickets</h3>
                    <p class="feature-desc">
                        Get a digital ticket with your booking reference the moment you confirm.
                        No printing needed — show it at boarding.
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">&#128737;</div>
                    <h3 class="feature-title">Safe &amp; Verified</h3>
                    <p class="feature-desc">
                        Every bus and driver is registered and verified. Your journey details
                        and payment are protected end-to-end.
                    </p>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
<footer class="footer">
    <span class="footer-brand">Yatra<span style="color:#e85d04;">Go</span></span>
    &copy; 2026 YatraGo. Built for Nepal.
</footer>

</body>
</html>
