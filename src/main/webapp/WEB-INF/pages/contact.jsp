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
  <title>Contact - Yatrago</title>
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
      padding: 74px 0 68px;
      text-align: center;
    }

    .hero-inner {
      max-width: 900px;
      margin: 0 auto;
    }

    .hero h1 {
      font-size: clamp(2rem, 4vw, 3.2rem);
      margin-bottom: 12px;
      font-weight: 800;
    }

    .hero p {
      font-size: clamp(1rem, 2vw, 1.1rem);
      opacity: 0.96;
    }

    section { padding: 56px 0; }

    .section-title {
      font-size: 1.8rem;
      margin-bottom: 18px;
      color: var(--teal-dark);
    }

    .contact-layout {
      display: flex;
      gap: 22px;
      align-items: stretch;
    }

    .contact-info,
    .contact-form-wrap {
      flex: 1;
      background: var(--white);
      border-radius: var(--radius);
      box-shadow: var(--shadow);
      padding: 24px;
    }

    .info-list {
      display: flex;
      flex-direction: column;
      gap: 14px;
      margin-top: 8px;
    }

    .info-card {
      display: flex;
      align-items: flex-start;
      gap: 12px;
      padding: 14px;
      border: 1px solid #E2E8F0;
      border-radius: 10px;
      transition: var(--transition);
    }

    .info-card:hover {
      border-color: var(--coral);
      transform: translateY(-2px);
    }

    .icon-dot {
      width: 42px;
      height: 42px;
      border-radius: 50%;
      background: var(--teal);
      color: var(--white);
      display: flex;
      align-items: center;
      justify-content: center;
      font-size: 1.1rem;
      flex-shrink: 0;
      transition: var(--transition);
    }

    .info-card:hover .icon-dot {
      background: var(--coral);
    }

    .info-card h4 {
      font-size: 1rem;
      margin-bottom: 3px;
      color: #0F172A;
    }

    .info-card p {
      color: var(--muted);
      font-size: 0.95rem;
    }

    form {
      display: flex;
      flex-direction: column;
      gap: 14px;
    }

    .field {
      display: flex;
      flex-direction: column;
      gap: 6px;
    }

    label {
      font-size: 0.93rem;
      font-weight: 600;
      color: #334155;
    }

    input,
    textarea {
      width: 100%;
      border: 1px solid #CBD5E1;
      border-radius: 10px;
      padding: 11px 12px;
      font-size: 0.96rem;
      font-family: inherit;
      transition: var(--transition);
      background: #FFFFFF;
    }

    input:focus,
    textarea:focus {
      outline: none;
      border-color: var(--teal);
      box-shadow: 0 0 0 3px rgba(13,148,136,0.15);
    }

    textarea {
      min-height: 130px;
      resize: vertical;
    }

    .btn {
      border: none;
      border-radius: 10px;
      background: var(--teal);
      color: var(--white);
      font-weight: 600;
      cursor: pointer;
      padding: 11px 16px;
      transition: var(--transition);
      align-self: flex-start;
    }

    .btn:hover {
      background: var(--coral);
      transform: translateY(-2px);
    }

    /* Toast Styling */
    #toast-container {
      position: fixed;
      top: 20px;
      right: 20px;
      z-index: 9999;
      font-family: "Inter", Arial, sans-serif;
    }

    .toast {
      background: var(--white);
      color: var(--text);
      padding: 16px 20px;
      border-radius: var(--radius);
      box-shadow: 0 8px 24px rgba(13, 148, 136, 0.2);
      display: flex;
      align-items: center;
      gap: 12px;
      margin-bottom: 12px;
      border-left: 4px solid var(--teal);
      animation: slideIn 0.3s ease forwards;
      max-width: 380px;
    }

    .toast.success {
      border-left-color: var(--teal);
    }
    .toast.success::before {
      content: "";
    }

    .toast.error::before {
      content: "";
    }

    .toast.info::before {
      content: "";
    }

    .toast.info {
      border-left-color: var(--coral);
    }

    .toast.info::before {
      content: "ℹ";
      color: var(--coral);
      font-weight: 800;
      font-size: 1.2rem;
    }

    @keyframes slideIn {
      from {
        transform: translateX(400px);
        opacity: 0;
      }
      to {
        transform: translateX(0);
        opacity: 1;
      }
    }

    @media (max-width: 920px) {
      .contact-layout {
        flex-wrap: wrap;
      }
      .contact-info,
      .contact-form-wrap {
        flex: 1 1 100%;
      }
    }

    @media (max-width: 640px) {
      .navbar .container {
        justify-content: center;
      }
      .hamburger {
        display: block;
      }
      .navbar-nav {
        display: none;
        width: 100%;
        justify-content: center;
      }
      .navbar-nav.nav-open {
        display: flex;
      }
      .navbar-brand {
        width: 100%;
        text-align: center;
      }
      section { padding: 44px 0; }

      #toast-container {
        top: 10px;
        right: 10px;
        left: 10px;
      }

      .toast {
        max-width: 100%;
      }
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
      <li><a href="<%= request.getContextPath() %>/pages/about" class="nav-link">About</a></li>
      <li><a href="<%= request.getContextPath() %>/pages/contact" class="nav-link active">Contact</a></li>
      <li><a href="<%= request.getContextPath() %>/login" class="nav-link">Login</a></li>
      <li><a href="<%= request.getContextPath() %>/register" class="nav-link nav-link-cta">Register</a></li>
    </ul>
  </div>
</nav>

<section class="hero">
  <div class="hero-inner container">
    <h1>Contact Yatrago</h1>
    <p>Have questions about routes, bookings, or support? We are here to help you travel better across Nepal.</p>
  </div>
</section>

<section>
  <div class="container">
    <h2 class="section-title">Get In Touch</h2>
    <div class="contact-layout">
      <div class="contact-info">
        <div class="info-list">
          <article class="info-card">
            <div class="icon-dot">📍</div>
            <div>
              <h4>Office</h4>
              <p>Kathmandu, Nepal</p>
            </div>
          </article>
          <article class="info-card">
            <div class="icon-dot">📞</div>
            <div>
              <h4>Phone</h4>
              <p>+977-1-XXXXXXX</p>
            </div>
          </article>
          <article class="info-card">
            <div class="icon-dot">✉️</div>
            <div>
              <h4>Email</h4>
              <p>support@yatrago.com</p>
            </div>
          </article>
          <article class="info-card">
            <div class="icon-dot">🕒</div>
            <div>
              <h4>Support Hours</h4>
              <p>Sun - Fri, 8:00 AM - 8:00 PM</p>
            </div>
          </article>
        </div>
      </div>

      <div class="contact-form-wrap">
        <form action="<%= request.getContextPath() %>/contact" method="post">
          <div class="field">
            <label for="name">Full Name</label>
            <input id="name" name="name" type="text" placeholder="Enter your name" required />
          </div>
          <div class="field">
            <label for="email">Email Address</label>
            <input id="email" name="email" type="email" placeholder="Enter your email" required />
          </div>
          <div class="field">
            <label for="subject">Subject</label>
            <input id="subject" name="subject" type="text" placeholder="How can we help?" required />
          </div>
          <div class="field">
            <label for="message">Message</label>
            <textarea id="message" name="message" placeholder="Write your message here..." required></textarea>
          </div>
          <button type="submit" class="btn">Send Message</button>
        </form>
      </div>
    </div>
  </div>
</section>

<footer class="footer">
  <span class="footer-brand">Yatra<span>Go</span></span>
  &copy; 2026 YatraGo. Built for Nepal.
</footer>

<c:if test="${not empty sessionScope.flashMessage}">
  <div id="flash-data"
       data-type="${sessionScope.flashType}"
       data-message="${sessionScope.flashMessage}"
       style="display:none;"></div>
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