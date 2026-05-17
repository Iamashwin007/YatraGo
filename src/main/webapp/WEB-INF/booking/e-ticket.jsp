<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt"  prefix="fmt" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>E-Ticket — YatraGo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .ticket-page {
            padding: 3rem 1.5rem 4rem;
        }

        .ticket-back {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--clr-text-muted);
            margin-bottom: 1.5rem;
            transition: color 0.15s;
        }
        .ticket-back:hover { color: var(--clr-primary); text-decoration: none; }

        /* ── Boarding-pass card ── */
        .ticket-card {
            background: var(--clr-surface);
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-xl);
            box-shadow: var(--shadow-lg);
            max-width: 680px;
            margin: 0 auto;
            overflow: hidden;
        }

        /* Top band */
        .ticket-top {
            background: linear-gradient(135deg, var(--clr-primary) 0%, var(--clr-primary-dark) 100%);
            padding: 2rem 2.25rem 1.75rem;
            color: #fff;
        }
        .ticket-brand {
            font-size: 0.75rem;
            font-weight: 700;
            letter-spacing: 2px;
            text-transform: uppercase;
            opacity: 0.75;
            margin-bottom: 1.25rem;
        }
        .ticket-ref-label {
            font-size: 0.6875rem;
            font-weight: 700;
            letter-spacing: 1.5px;
            text-transform: uppercase;
            opacity: 0.7;
            margin-bottom: 0.25rem;
        }
        .ticket-ref {
            font-size: clamp(1.5rem, 4vw, 2rem);
            font-weight: 800;
            letter-spacing: -0.5px;
            margin-bottom: 1.5rem;
        }
        .ticket-route-row {
            display: flex;
            align-items: center;
            gap: 1rem;
        }
        .ticket-city {
            font-size: clamp(1.25rem, 3.5vw, 1.75rem);
            font-weight: 800;
            letter-spacing: -0.5px;
        }
        .ticket-route-arrow {
            font-size: 1.5rem;
            opacity: 0.6;
            flex-shrink: 0;
        }

        /* Dashed tear-off divider */
        .ticket-divider {
            position: relative;
            display: flex;
            align-items: center;
            padding: 0 1.25rem;
            background: var(--clr-bg);
        }
        .ticket-divider::before,
        .ticket-divider::after {
            content: '';
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            width: 28px;
            height: 28px;
            border-radius: 50%;
            background: var(--clr-bg);
            border: 1px solid var(--clr-border);
            z-index: 1;
        }
        .ticket-divider::before { left: -14px; }
        .ticket-divider::after  { right: -14px; }
        .ticket-divider-line {
            flex: 1;
            border-top: 2px dashed var(--clr-border);
            margin: 0.875rem 0.5rem;
        }
        .ticket-divider-icon { font-size: 1.25rem; flex-shrink: 0; }

        /* Body details */
        .ticket-body {
            padding: 1.75rem 2.25rem 2rem;
        }
        .ticket-detail-grid {
            display: grid;
            grid-template-columns: 1fr 1fr;
            gap: 1.25rem 2rem;
            margin-bottom: 1.5rem;
        }
        .ticket-detail-item {}
        .ticket-detail-label {
            font-size: 0.6875rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: var(--clr-text-muted);
            margin-bottom: 0.25rem;
        }
        .ticket-detail-value {
            font-size: 0.9375rem;
            font-weight: 600;
            color: var(--clr-text);
        }

        /* Seat tags */
        .ticket-seats-section {
            margin-bottom: 1.5rem;
        }
        .ticket-seats-label {
            font-size: 0.6875rem;
            font-weight: 700;
            letter-spacing: 1px;
            text-transform: uppercase;
            color: var(--clr-text-muted);
            margin-bottom: 0.625rem;
        }
        .ticket-seats-row {
            display: flex;
            flex-wrap: wrap;
            gap: 0.5rem;
        }
        .ticket-seat-tag {
            background: var(--clr-primary-soft);
            color: var(--clr-primary);
            border: 1px solid rgba(14,124,123,0.25);
            border-radius: var(--radius-sm);
            font-size: 0.8125rem;
            font-weight: 700;
            padding: 0.3rem 0.75rem;
        }

        .ticket-seat-list {
            margin-top: 0.875rem;
            display: grid;
            gap: 0.5rem;
        }
        .ticket-seat-row {
            display: flex;
            align-items: center;
            justify-content: space-between;
            gap: 0.75rem;
            padding: 0.5rem 0.75rem;
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-sm);
            background: var(--clr-bg);
            font-size: 0.875rem;
            color: var(--clr-text);
        }
        .ticket-seat-row span { color: var(--clr-text-muted); font-size: 0.8125rem; }

        /* Footer strip */
        .ticket-footer {
            background: var(--clr-border-light);
            border-top: 1px solid var(--clr-border);
            padding: 1.125rem 2.25rem;
            display: flex;
            align-items: center;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 0.75rem;
        }
        .ticket-total {
            font-size: 1.375rem;
            font-weight: 800;
            color: var(--clr-text);
            letter-spacing: -0.5px;
        }
        .ticket-total-label {
            font-size: 0.75rem;
            color: var(--clr-text-muted);
            font-weight: 500;
        }
        .ticket-badges {
            display: flex;
            gap: 0.5rem;
            flex-wrap: wrap;
            align-items: center;
        }

        /* Extra badge colours not in main.css */
        .badge-confirmed { background: var(--clr-success-bg);  color: var(--clr-success);  border-color: var(--clr-success-border); }
        .badge-paid      { background: var(--clr-success-bg);  color: var(--clr-success);  border-color: var(--clr-success-border); }
        .badge-pending   { background: var(--clr-warning-bg);  color: var(--clr-warning);  border-color: var(--clr-warning-border); }
        .badge-failed    { background: var(--clr-error-bg);    color: var(--clr-error);    border-color: var(--clr-error-border); }

        /* No-data fallback */
        .ticket-empty {
            background: var(--clr-surface);
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-lg);
            padding: 4rem 2rem;
            text-align: center;
            max-width: 480px;
            margin: 0 auto;
            color: var(--clr-text-muted);
        }
        .ticket-empty-icon  { font-size: 2.75rem; margin-bottom: 1rem; }
        .ticket-empty-title { font-size: 1.0625rem; font-weight: 700; color: var(--clr-text); margin-bottom: 0.5rem; }

        @media (max-width: 560px) {
            .ticket-top       { padding: 1.5rem 1.25rem 1.25rem; }
            .ticket-body      { padding: 1.25rem; }
            .ticket-footer    { padding: 1rem 1.25rem; }
            .ticket-detail-grid { grid-template-columns: 1fr; gap: 1rem; }
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
    <div class="container ticket-page">

        <a href="${pageContext.request.contextPath}/my-bookings" class="ticket-back">&#8592; Back to My Bookings</a>

        <c:choose>
            <c:when test="${not empty booking}">

                <div class="ticket-card">

                    <%-- ── Top band: ref + route ── --%>
                    <div class="ticket-top">
                        <div class="ticket-brand">YatraGo &mdash; E-Ticket</div>
                        <div class="ticket-ref-label">Booking Reference</div>
                    <div class="ticket-ref">${booking.bookingReference}</div>
                    <div class="ticket-route-row">
                        <span class="ticket-city">${booking.origin}</span>
                        <span class="ticket-route-arrow">&#8594;</span>
                        <span class="ticket-city">${booking.destination}</span>
                    </div>
                    </div>

                    <%-- ── Tear-off divider ── --%>
                    <div class="ticket-divider">
                        <div class="ticket-divider-line"></div>
                        <span class="ticket-divider-icon">&#128652;</span>
                        <div class="ticket-divider-line"></div>
                    </div>

                    <%-- ── Detail grid ── --%>
                    <div class="ticket-body">
                        <div class="ticket-detail-grid">
                            <div class="ticket-detail-item">
                                <div class="ticket-detail-label">Operator</div>
                                <div class="ticket-detail-value">${booking.operatorName}</div>
                            </div>
                            <div class="ticket-detail-item">
                                <div class="ticket-detail-label">Bus Number</div>
                                <div class="ticket-detail-value">${booking.busNumber}</div>
                            </div>
                            <div class="ticket-detail-item">
                                <div class="ticket-detail-label">Bus Type</div>
                                <div class="ticket-detail-value">${booking.busType}</div>
                            </div>
                            <div class="ticket-detail-item">
                                <div class="ticket-detail-label">Departure</div>
                                <div class="ticket-detail-value">
                                    <fmt:formatDate value="${booking.departureTime}" pattern="hh:mm a" />
                                </div>
                            </div>
                            <div class="ticket-detail-item">
                                <div class="ticket-detail-label">Status</div>
                                <div class="ticket-detail-value">${booking.bookingStatus}</div>
                            </div>
                            <div class="ticket-detail-item">
                                <div class="ticket-detail-label">Total Seats</div>
                                <div class="ticket-detail-value">${booking.passengerCount}</div>
                            </div>
                        </div>

                        <%-- Seat tags --%>
                        <div class="ticket-seats-section">
                            <div class="ticket-seats-label">Seat Numbers</div>
                            <div class="ticket-seats-row">
                                <c:choose>
                                    <c:when test="${not empty booking.seats}">
                                        <c:forEach var="seat" items="${booking.seats}">
                                            <span class="ticket-seat-tag">${seat.seatNumber}</span>
                                        </c:forEach>
                                    </c:when>
                                    <c:otherwise>
                                        <span style="font-size:0.875rem;color:var(--clr-text-muted);">No seat data</span>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                            <c:if test="${not empty booking.seats}">
                                <div class="ticket-seat-list">
                                    <c:forEach var="seat" items="${booking.seats}">
                                        <div class="ticket-seat-row">
                                            <div><strong>${seat.seatNumber}</strong> &mdash; ${seat.passengerName}</div>
                                            <span>Age: ${seat.passengerAge}</span>
                                        </div>
                                    </c:forEach>
                                </div>
                            </c:if>
                        </div>
                    </div>

                    <%-- ── Footer strip: total + status badges ── --%>
                    <div class="ticket-footer">
                        <div>
                            <div class="ticket-total-label">Total Amount</div>
                            <div class="ticket-total">
                                NPR <fmt:formatNumber value="${booking.totalFare}" maxFractionDigits="0" />
                            </div>
                        </div>
                        <div class="ticket-badges">
                            <span class="badge badge-${booking.bookingStatus}">${booking.bookingStatus}</span>
                        </div>
                    </div>

                </div><%-- /.ticket-card --%>

            </c:when>
            <c:otherwise>
                <div class="ticket-empty">
                    <div class="ticket-empty-icon">&#127915;</div>
                    <p class="ticket-empty-title">No ticket to display</p>
                    <p style="font-size:0.9375rem;margin-bottom:1.5rem;">
                        This page is waiting for booking data.
                    </p>
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">Search Buses</a>
                </div>
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
