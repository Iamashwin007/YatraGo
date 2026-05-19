<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Page Not Found — YatraGo</title>
    <link rel="preconnect" href="https://fonts.googleapis.com">
    <link rel="preconnect" href="https://fonts.gstatic.com" crossorigin>
    <link href="https://fonts.googleapis.com/css2?family=Inter:wght@400;500;600;700;800&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/main.css">
    <style>
        .not-found-page {
            min-height: calc(100vh - var(--nav-h));
            display: flex;
            align-items: center;
            justify-content: center;
            padding: 3rem 1.5rem;
        }
        .not-found-card {
            max-width: 560px;
            text-align: center;
        }
        .not-found-code {
            font-size: clamp(3.5rem, 7vw, 5rem);
            font-weight: 800;
            color: var(--clr-primary);
            margin-bottom: 0.5rem;
        }
        .not-found-title {
            font-size: 1.75rem;
            font-weight: 800;
            color: var(--clr-text);
            margin-bottom: 0.5rem;
        }
        .not-found-subtitle {
            font-size: 1rem;
            color: var(--clr-text-muted);
            margin-bottom: 0.75rem;
        }
        .not-found-desc {
            font-size: 0.9375rem;
            color: var(--clr-text-muted);
            margin-bottom: 1.75rem;
            line-height: 1.6;
        }
        .not-found-actions {
            display: flex;
            gap: 0.75rem;
            justify-content: center;
            flex-wrap: wrap;
        }
    </style>
</head>
<body>

<%@ include file="/WEB-INF/includes/navbar.jsp" %>

<main>
    <div class="not-found-page">
        <div class="card not-found-card">
            <div class="not-found-code">404</div>
            <h1 class="not-found-title">Page Not Found</h1>
            <p class="not-found-subtitle">The page you're looking for doesn't exist.</p>
            <p class="not-found-desc">
                It may have been moved, deleted, or you may have typed the URL incorrectly.
            </p>
            <div class="not-found-actions">
                <a href="${pageContext.request.contextPath}/" class="btn btn--primary">Go to Home</a>
            </div>
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
    <div id="flash-data" data-type="${sessionScope.flashType}" data-message="${sessionScope.flashMessage}" style="display:none;"></div>
    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>
<div id="toast-container"></div>
<script src="${pageContext.request.contextPath}/js/toasts.js"></script>

</body>
</html>
