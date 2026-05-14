<%--
  Created by IntelliJ IDEA.
  User: anusk
  Date: 5/14/2026
  Time: 9:17 PM
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8" />
    <meta name="viewport" content="width=device-width, initial-scale=1" />
    <title>About - Yatrago</title>
    <style>
        :root {
            --teal: #0D9488;
            --teal-dark: #134E4A;
            --teal-soft: #CCFBF1;
            --coral: #F97360;
            --white: #FFFFFF;
            --text: #1F2937;
            --muted: #6B7280;
            --shadow: 0 4px 16px rgba(13,148,136,0.10);
            --radius: 12px;
            --transition: all 0.3s ease;
            --max-width: 1140px;
        }

        * {
            box-sizing: border-box;
            margin: 0;
            padding: 0;
        }

        body {
            font-family: "Segoe UI", Arial, sans-serif;
            color: var(--text);
            background: #F8FAFC;
            line-height: 1.6;
        }

        a {
            text-decoration: none;
            transition: var(--transition);
        }

        .container {
            width: 92%;
            max-width: var(--max-width);
            margin: 0 auto;
        }

        /* Navbar */
        .navbar {
            background: var(--teal);
            box-shadow: 0 2px 10px rgba(0,0,0,0.08);
            position: sticky;
            top: 0;
            z-index: 1000;
        }

        .nav-inner {
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 14px 0;
            flex-wrap: wrap;
            gap: 12px;
        }

        .brand {
            color: var(--white);
            font-size: 1.4rem;
            font-weight: 700;
            letter-spacing: 0.4px;
        }

        .nav-links {
            list-style: none;
            display: flex;
            gap: 10px;
            flex-wrap: wrap;
        }

        .nav-links a {
            color: var(--white);
            padding: 8px 14px;
            border-radius: 999px;
            font-weight: 500;
        }

        .nav-links a:hover {
            background: var(--coral);
        }

        .nav-links a.active {
            background: rgba(255,255,255,0.18);
        }

        /* Hero */
        .hero {
            background: linear-gradient(135deg, #0D9488 0%, #0F766E 100%);
            color: var(--white);
            padding: 74px 0 68px;
            text-align: center;
        }

        .hero h1 {
            font-size: clamp(2rem, 4vw, 3rem);
            margin-bottom: 12px;
            font-weight: 800;
            letter-spacing: 0.4px;
        }

        .hero p {
            font-size: clamp(1rem, 2vw, 1.15rem);
            max-width: 840px;
            margin: 0 auto;
            opacity: 0.96;
        }

        section {
            padding: 56px 0;
        }

        .section-title {
            font-size: 1.8rem;
            margin-bottom: 18px;
            color: var(--teal-dark);
        }

        /* Story */
        .story-grid {
            display: flex;
            gap: 24px;
            align-items: stretch;
        }

        .story-text,
        .story-card {
            flex: 1;
        }

        .story-text p {
            color: #334155;
            margin-bottom: 12px;
        }

        .story-card {
            background: linear-gradient(135deg, #0D9488 0%, #14B8A6 100%);
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

        /* Mission / Vision */
        .mv-grid {
            display: flex;
            gap: 20px;
        }

        .mv-card {
            flex: 1;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 22px;
            transition: var(--transition);
        }

        .mv-card:hover {
            transform: translateY(-4px);
        }

        .mv-card h3 {
            margin-bottom: 10px;
            color: #0F172A;
        }

        .mission {
            border-left: 6px solid var(--teal);
        }

        .vision {
            border-left: 6px solid var(--coral);
        }

        .mv-card p {
            color: #475569;
        }

        /* Values */
        .values-grid {
            display: flex;
            gap: 20px;
        }

        .value-card {
            flex: 1;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 24px 18px;
            text-align: center;
            transition: var(--transition);
        }

        .value-card:hover {
            transform: translateY(-5px);
            box-shadow: 0 10px 24px rgba(249,115,96,0.18);
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

        .value-card h4 {
            margin-bottom: 6px;
            color: var(--teal-dark);
        }

        .value-card p {
            color: var(--muted);
            font-size: 0.95rem;
        }

        /* Team */
        .team-grid {
            display: flex;
            gap: 20px;
        }

        .team-card {
            flex: 1;
            background: var(--white);
            border-radius: var(--radius);
            box-shadow: var(--shadow);
            padding: 24px;
            text-align: center;
            transition: var(--transition);
        }

        .team-card:hover {
            transform: translateY(-4px);
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
            font-size: 1.45rem;
            font-weight: 700;
            letter-spacing: 0.6px;
        }

        .team-card h4 {
            margin-bottom: 5px;
            color: #0F172A;
        }

        .team-card p {
            color: var(--muted);
            font-size: 0.95rem;
        }

        /* Footer */
        footer {
            background: var(--teal-dark);
            color: var(--white);
            text-align: center;
            padding: 20px 12px;
            font-size: 0.95rem;
            margin-top: 16px;
        }

        /* Responsive */
        @media (max-width: 992px) {
            .story-grid,
            .mv-grid,
            .values-grid,
            .team-grid {
                flex-wrap: wrap;
            }

            .story-text,
            .story-card,
            .mv-card,
            .value-card,
            .team-card {
                flex: 1 1 calc(50% - 12px);
            }
        }

        @media (max-width: 640px) {
            .nav-inner {
                justify-content: center;
            }

            .brand {
                width: 100%;
                text-align: center;
            }

            .nav-links {
                justify-content: center;
            }

            .story-text,
            .story-card,
            .mv-card,
            .value-card,
            .team-card {
                flex: 1 1 100%;
            }

            section {
                padding: 44px 0;
            }
        }
    </style>
</head>
<body>

<header class="navbar">
    <div class="container nav-inner">
        <a class="brand" href="<%= request.getContextPath() %>/">Yatrago</a>
        <ul class="nav-links">
            <li><a href="<%= request.getContextPath() %>/">Home</a></li>
            <li><a class="active" href="<%= request.getContextPath() %>/pages/about">About</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/contact">Contact</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/login">Login</a></li>
            <li><a href="<%= request.getContextPath() %>/pages/register">Register</a></li>
        </ul>
    </div>
</header>

<section class="hero">
    <div class="container">
        <h1>About Yatrago</h1>
        <p>Your trusted companion for safe, affordable, and comfortable bus travel across Nepal.</p>
    </div>
</section>

<section>
    <div class="container story-grid">
        <div class="story-text">
            <h2 class="section-title">Our Story</h2>
            <p>Yatrago was founded with a simple goal: make bus travel in Nepal easier for everyone.</p>
            <p>From busy city routes to long-distance journeys through the hills, we connect passengers with trusted operators and convenient schedules across the country.</p>
            <p>By combining technology with local travel needs, Yatrago helps travelers discover routes, plan confidently, and ride with peace of mind.</p>
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
                <p>To simplify bus travel in Nepal by offering a reliable platform where passengers can find routes, compare options, and book confidently.</p>
            </article>
            <article class="mv-card vision">
                <h3>Our Vision</h3>
                <p>To become Nepal’s most trusted digital travel companion, making safe and comfortable road journeys accessible to every traveler.</p>
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
                <p>Timely schedules and dependable service help travelers plan with confidence.</p>
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

<footer>
    &copy; 2026 Yatrago. All rights reserved.
</footer>

</body>
</html>
</body>
</html>
