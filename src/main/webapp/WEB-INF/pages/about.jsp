<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>About - YatraGo</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<main class="subpage-main">
    <section class="subpage-hero">
        <div class="container subpage-hero-inner">
            <span class="hero-badge">About YatraGo</span>
            <h1>Built for smoother bus travel across <span>Nepal</span>.</h1>
            <p>Your trusted companion for safe, affordable, and comfortable bus travel across Nepal.</p>
        </div>
    </section>

    <section class="subpage-section">
        <div class="container story-grid">
            <div class="story-text">
                <h2 class="section-title">Our Story</h2>
                <p>YatraGo was founded to simplify bus travel in Nepal and make journey planning easier for everyone.</p>
                <p>We connect passengers to routes across the country with a simple, reliable booking experience built around convenience and trust.</p>
                <p>From city rides to long-distance trips, YatraGo helps travelers discover buses, compare options, and travel with confidence.</p>
            </div>
            <div class="story-card story-image-card">
                <img src="<%= request.getContextPath() %>/images/aboutus.jpg" alt="YatraGo team and Nepal bus travel">
                <div class="story-image-caption">Connecting Nepal, one journey at a time.</div>
            </div>
        </div>
    </section>

    <section class="subpage-section soft-section">
        <div class="container">
            <h2 class="section-title">Mission &amp; Vision</h2>
            <div class="mv-grid">
                <article class="mv-card mission"><h3>Our Mission</h3><p>To simplify bus travel in Nepal through a reliable platform that helps passengers find, compare, and book journeys easily.</p></article>
                <article class="mv-card vision"><h3>Our Vision</h3><p>To become Nepal's most trusted digital bus travel companion with safe, comfortable, and accessible journeys for all.</p></article>
            </div>
        </div>
    </section>

    <section class="subpage-section">
        <div class="container">
            <h2 class="section-title">Our Values</h2>
            <div class="values-grid">
                <article class="value-card"><div class="icon-circle">&#128737;</div><h4>Safety</h4><p>We prioritize secure journeys with trusted operators and clear travel information.</p></article>
                <article class="value-card"><div class="icon-circle">&#9201;</div><h4>Reliability</h4><p>Dependable schedules and smooth booking help travelers plan with confidence.</p></article>
                <article class="value-card"><div class="icon-circle">&#128154;</div><h4>Affordability</h4><p>Fair and transparent fares keep comfortable travel within everyone's reach.</p></article>
            </div>
        </div>
    </section>

    <section class="subpage-section soft-section">
        <div class="container">
            <h2 class="section-title">Meet Our Team</h2>
            <div class="team-grid">
                <article class="team-card"><img class="team-photo" src="<%= request.getContextPath() %>/images/Anuska.jpeg" alt="Anuska Magar"><h4>Anuska Magar</h4><p>Authentication &amp; Security Developer</p></article>
                <article class="team-card"><img class="team-photo" src="<%= request.getContextPath() %>/images/Ashwin.png" alt="Ashwin Pokhrel"><h4>Ashwin Pokhrel</h4><p>Team Lead &amp; Frontend Developer</p></article>
                <article class="team-card"><img class="team-photo" src="<%= request.getContextPath() %>/images/Ashutosh.jpeg" alt="Ashutosh Janga Thapa"><h4>Ashutosh Janga Thapa</h4><p>Schedule &amp; Booking Backend Developer</p></article>
                <article class="team-card"><img class="team-photo" src="<%= request.getContextPath() %>/images/Hritika.jpeg" alt="Hritika Biswakarma"><h4>Hritika Biswakarma</h4><p>Admin Dashboard &amp; Bus Management</p></article>
                <article class="team-card"><img class="team-photo" src="<%= request.getContextPath() %>/images/Jonrika.jpeg" alt="Jonrika Karki"><h4>Jonrika Karki</h4><p>Database &amp; Route Management</p></article>
                <article class="team-card"><img class="team-photo" src="<%= request.getContextPath() %>/images/Nisha.jpeg" alt="Nisha Rai"><h4>Nisha Rai</h4><p>User/Driver Models &amp; Analytics</p></article>
            </div>
        </div>
    </section>
</main>

<footer class="footer">
    <span class="footer-brand">Yatra<span>Go</span></span>
    &copy; 2026 YatraGo. Built for Nepal.
</footer>

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
