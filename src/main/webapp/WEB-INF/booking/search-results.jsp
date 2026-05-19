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
    <style>
        .results-page {
            padding: 3rem 1.5rem 4rem;
        }
        .results-back {
            display: inline-flex;
            align-items: center;
            gap: 0.375rem;
            font-size: 0.875rem;
            font-weight: 500;
            color: var(--clr-text-muted);
            margin-bottom: 1.5rem;
            transition: color 0.15s;
        }
        .results-back:hover { color: var(--clr-primary); text-decoration: none; }

        .results-header {
            display: flex;
            align-items: baseline;
            justify-content: space-between;
            flex-wrap: wrap;
            gap: 0.5rem;
            margin-bottom: 2rem;
        }
        .results-title {
            font-size: 1.5rem;
            font-weight: 700;
            color: var(--clr-text);
            letter-spacing: -0.5px;
        }
        .results-title span { color: var(--clr-primary); }
        .results-count {
            font-size: 0.875rem;
            color: var(--clr-text-muted);
            font-weight: 500;
        }

        /* Result cards */
        .results-list {
            display: flex;
            flex-direction: column;
            gap: 1rem;
        }
        .result-card {
            background: var(--clr-surface);
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-lg);
            box-shadow: var(--shadow-sm);
            padding: 1.5rem 1.75rem;
            display: flex;
            align-items: center;
            gap: 1.5rem;
            transition: box-shadow 0.15s, transform 0.15s;
        }
        .result-card:hover { box-shadow: var(--shadow-md); transform: translateY(-1px); }

        .result-main { flex: 1; min-width: 0; }

        .result-top {
            display: flex;
            align-items: center;
            gap: 0.625rem;
            margin-bottom: 0.875rem;
            flex-wrap: wrap;
        }
        .result-operator {
            font-size: 1rem;
            font-weight: 700;
            color: var(--clr-text);
        }
        .result-bus-tag {
            font-size: 0.75rem;
            font-weight: 600;
            background: var(--clr-primary-soft);
            color: var(--clr-primary);
            border: 1px solid rgba(14,124,123,0.2);
            border-radius: 999px;
            padding: 0.15rem 0.625rem;
        }

        .result-route {
            display: flex;
            align-items: center;
            gap: 0.625rem;
            margin-bottom: 0.875rem;
        }
        .result-city {
            font-size: 1.125rem;
            font-weight: 700;
            color: var(--clr-text);
        }
        .result-arrow {
            color: var(--clr-text-muted);
            font-size: 1.125rem;
            flex-shrink: 0;
        }

        .result-meta {
            display: flex;
            gap: 1.25rem;
            flex-wrap: wrap;
        }
        .result-meta-item {
            font-size: 0.875rem;
            color: var(--clr-text-muted);
            display: flex;
            align-items: center;
            gap: 0.3rem;
        }
        .result-meta-item strong {
            color: var(--clr-text);
            font-weight: 600;
        }

        .result-divider {
            width: 1px;
            align-self: stretch;
            background: var(--clr-border-light);
            flex-shrink: 0;
        }

        .result-action {
            flex-shrink: 0;
            display: flex;
            flex-direction: column;
            align-items: flex-end;
            gap: 0.75rem;
        }
        .result-fare {
            font-size: 1.375rem;
            font-weight: 800;
            color: var(--clr-text);
            letter-spacing: -0.5px;
        }
        .result-fare-label {
            font-size: 0.75rem;
            color: var(--clr-text-muted);
            font-weight: 500;
        }

        /* Empty state (user-page version without admin wrapper) */
        .results-empty {
            background: var(--clr-surface);
            border: 1px solid var(--clr-border);
            border-radius: var(--radius-lg);
            padding: 4rem 2rem;
            text-align: center;
            color: var(--clr-text-muted);
        }
        .results-empty-icon  { font-size: 2.75rem; margin-bottom: 1rem; }
        .results-empty-title {
            font-size: 1.0625rem;
            font-weight: 700;
            color: var(--clr-text);
            margin-bottom: 0.5rem;
        }
        .results-empty-sub   { font-size: 0.9375rem; margin-bottom: 1.5rem; }

        @media (max-width: 640px) {
            .result-card {
                flex-direction: column;
                align-items: stretch;
                gap: 1.25rem;
            }
            .result-divider { width: 100%; height: 1px; align-self: auto; }
            .result-action  { flex-direction: row; align-items: center; justify-content: space-between; }
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<main>
    <div class="container results-page">

        <a href="${pageContext.request.contextPath}/search" class="results-back">&#8592; Back to search</a>

        <div class="results-header">
            <h1 class="results-title">
                <span>${origin}</span> &rarr; <span>${destination}</span>
                &nbsp;&middot;&nbsp;
                <fmt:parseDate value="${journeyDate}" pattern="yyyy-MM-dd" var="parsedDate" />
                <fmt:formatDate value="${parsedDate}" pattern="MMM d, yyyy" />
            </h1>
            <c:choose>
                <c:when test="${not empty schedules}">
                    <span class="results-count">${schedules.size()} bus<c:if test="${schedules.size() != 1}">es</c:if> found</span>
                </c:when>
                <c:otherwise>
                    <span class="results-count">No results</span>
                </c:otherwise>
            </c:choose>
        </div>

        <c:choose>
            <c:when test="${empty schedules}">
                <div class="results-empty">
                    <div class="results-empty-icon">&#128652;</div>
                    <p class="results-empty-title">No buses found for this route and date</p>
                    <p class="results-empty-sub">
                        Try a different date or check back later &mdash; new schedules are added regularly.
                    </p>
                    <a href="${pageContext.request.contextPath}/search" class="btn btn-primary">Search Again</a>
                </div>
            </c:when>
            <c:otherwise>
                <div class="results-list">
                    <c:forEach var="schedule" items="${schedules}">
                        <div class="result-card">
                            <div class="result-main">
                                <div class="result-top">
                                    <span class="result-operator">${schedule.operatorName}</span>
                                    <span class="result-bus-tag">${schedule.busNumber}</span>
                                </div>
                                <div class="result-route">
                                    <span class="result-city">${schedule.routeOrigin}</span>
                                    <span class="result-arrow">&#8594;</span>
                                    <span class="result-city">${schedule.routeDestination}</span>
                                </div>
                                <div class="result-meta">
                                    <span class="result-meta-item">
                                        &#128336;
                                        Departs <strong>
                                            <fmt:formatDate value="${schedule.departureTime}" pattern="hh:mm a" />
                                        </strong>
                                    </span>
                                    <span class="result-meta-item">
                                        &#128197;
                                        <fmt:parseDate value="${schedule.journeyDate}" pattern="yyyy-MM-dd" var="jDate" />
                                        <fmt:formatDate value="${jDate}" pattern="MMM d, yyyy" />
                                    </span>
                                    <span class="result-meta-item">
                                        &#128186;
                                        <strong>${schedule.availableSeats}</strong>&nbsp;seats available
                                    </span>
                                </div>
                            </div>

                            <div class="result-divider"></div>

                            <div class="result-action">
                                <div>
                                    <div class="result-fare">
                                        NPR <fmt:formatNumber value="${schedule.fare}" maxFractionDigits="0" />
                                    </div>
                                    <div class="result-fare-label">per seat</div>
                                </div>
                                <a href="${pageContext.request.contextPath}/seat-select?scheduleId=${schedule.id}"
                                   class="btn btn-primary">Book Now</a>
                            </div>
                        </div>
                    </c:forEach>
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
