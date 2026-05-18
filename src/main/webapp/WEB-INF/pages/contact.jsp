<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>Contact - YatraGo</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body>

<nav class="navbar">
    <div class="container">
        <a href="<%= request.getContextPath() %>/" class="navbar-brand">Yatra<span>Go</span></a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <li><a href="<%= request.getContextPath() %>/" class="nav-link">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/about" class="nav-link">About</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/contact" class="nav-link active">Contact</a></li>
            <li><a href="<%= request.getContextPath() %>/login" class="nav-link">Login</a></li>
            <li><a href="<%= request.getContextPath() %>/register" class="nav-link nav-link-cta">Register</a></li>
        </ul>
    </div>
</nav>

<main class="subpage-main">
    <section class="subpage-hero">
        <div class="container subpage-hero-inner">
            <span class="hero-badge">Contact YatraGo</span>
            <h1>Need help with your journey?</h1>
            <p>Have questions about routes, bookings, or support? We are here to help you travel better across Nepal.</p>
        </div>
    </section>

    <section class="subpage-section">
        <div class="container">
            <h2 class="section-title">Get In Touch</h2>
            <div class="contact-layout">
                <div class="contact-info">
                    <div class="info-list">
                        <article class="info-card"><div class="icon-dot">&#128205;</div><div><h4>Office</h4><p>Kathmandu, Nepal</p></div></article>
                        <article class="info-card"><div class="icon-dot">&#128222;</div><div><h4>Phone</h4><p>+977-1-XXXXXXX</p></div></article>
                        <article class="info-card"><div class="icon-dot">&#9993;</div><div><h4>Email</h4><p>support@yatrago.com</p></div></article>
                        <article class="info-card"><div class="icon-dot">&#128338;</div><div><h4>Support Hours</h4><p>Sun - Fri, 8:00 AM - 8:00 PM</p></div></article>
                    </div>
                </div>

                <div class="contact-form-wrap">
                    <form action="<%= request.getContextPath() %>/contact" method="post">
                        <div class="field"><label for="name">Full Name</label><input id="name" name="name" type="text" placeholder="Enter your name" required /></div>
                        <div class="field"><label for="email">Email Address</label><input id="email" name="email" type="email" placeholder="Enter your email" required /></div>
                        <div class="field"><label for="subject">Subject</label><input id="subject" name="subject" type="text" placeholder="How can we help?" required /></div>
                        <div class="field"><label for="message">Message</label><textarea id="message" name="message" placeholder="Write your message here..." required></textarea></div>
                        <button type="submit" class="btn btn-accent">Send Message</button>
                    </form>
                </div>
            </div>
        </div>
    </section>
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span>Go</span></span>
    &copy; 2026 YatraGo. Built for Nepal.
</footer>

<c:if test="${not empty sessionScope.flashMessage}">
    <div id="flash-data" data-type="${sessionScope.flashType}" data-message="${sessionScope.flashMessage}" style="display:none;"></div>
    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>
<div id="toast-container"></div>
<script src="<%= request.getContextPath() %>/js/toasts.js"></script>

<script>
(function () {
    var nav = document.querySelector('.navbar');
    var toggle = document.getElementById('navToggle');
    var menu = document.getElementById('mainNav');
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
