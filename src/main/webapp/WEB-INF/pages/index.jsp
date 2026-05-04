<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YatraGo — Bus Booking Nepal</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<!-- Navigation -->
<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            Yatra<span>Go</span>
        </a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <c:choose>
                <c:when test="${not empty sessionScope.user}">
                    <li><span class="nav-greeting">Hi, ${sessionScope.user.name}</span></li>
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

<main>
    <!-- Hero -->
    <section class="hero">
        <div class="hero-inner">
            <span class="hero-badge">Nepal&#39;s Bus Booking Platform</span>
            <h1 class="hero-title">
                Travel <span>Nepal</span>,<br>the easy way.
            </h1>
            <p class="hero-subtitle">
                Search routes, pick your seat, and get your e-ticket in minutes.
                No queues, no guesswork — just travel.
            </p>
            <div class="hero-actions">
                <c:choose>
                    <c:when test="${sessionScope.user.role == 'admin'}">
                        <a href="${pageContext.request.contextPath}/admin/dashboard" class="btn btn-accent btn-lg">Go to Admin Dashboard</a>
                    </c:when>
                    <c:when test="${not empty sessionScope.user}">
                        <a href="${pageContext.request.contextPath}/profile" class="btn btn-accent btn-lg">My Profile</a>
                    </c:when>
                    <c:otherwise>
                        <a href="${pageContext.request.contextPath}/register" class="btn btn-accent btn-lg">Get Started</a>
                        <a href="${pageContext.request.contextPath}/login" class="btn btn-outline-white btn-lg">Sign In</a>
                    </c:otherwise>
                </c:choose>
            </div>
        </div>
    </section>

    <!-- Search hint — visual preview of the M2 search flow -->
    <section class="search-hint">
        <div class="search-hint-card">
            <div class="search-hint-field">
                <span class="search-hint-label">From</span>
                <div class="search-hint-input">Kathmandu</div>
            </div>
            <div class="search-hint-sep">&#8594;</div>
            <div class="search-hint-field">
                <span class="search-hint-label">To</span>
                <div class="search-hint-input">Pokhara</div>
            </div>
            <div class="search-hint-field">
                <span class="search-hint-label">Date</span>
                <div class="search-hint-input">May 4, 2026</div>
            </div>
            <div class="search-hint-actions">
                <button class="btn btn-primary" disabled style="opacity:.5;cursor:default;">Search Buses</button>
            </div>
            <p class="search-hint-note">&#128337; Full seat search coming soon</p>
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
                        Search available buses by route and date. Pick your seat and confirm in seconds.
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">&#127915;</div>
                    <h3 class="feature-title">Instant E-Tickets</h3>
                    <p class="feature-desc">
                        Get a digital ticket with your booking reference the moment you confirm. No printing needed.
                    </p>
                </div>
                <div class="feature-card">
                    <div class="feature-icon">&#128737;</div>
                    <h3 class="feature-title">Safe &amp; Verified</h3>
                    <p class="feature-desc">
                        Every bus and driver is registered and verified. Your journey and payment are protected.
                    </p>
                </div>
            </div>
        </div>
    </section>

    <!-- How it works -->
    <section class="how-it-works">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">How YatraGo works</h2>
                <p class="section-subtitle">Three steps to your next journey.</p>
            </div>
            <div class="steps-row">
                <div class="step">
                    <div class="step-number">1</div>
                    <h3 class="step-title">Search</h3>
                    <p class="step-desc">Choose your origin, destination, and travel date.</p>
                </div>
                <div class="step-connector"></div>
                <div class="step">
                    <div class="step-number">2</div>
                    <h3 class="step-title">Pick your seat</h3>
                    <p class="step-desc">Select from available seats and confirm your booking.</p>
                </div>
                <div class="step-connector"></div>
                <div class="step">
                    <div class="step-number">3</div>
                    <h3 class="step-title">Travel</h3>
                    <p class="step-desc">Show your e-ticket at the bus and enjoy the ride.</p>
                </div>
            </div>
        </div>
    </section>
</main>

<!-- Footer -->
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

</body>
</html>
