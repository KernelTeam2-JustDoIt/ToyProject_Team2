<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header class="admin-header">
    <div class="logo">
        <a href="${pageContext.request.contextPath}/" class="admin-home-link">
            야눕자
        </a>
    </div>

    <nav class="admin-nav">
        <a href="${pageContext.request.contextPath}/notice/list" class="admin-link">공지사항</a>
        <a href="${pageContext.request.contextPath}/faq/list" class="admin-link">FAQ</a>
        <a href="${pageContext.request.contextPath}/qna/list" class="admin-link">QNA</a>
        <a href="${pageContext.request.contextPath}/customer/logout" class="admin-link">로그아웃</a>
    </nav>

</header>
