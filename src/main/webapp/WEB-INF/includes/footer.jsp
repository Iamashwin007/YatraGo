<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>

<footer class="footer">
    <span class="footer-brand">
        Yatra<span>Go</span>
    </span>
    &copy; 2026 YatraGo. ${param.footerNote}
</footer>

<script>
    (() => {
        const nav = document.querySelector('.navbar');
        const toggle = document.getElementById('navToggle');
        const menu = document.getElementById('mainNav');

        if (nav) {
            window.addEventListener(
                'scroll',
                () => {
                    nav.classList.toggle('scrolled', window.scrollY > 8);
                },
                { passive: true }
            );
        }

        if (toggle && menu) {
            toggle.addEventListener('click', () => {
                menu.classList.toggle('nav-open');
            });
        }
    })();
</script>

<c:if test="${not empty sessionScope.flashMessage}">
    <div id="flash-data"
         data-type="${sessionScope.flashType}"
         data-message="${sessionScope.flashMessage}"
         style="display: none;">
    </div>

    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>

<div id="toast-container"></div>

<script src="${pageContext.request.contextPath}/js/toasts.js"></script>