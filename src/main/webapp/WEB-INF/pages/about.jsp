<%--
  Created by IntelliJ IDEA.
  User: anusk
  Date: 5/14/2026
  Time: 9:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>About - Yatrago</title>
    <link rel="stylesheet" href="<%= request.getContextPath() %>/css/main.css">
    <style>
        :root {
            --teal: #0D9488;
            --teal-dark: #134E4A;
            --coral: #F97360;
            --bg: #F8FAFC;
            --white: #FFFFFF;
            --text: #1F2937;
            --muted: #64748B;
            --shadow: 0 4px 16px rgba(13,148,136,0.10);
            --radius: 12px;
            --transition: all 0.3s ease;
            --max-width: 1140px;
        }

        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: "Inter", "Segoe UI", Arial, sans-serif;
            background: var(--bg);
            color: var(--text);
            line-height: 1.6;
        }

        a { text-decoration: none; transition: var(--transition); }

        .container {
            width: 92%;
            max-width: var(--max-width);
            margin: 0 auto;
        }

        .navbar {
            background: var(--white);
            border-bottom: 1px solid rgba(15, 23, 42, 0.08);
            position: sticky;
            top: 0;
            z-index: 1000;
            transition: var(--transition);
        }

        .navbar.scrolled {
            box-shadow: 0 8px 24px rgba(15, 23, 42, 0.08);
        }

        .navbar .container {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 16px;
            padding: 14px 0;
            flex-wrap: wrap;
        }

        .navbar-brand {
            font-size: 1.45rem;
            font-weight: 800;
            color: var(--teal);
        }

        .navbar-brand span { color: var(--coral); }

        .hamburger {
            display: none;
            background: transparent;
            border: 1px solid rgba(15, 23, 42, 0.12);
            color: var(--teal-dark);
            padding: 8px 12px;
            border-radius: 10px;
            cursor: pointer;
        }

        .navbar-nav {
            list-style: none;
            display: flex;
            align-items: center;
            gap: 10px;
            flex-wrap: wrap;
        }

        .nav-link {
            color: var(--teal-dark);
            font-weight: 600;
            padding: 10px 14px;
            border-radius: 10px;
            transition: var(--transition);
        }

        .nav-link:hover,
        .nav-link.active {
            background: var(--teal);
            color: var(--white);
        }

        .nav-link-cta {
            background: var(--coral);
            color: var(--white);
        }

        .nav-link-cta:hover {
            background: #fb6a55;
            color: var(--white);
        }

        .hero {
            background: linear-gradient(135deg, var(--teal) 0%, #0F766E 100%);
            color: var(--white);
            padding: 76px 0 70px;
            text-align: center;
        }

        .hero-inner {
            max-width: 900px;
            margin: 0 auto;
        }

        .hero h1 {
            font-size: clamp(2rem, 4vw, 3.2rem);
            margin-bottom: 14px;
            font-weight: 800;
        }

        .hero p {
            font-size: clamp(1rem, 2vw, 1.12rem);
            opacity: 0.96;
        }

        section { padding: 56px 0; }

        .section-title {
            font-size: 1.8rem;
            margin-bottom: 18px;
            color: var(--teal-dark);
        }

        .story-grid {
            display: flex;
            gap: 24px;
            align-items: stretch;
        }

        .story-text, .story-card { flex: 1; }

        .story-text p {
            color: #334155;
            margin-bottom: 12px;
        }

        .story-card {
            background: linear-gradient(135deg, var(--teal) 0%, #14B8A6 100%);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            min-height: 240px;
            padding: 24px;
            display: flex;
            align-items: center;
            justify-content: center;
            color: var(--white);
            text-align: center;
            font-size: 1.06rem;
            font-weight: 600;
        }

        .mv-grid, .values-grid, .team-grid {
            display: flex;
            gap: 20px;
            flex-wrap: wrap;
        }

        .mv-card, .value-card, .team-card {
            flex: 1 1 calc(33.333% - 14px);
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 22px;
            transition: var(--transition);
        }

        .mv-card:hover, .value-card:hover, .team-card:hover {
            transform: translateY(-4px);
        }

        .mv-card h3, .value-card h4, .team-card h4 {
            margin-bottom: 10px;
            color: #0F172A;
        }

        .mission { border-left: 6px solid var(--teal); }
        .vision { border-left: 6px solid var(--coral); }

        .mv-card p,
        .value-card p,
        .team-card p {
            color: var(--muted);
        }

        .value-card {
            text-align: center;
            padding: 24px 18px;
        }

        .icon-circle {
            width: 64px;
            height: 64px;
            margin: 0 auto 14px;
            border-radius: 50%;
            background: var(--teal);
            color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.9rem;
            transition: var(--transition);
        }

        .value-card:hover .icon-circle {
            background: var(--coral);
            transform: scale(1.06);
        }

        .team-card {
            text-align: center;
        }

        .avatar {
            width: 82px;
            height: 82px;
            margin: 0 auto 14px;
            border-radius: 50%;
            background: var(--teal);
            color: var(--white);
            display: flex;
            align-items: center;
            justify-content: center;
            font-size: 1.35rem;
            font-weight: 800;
            letter-spacing: 0.6px;
        }

        @media (max-width: 992px) {
            .story-grid { flex-wrap: wrap; }
            .story-text, .story-card { flex: 1 1 100%; }
            .mv-card, .value-card, .team-card { flex: 1 1 calc(50% - 10px); }
        }

        @media (max-width: 640px) {
            .navbar .container { justify-content: center; }
            .hamburger { display: block; }
            .navbar-nav {
                display: none;
                width: 100%;
                justify-content: center;
            }
            .navbar-nav.nav-open { display: flex; }
            .navbar-brand {
                width: 100%;
                text-align: center;
            }
            .mv-card, .value-card, .team-card { flex: 1 1 100%; }
            section { padding: 44px 0; }
        }
    </style>
</head>
<body>

<nav class="navbar">
    <div class="container">
        <a href="<%= request.getContextPath() %>/" class="navbar-brand">
            Yatra<span>Go</span>
        </a>
        <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
        <ul class="navbar-nav" id="mainNav">
            <li><a href="<%= request.getContextPath() %>/" class="nav-link">Home</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/about" class="nav-link active">About</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/contact" class="nav-link">Contact</a></li>
            <li><a href="<%= request.getContextPath() %>/login" class="nav-link">Login</a></li>
            <li><a href="<%= request.getContextPath() %>/register" class="nav-link nav-link-cta">Register</a></li>
        </ul>
    </div>
</nav>

<section class="hero">
    <div class="hero-inner container">
        <h1>About Yatrago</h1>
        <p>Your trusted companion for safe, affordable, and comfortable bus travel across Nepal.</p>
    </div>
</section>

<section>
    <div class="container story-grid">
        <div class="story-text">
            <h2 class="section-title">Our Story</h2>
            <p>Yatrago was founded to simplify bus travel in Nepal and make journey planning easier for everyone.</p>
            <p>We connect passengers to routes across the country with a simple, reliable booking experience built around convenience and trust.</p>
            <p>From city rides to long-distance trips, Yatrago helps travelers discover buses, compare options, and travel with confidence.</p>
        </div>
        <div class="story-card">
            Connecting Nepal, one journey at a time.
        </div>
    </div>
</section>

<section>
    <div class="container">
        <h2 class="section-title">Mission &amp; Vision</h2>
        <div class="mv-grid">
            <article class="mv-card mission">
                <h3>Our Mission</h3>
                <p>To simplify bus travel in Nepal through a reliable platform that helps passengers find, compare, and book journeys easily.</p>
            </article>
            <article class="mv-card vision">
                <h3>Our Vision</h3>
                <p>To become Nepal’s most trusted digital bus travel companion with safe, comfortable, and accessible journeys for all.</p>
            </article>
        </div>
    </div>
</section>

<section>
    <div class="container">
        <h2 class="section-title">Our Values</h2>
        <div class="values-grid">
            <article class="value-card">
                <div class="icon-circle" aria-hidden="true">🛡️</div>
                <h4>Safety</h4>
                <p>We prioritize secure journeys with trusted operators and clear travel information.</p>
            </article>
            <article class="value-card">
                <div class="icon-circle" aria-hidden="true">⏱️</div>
                <h4>Reliability</h4>
                <p>Dependable schedules and smooth booking help travelers plan with confidence.</p>
            </article>
            <article class="value-card">
                <div class="icon-circle" aria-hidden="true">💚</div>
                <h4>Affordability</h4>
                <p>Fair and transparent fares keep comfortable travel within everyone’s reach.</p>
            </article>
        </div>
    </div>
</section>

<section>
    <div class="container">
        <h2 class="section-title">Meet Our Team</h2>
        <div class="team-grid">
            <article class="team-card">
                <div class="avatar">AM</div>
                <h4>Anuska Magar</h4>
                <p>Authentication &amp; Security Developer</p>
            </article>
            <article class="team-card">
                <div class="avatar">AP</div>
                <h4>Ashwin Pokhrel</h4>
                <p>Team Lead &amp; Frontend Developer</p>
            </article>
            <article class="team-card">
                <div class="avatar">AJ</div>
                <h4>Ashutosh Janga Thapa</h4>
                <p>Schedule &amp; Booking Backend Developer</p>
            </article>
            <article class="team-card">
                <div class="avatar">HB</div>
                <h4>Hritika Biswakarma</h4>
                <p>Admin Dashboard &amp; Bus Management</p>
            </article>
            <article class="team-card">
                <div class="avatar">JK</div>
                <h4>Jonrika Karki</h4>
                <p>Database &amp; Route Management</p>
            </article>
            <article class="team-card">
                <div class="avatar">NR</div>
                <h4>Nisha Rai</h4>
                <p>User/Driver Models &amp; Analytics</p>
            </article>
        </div>
    </div>
</section>
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