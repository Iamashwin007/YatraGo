<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>My Bookings — YatraGo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .my-bookings-page {
            max-width: 780px;
            margin: 0 auto;
            padding: 3rem 1.5rem 4rem;
        }

        .page-heading {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--clr-text);
            letter-spacing: -0.5px;
            margin-bottom: 0.375rem;
        }
        .page-subheading {
            font-size: 0.9375rem;
            color: var(--clr-text-muted);
            margin-bottom: 2rem;
        }

        /* ── Booking cards ── */
        .bookings-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }

        .booking-card {
            background: var(--clr-surface);
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: 1.5rem 1.75rem;
            transition: box-shadow 0.15s, transform 0.15s;
        }
        .booking-card:hover { box-shadow: var(--shadow-md); transform: translateY(-1px); }

        .booking-card-top {
            display: flex;
            align-items: flex-start;
            justify-content: space-between;
            gap: 1rem;
            margin-bottom: 0.875rem;
            flex-wrap: wrap;
        }
        .booking-ref {
            font-size: 1.0625rem;
            font-weight: 800;
            color: var(--clr-primary);
            letter-spacing: -0.25px;
        }
        .booking-badges {
            display: flex;
            gap: 0.375rem;
            flex-wrap: wrap;
            align-items: center;
        }

        .booking-route {
            font-size: 1.25rem;
            font-weight: 700;
            color: var(--clr-text);
            letter-spacing: -0.5px;
            margin-bottom: 0.875rem;
        }
        .booking-route-arrow { color: var(--clr-text-muted); margin: 0 0.375rem; }

        .booking-meta {
            display: flex;
            gap: 1.25rem 2rem;
            flex-wrap: wrap;
            margin-bottom: 1.25rem;
        }
        .booking-meta-item {
            font-size: 0.875rem;
            color: var(--clr-text);
            font-weight: 500;
        }
        .booking-meta-item span {
            display: block;
            font-size: 0.6875rem;
            font-weight: 700;
            text-transform: uppercase;
            letter-spacing: 0.5px;
            color: var(--clr-text-muted);
            margin-bottom: 0.125rem;
        }

        .booking-divider {
            border: none;
            border-top: 1px solid var(--clr-border-light);
            margin: 0 0 1.125rem;
        }

        .booking-actions {
            display: flex;
            align-items: center;
            justify-content: flex-end;
            gap: 0.625rem;
            flex-wrap: wrap;
        }

        /* Badge colours not in main.css */
        .badge-confirmed { background: var(--clr-success-bg);  color: var(--clr-success);  border-color: var(--clr-success-border); }
        .badge-paid      { background: var(--clr-success-bg);  color: var(--clr-success);  border-color: var(--clr-success-border); }
        .badge-pending   { background: var(--clr-warning-bg);  color: var(--clr-warning);  border-color: var(--clr-warning-border); }
        .badge-failed    { background: var(--clr-error-bg);    color: var(--clr-error);    border-color: var(--clr-error-border); }

        /* ── Empty state ── */
        .bookings-empty {
            background: var(--clr-surface);
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-lg);
            padding: 4.5rem 2rem;
            text-align: center;
            color: var(--clr-text-muted);
        }
        .bookings-empty-icon  { font-size: 2.75rem; margin-bottom: 1rem; }
        .bookings-empty-title { font-size: 1.0625rem; font-weight: 700; color: var(--clr-text); margin-bottom: 0.5rem; }
        .bookings-empty-sub   { font-size: 0.9375rem; margin-bottom: 1.5rem; }

        @media (max-width: 560px) {
            .booking-card    { padding: 1.125rem; }
            .booking-actions { justify-content: stretch; flex-direction: column; }
            .booking-actions .btn,
            .booking-actions form { width: 100%; }
            .booking-actions form .btn { width: 100%; }
        }
    </style>
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
                    <li><a href="${pageContext.request.contextPath}/search" class="nav-link">Search</a></li>
                    <li><a href="${pageContext.request.contextPath}/profile" class="nav-link">Profile</a></li>
                    <li><a href="${pageContext.request.contextPath}/logout" class="nav-link">Logout</a></li>
                </c:when>
                <c:otherwise>
                    <li><a href="${pageContext.request.contextPath}/search" class="nav-link">Search</a></li>
                    <li><a href="${pageContext.request.contextPath}/login" class="nav-link">Login</a></li>
                    <li><a href="${pageContext.request.contextPath}/register" class="nav-link nav-link-cta">Register</a></li>
                </c:otherwise>
            </c:choose>
        </ul>
    </div>
</nav>

<main>
    <div class="my-bookings-page">

        <h1 class="page-heading">My Bookings</h1>
        <p class="page-subheading">All your bus ticket bookings in one place</p>

        <c:choose>
            <c:when test="${empty bookings}">
                <div class="bookings-empty">
                    <div class="bookings-empty-icon">&#127915;</div>
                    <p class="bookings-empty-title">You have no bookings yet</p>
                    <p class="bookings-empty-sub">
                        Search for a bus and book your first ticket &mdash; it only takes a minute.
                    </p>
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">Search Buses</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="bookings-list">
                    <c:forEach var="booking" items="${bookings}">
                        <div class="booking-card">

                            <%-- Reference + status badges --%>
                            <div class="booking-card-top">
                                <div class="booking-ref">${booking.bookingReference}</div>
                                <div class="booking-badges">
                                    <span class="badge badge-${booking.bookingStatus}">${booking.bookingStatus}</span>
                                </div>
                            </div>

                            <%-- Route --%>
                            <div class="booking-route">
                                ${booking.origin}
                                <span class="booking-route-arrow">&#8594;</span>
                                ${booking.destination}
                            </div>

                            <%-- Detail strip --%>
                            <div class="booking-meta">
                                <div class="booking-meta-item">
                                    <span>Operator</span>
                                    ${booking.operatorName}
                                </div>
                                <div class="booking-meta-item">
                                    <span>Bus</span>
                                    ${booking.busNumber}
                                </div>
                                <div class="booking-meta-item">
                                    <span>Departure</span>
                                    <fmt:formatDate value="${booking.departureTime}" pattern="hh:mm a" />
                                </div>
                                <div class="booking-meta-item">
                                    <span>Seats</span>
                                    ${booking.passengerCount}
                                </div>
                                <div class="booking-meta-item">
                                    <span>Total</span>
                                    NPR <fmt:formatNumber value="${booking.totalFare}" maxFractionDigits="0" />
                                </div>
                            </div>

                            <hr class="booking-divider">

                            <%-- Actions --%>
                            <div class="booking-actions">

                                <%-- Cancel — only for confirmed bookings --%>
                                <c:if test="${booking.bookingStatus == 'confirmed'}">
                                    <form method="post"
                                          action="${pageContext.request.contextPath}/cancel-booking"
                                          onsubmit="return confirm('Cancel this booking? This cannot be undone.');">
                                        <input type="hidden" name="bookingId" value="${booking.id}">
                                        <button type="submit" class="btn btn-danger btn-sm">Cancel Booking</button>
                                    </form>
                                </c:if>

                                <a href="${pageContext.request.contextPath}/e-ticket?bookingId=${booking.id}"
                                   class="btn btn-secondary btn-sm">View E-Ticket</a>

                            </div>

                        </div><%-- /.booking-card --%>
                    </c:forEach>
                </div><%-- /.bookings-list --%>
            </c:otherwise>
        </c:choose>

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
    <div id="flash-data" data-type="${sessionScope.flashType}" data-message="${sessionScope.flashMessage}" style="display:none;"></div>
    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>
<div id="toast-container"></div>
<script src="${pageContext.request.contextPath}/js/toasts.js"></script>

</body>
</html>
