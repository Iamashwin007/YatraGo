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
  <title>Contact - Yatrago</title>
  <style>
    :root {
      --teal: #0D9488;
      --teal-dark: #134E4A;
      --coral: #F97360;
      --white: #FFFFFF;
      --text: #1F2937;
      --muted: #6B7280;
      --bg: #F8FAFC;
      --shadow: 0 4px 16px rgba(13,148,136,0.10);
      --radius: 12px;
      --transition: all 0.3s ease;
      --max-width: 1140px;
    }

    * {
      margin: 0;
      padding: 0;
      box-sizing: border-box;
    }

    body {
      font-family: "Segoe UI", Arial, sans-serif;
      background: var(--bg);
      color: var(--text);
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
      padding: 70px 0 62px;
      text-align: center;
    }

    .hero h1 {
      font-size: clamp(2rem, 4vw, 2.9rem);
      margin-bottom: 10px;
      font-weight: 800;
    }

    .hero p {
      max-width: 760px;
      margin: 0 auto;
      font-size: clamp(1rem, 2vw, 1.1rem);
      opacity: 0.96;
    }

    section {
      padding: 54px 0;
    }

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

    footer {
      background: var(--teal-dark);
      color: var(--white);
      text-align: center;
      padding: 20px 12px;
      font-size: 0.95rem;
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
      <li><a href="<%= request.getContextPath() %>/pages/about.jsp">About</a></li>
      <li><a class="active" href="<%= request.getContextPath() %>/pages/contact.jsp">Contact</a></li>
      <li><a href="<%= request.getContextPath() %>/pages/login.jsp">Login</a></li>
      <li><a href="<%= request.getContextPath() %>/pages/register.jsp">Register</a></li>
    </ul>
  </div>
</header>

<section class="hero">
  <div class="container">
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
        <form action="#" method="post">
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

<footer>
  &copy; 2026 Yatrago. All rights reserved.
</footer>

</body>
</html>
