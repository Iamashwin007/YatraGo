<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>YatraGo &mdash; Bus Booking Nepal</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800;900&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<nav class="navbar">
    <div class="container">
        <a href="${pageContext.request.contextPath}/" class="navbar-brand">
            Yatra<span>Go</span>
        </a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <li><a href="${pageContext.request.contextPath}/" class="nav-link">Home</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/about" class="nav-link">About</a></li>
            <li><a href="${pageContext.request.contextPath}/pages/contact" class="nav-link">Contact</a></li>
            <li><a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a></li>
            <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
        </ul>
    </div>
</nav>

<main>
    <section class="hero">
        <div class="hero-bg-line hero-bg-line-1"></div>
        <div class="hero-bg-line hero-bg-line-2"></div>
        <div class="hero-inner">
            <div class="hero-copy">
                <span class="hero-badge">Nepal&#39;s Bus Booking Platform</span>
                <h1 class="hero-title">Travel <span>Nepal</span>,<br>the easy way.</h1>
                <p class="hero-subtitle">
                    Search routes, pick your seat, and get your e-ticket in minutes.
                    No queues, no guesswork. Just travel.
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
            <div class="hero-media">
                <div class="hero-image-card">
                    <img src="${pageContext.request.contextPath}/images/home-bus.png" alt="YatraGo bus booking illustration">
                    <div class="hero-image-badge">
                        <span>Live Seat Booking</span>
                        <strong>Available soon</strong>
                    </div>
                </div>
            </div>
        </div>
    </section>

    <section class="search-hint">
        <div class="search-hint-card">
            <div class="search-hint-field">
                <span class="search-hint-icon">&#128205;</span>
                <span class="search-hint-label">From</span>
                <div class="search-hint-input">Kathmandu</div>
            </div>
            <div class="search-hint-sep">&#8594;</div>
            <div class="search-hint-field">
                <span class="search-hint-icon">&#127937;</span>
                <span class="search-hint-label">To</span>
                <div class="search-hint-input">Pokhara</div>
            </div>
            <div class="search-hint-field">
                <span class="search-hint-icon">&#128197;</span>
                <span class="search-hint-label">Date</span>
                <div class="search-hint-input">May 4, 2026</div>
            </div>
            <div class="search-hint-actions">
                <button class="btn btn-primary">Search Bus</button>
            </div>
        </div>
    </section>

    <section class="trust-section">
        <div class="container trust-grid">
            <div class="trust-card"><div class="trust-icon">&#128652;</div><strong>10,000+ Happy Travelers</strong><span>Trusted by frequent riders</span></div>
            <div class="trust-card"><div class="trust-icon">&#129309;</div><strong>50+ Bus Partners</strong><span>Verified route operators</span></div>
            <div class="trust-card"><div class="trust-icon">&#128274;</div><strong>Secure Payments</strong><span>Protected booking flow</span></div>
            <div class="trust-card"><div class="trust-icon">&#128179;</div><strong>Live Seat Booking</strong><span>Pick seats before travel</span></div>
        </div>
    </section>

    <section class="popular-routes">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Popular routes in Nepal</h2>
                <p class="section-subtitle">Fast access to the journeys travelers book most.</p>
            </div>
            <div class="routes-grid">
                <div class="route-card">
                    <div class="route-top"><span class="route-badge">Tourist Bus</span><strong>Rs. 1,200</strong></div>
                    <h3>Kathmandu <span>&#8594;</span> Pokhara</h3>
                    <p>6-7 hrs travel time</p>
                </div>
                <div class="route-card">
                    <div class="route-top"><span class="route-badge">Deluxe</span><strong>Rs. 950</strong></div>
                    <h3>Kathmandu <span>&#8594;</span> Chitwan</h3>
                    <p>5-6 hrs travel time</p>
                </div>
                <div class="route-card">
                    <div class="route-top"><span class="route-badge">AC Coach</span><strong>Rs. 1,450</strong></div>
                    <h3>Butwal <span>&#8594;</span> Kathmandu</h3>
                    <p>8-9 hrs travel time</p>
                </div>
            </div>
        </div>
    </section>

    <section class="features">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Everything you need to travel smarter</h2>
                <p class="section-subtitle">Designed for quick booking, clear information, and reliable journeys.</p>
            </div>
            <div class="features-grid">
                <div class="feature-card"><div class="feature-icon">&#128652;</div><h3 class="feature-title">Online booking</h3><p class="feature-desc">Search available buses by route and date. Pick your seat and confirm in seconds.</p></div>
                <div class="feature-card"><div class="feature-icon">&#128186;</div><h3 class="feature-title">Live seat selection</h3><p class="feature-desc">View seat layouts and reserve your preferred seat before you travel.</p></div>
                <div class="feature-card"><div class="feature-icon">&#127915;</div><h3 class="feature-title">Instant e-ticket</h3><p class="feature-desc">Get a digital ticket with your booking reference the moment you confirm. No printing needed.</p></div>
                <div class="feature-card"><div class="feature-icon">&#127911;</div><h3 class="feature-title">24/7 support</h3><p class="feature-desc">Get booking help and trip support whenever your travel plan changes.</p></div>
            </div>
        </div>
    </section>

    <section class="testimonials">
        <div class="container">
            <div class="section-header">
                <h2 class="section-title">Travelers trust YatraGo</h2>
                <p class="section-subtitle">Clean booking, clear tickets, and smoother trips across Nepal.</p>
            </div>
            <div class="testimonial-grid">
                <div class="testimonial-card"><div class="testimonial-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div><p>"Booking Kathmandu to Pokhara felt simple and fast. The route details were clear before payment."</p><strong>Asmita K.</strong><span>Pokhara traveler</span></div>
                <div class="testimonial-card"><div class="testimonial-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div><p>"The interface is clean and easy to understand. I could find the right bus without calling agents."</p><strong>Rajan M.</strong><span>Daily commuter</span></div>
                <div class="testimonial-card"><div class="testimonial-stars">&#9733;&#9733;&#9733;&#9733;&#9733;</div><p>"Instant tickets and verified buses make the trip feel more reliable, especially for family travel."</p><strong>Nisha T.</strong><span>Chitwan route</span></div>
            </div>
        </div>
    </section>
</main>

<footer class="footer">
    <div class="container footer-grid">
        <div class="footer-about">
            <span class="footer-brand">Yatra<span>Go</span></span>
            <p>Modern bus booking for Nepal with verified routes, simple tickets, and smoother travel planning.</p>
            <div class="footer-social">
                <a href="#" aria-label="Facebook">f</a>
                <a href="#" aria-label="Instagram">ig</a>
                <a href="#" aria-label="Twitter">x</a>
            </div>
        </div>
        <div><h3>About</h3><a href="#">Company</a><a href="#">How it works</a><a href="#">Bus partners</a></div>
        <div><h3>Routes</h3><a href="#">Kathmandu to Pokhara</a><a href="#">Kathmandu to Chitwan</a><a href="#">Butwal to Kathmandu</a></div>
        <div><h3>Contact</h3><a href="#">support@yatrago.com</a><a href="#">Privacy Policy</a><a href="#">Terms</a></div>
    </div>
    <div class="footer-bottom">&copy; 2026 YatraGo. Built for Nepal.</div>
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
