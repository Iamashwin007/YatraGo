<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib uri="jakarta.tags.core" prefix="c" %>
<%@ taglib uri="jakarta.tags.fmt" prefix="fmt" %>
<%@ taglib uri="jakarta.tags.functions" prefix="fn" %>
<jsp:include page="/WEB-INF/includes/header.jsp">
    <jsp:param name="pageTitle" value="My Profile" />
</jsp:include>
<jsp:include page="/WEB-INF/includes/navbar.jsp">
    <jsp:param name="activeNav" value="profile" />
</jsp:include>
<main class="auth-page">
    <div class="profile-page">

        <%-- Read-only profile card --%>
        <div class="auth-card">
            <div class="profile-avatar" aria-hidden="true">
                ${fn:toUpperCase(fn:substring(sessionScope.user.name, 0, 1))}
            </div>
            <h1 class="auth-title" style="text-align:center;">My Profile</h1>
            <p class="auth-subtitle" style="text-align:center;">Your account details</p>
            <div class="profile-info">
                <div class="profile-row">
                    <span class="profile-label">Name</span>
                    <span class="profile-value">${sessionScope.user.name}</span>
                </div>
                <div class="profile-row">
                    <span class="profile-label">Email</span>
                    <span class="profile-value">${sessionScope.user.email}</span>
                </div>
                <div class="profile-row">
                    <span class="profile-label">Role</span>
                    <span class="profile-value">
                        <c:choose>
                            <c:when test="${sessionScope.user.role == 'admin'}">Admin</c:when>
                            <c:otherwise>User</c:otherwise>
                        </c:choose>
                    </span>
                </div>
                <div class="profile-row">
                    <span class="profile-label">Joined</span>
                    <span class="profile-value">
                        <fmt:formatDate value="${sessionScope.user.createdAt}" pattern="MMMM d, yyyy" />
                    </span>
                </div>
            </div>
        </div>

        <%-- Form 1: Edit Name --%>
        <div class="auth-card">
            <h2 class="profile-section-title">Edit Name</h2>
            <form action="${pageContext.request.contextPath}/profile" method="post">
                <input type="hidden" name="action" value="updateName">
                <div class="form-group">
                    <label class="form-label" for="name">Full Name</label>
                    <input class="form-input" type="text" id="name" name="name"
                           value="${sessionScope.user.name}" required>
                </div>
                <button type="submit" class="btn btn-primary btn-block">Save Name</button>
            </form>
        </div>

        <%-- Form 2: Change Password --%>
        <div class="auth-card">
            <h2 class="profile-section-title">Change Password</h2>
            <form id="pwForm" action="${pageContext.request.contextPath}/profile" method="post" novalidate>
                <input type="hidden" name="action" value="updatePassword">
                <div class="form-group">
                    <label class="form-label" for="currentPassword">Current Password</label>
                    <input class="form-input" type="password" id="currentPassword" name="currentPassword"
                           placeholder="Enter current password" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="newPassword">New Password</label>
                    <input class="form-input" type="password" id="newPassword" name="newPassword"
                           placeholder="At least 6 characters" required>
                </div>
                <div class="form-group">
                    <label class="form-label" for="confirmPassword">Confirm New Password</label>
                    <input class="form-input" type="password" id="confirmPassword" name="confirmPassword"
                           placeholder="Repeat new password" required>
                </div>
                <p id="pw-error" style="color:var(--clr-error);font-size:0.875rem;font-weight:500;margin-bottom:1rem;display:none;"></p>
                <button type="submit" class="btn btn-primary btn-block">Change Password</button>
            </form>
        </div>

    </div>
</main>

<script>
    (function () {
        var form  = document.getElementById('pwForm');
        var error = document.getElementById('pw-error');
        form.addEventListener('submit', function (e) {
            var current = document.getElementById('currentPassword').value;
            var newPw   = document.getElementById('newPassword').value;
            var confirm = document.getElementById('confirmPassword').value;
            if (!current || !newPw || !confirm) {
                e.preventDefault();
                error.textContent = 'All password fields are required.';
                error.style.display = 'block';
                return;
            }
            if (newPw !== confirm) {
                e.preventDefault();
                error.textContent = 'New passwords do not match.';
                error.style.display = 'block';
                return;
            }
            if (newPw.length < 6) {
                e.preventDefault();
                error.textContent = 'Password must be at least 6 characters.';
                error.style.display = 'block';
                return;
            }
            error.style.display = 'none';
        });
    }());
</script>

<c:if test="${not empty sessionScope.flashMessage}">
    <div id="flash-data" data-type="${sessionScope.flashType}" data-message="${sessionScope.flashMessage}" style="display:none;"></div>
    <c:remove var="flashMessage" scope="session"/>
    <c:remove var="flashType" scope="session"/>
</c:if>
<div id="toast-container"></div>
<script src="${pageContext.request.contextPath}/js/toasts.js"></script>

<jsp:include page="/WEB-INF/includes/footer.jsp">
    <jsp:param name="footerNote" value="Built for Nepal." />
</jsp:include>