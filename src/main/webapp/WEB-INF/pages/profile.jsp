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
</main>
<jsp:include page="/WEB-INF/includes/footer.jsp">
    <jsp:param name="footerNote" value="Built for Nepal." />
</jsp:include>