<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Search Results — YatraGo</title>
  <link rel="preconnect" href="https://fonts.googleapis.com">
  <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
  <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
  <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
</head>
<body>

<nav class="navbar">
  <div class="container">
    <a href="${pageContext.request.contextPath}/" class="navbar-brand">Yatra<span>Go</span></a>
    <button class="hamburger" id="navToggle" aria-label="Toggle menu">&#9776;</button>
    <ul class="navbar-nav" id="mainNav">
      <c:choose>
        <c:when test="${not empty sessionScope.user}">
          <li><span class="nav-greeting">Hi, ${sessionScope.user.name}</span></li>
          <c:if test="${sessionScope.user.role == 'admin'}">
            <li><a href="${pageContext.request.contextPath}/admin/dashboard" class="nav-link">Admin Dashboard</a></li>
          </c:if>
          <li><a href="${pageContext.request.contextPath}/search" class="nav-link active">Search</a></li>
          <li><a href="${pageContext.request.contextPath}/my-bookings" class="nav-link">My Bookings</a></li>
          <li><a href="${pageContext.request.contextPath}/profile" class="nav-link">Profile</a></li>
          <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
        </c:when>
        <c:otherwise>
          <li><a href="${pageContext.request.contextPath}/search" class="nav-link active">Search</a></li>
          <li><a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a></li>
          <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
        </c:otherwise>
      </c:choose>
    </ul>
  </div>
</nav>

<main>
  <div class="results-page">
    <div class="container">

      <%-- Back link --%>
      <a href="${pageContext.request.contextPath}/search" class="results-back">
        &#8592; Back to Search
      </a>

      <%-- Summary bar showing what the user searched --%>
      <div class="results-summary-bar">
        <div class="results-summary-route">
          <span>${param.origin}</span>
          &nbsp;&#8594;&nbsp;
          <span>${param.destination}</span>
        </div>
        <div class="results-summary-date">
          <fmt:parseDate value="${param.journeyDate}" pattern="yyyy-MM-dd" var="parsedDate" />
          <fmt:formatDate value="${parsedDate}" pattern="EEEE, MMM d, yyyy" />
        </div>
      </div>

      <%-- Results count --%>
      <p class="results-count">
        <c:choose>
          <c:when test="${empty schedules}">No buses found</c:when>
          <c:when test="${schedules.size() == 1}">1 bus found</c:when>
          <c:otherwise>${schedules.size()} buses found</c:otherwise>
        </c:choose>
      </p>

      <%-- Bus result cards --%>
      <c:choose>
        <c:when test="${empty schedules}">
          <div class="results-empty">
            <div class="results-empty-icon">&#128652;</div>
            <p class="results-empty-title">No buses available</p>
            <p class="results-empty-sub">
              Try a different date or route.
            </p>
            <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">
              Search Again
            </a>
          </div>
        </c:when>
        <c:otherwise>
          <div class="results-list">
            <c:forEach var="schedule" items="${schedules}">
              <div class="result-card">

                  <%-- Left: operator + bus info --%>
                <div class="result-card-main">
                  <div class="result-operator">${schedule.operatorName}</div>
                  <div class="result-bus-info">
                      ${schedule.busNumber}
                    <span class="result-bus-type">&middot; ${schedule.busType}</span>
                  </div>
                </div>

                  <%-- Center: time + route --%>
                <div class="result-card-center">
                  <div class="result-time">
                    <fmt:formatDate value="${schedule.departureTime}" pattern="hh:mm a" />
                  </div>
                  <div class="result-route-arrow">&#8594;</div>
                  <div class="result-time">
                    <fmt:formatDate value="${schedule.arrivalTime}" pattern="hh:mm a" />
                  </div>
                </div>

                  <%-- Right: seats + fare + button --%>
                <div class="result-card-right">
                  <div class="result-seats">
                    <span class="result-seats-count">${schedule.availableSeats}</span>
                    seats left
                  </div>
                  <div class="result-fare">
                    NPR <fmt:formatNumber value="${schedule.fare}" maxFractionDigits="0" />
                    <span class="result-fare-label">/ seat</span>
                  </div>
                  <a href="${pageContext.request.contextPath}/select-seats?scheduleId=${schedule.id}"
                     class="btn btn-primary btn-sm">
                    Select Seats
                  </a>
                </div>

              </div>
            </c:forEach>
          </div>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</main>

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

<c:if test="${not empty sessionScope.flashMessage}">
  <div id="flash-data"
       data-type="${sessionScope.flashType}"
       data-message="${sessionScope.flashMessage}"
       style="display:none;"></div>
  <c:remove var="flashMessage" scope="session"/>
  <c:remove var="flashType"    scope="session"/>
</c:if>
<div id="toast-container"></div>
<script src="${pageContext.request.contextPath}/js/toasts.js"></script>

</body>
</html>