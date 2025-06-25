<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeList.css" />
    <meta charset="UTF-8">
    <title>공지사항</title>
</head>
<body>
<!-- ✅ 상단 헤더 (홈 + 제목 + 관리자 페이지 버튼) -->
<div class="notice-header">
    <!-- 홈 버튼 -->
    <a href="<c:url value='/' />">
        <img src="${pageContext.request.contextPath}/resources/image/home_icon.png" alt="홈" class="home-icon" />
    </a>

    <!-- 공지사항 제목 -->
    <div class="notice-title">공지사항</div>

    <!-- 관리자 전용 버튼 -->
    <c:if test="${not empty sessionScope.loginAdmin and sessionScope.loginAdmin.roleId == 1}">
        <a href="${pageContext.request.contextPath}/admin/page" class="admin-link">관리자 페이지</a>
    </c:if>
</div>

<hr class="divider" />

<!-- ✅ 검색창 -->
<form method="get" action="${pageContext.request.contextPath}/notice/list" class="search-bar">
    <input type="text" name="keyword" value="${keyword}" placeholder="제목 또는 내용을 검색하세요" />
    <button type="submit">검색</button>
</form>

<div class="notice-list-container">
    <table class="notice-table">
        <thead>
        <tr>
            <th>제목</th>
            <th>작성일</th>
            <th>조회수</th>
        </tr>
        </thead>
        <tbody>
        <!-- 상단 고정 공지 -->
        <c:forEach var="notice" items="${pinnedNotices}">
            <tr class="pinned">
                <td>
                    <span class="pin-icon">📌</span>
                    <a href="${pageContext.request.contextPath}/notice/${notice.noticeId}" class="pinned-title">
                            ${notice.title}
                    </a>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty notice.formattedDate}">
                            ${notice.formattedDate}
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>${notice.viewCount}</td>
            </tr>
        </c:forEach>

        <!-- 일반 공지 -->
        <c:forEach var="notice" items="${noticeList}">
            <tr class="${notice.noticeStatus == 'NOACT' ? 'inactive' : ''}">
                <td>
                    <a href="${pageContext.request.contextPath}/notice/${notice.noticeId}" class="${notice.noticeStatus == 'NOACT' ? 'inactive-title' : ''}">
                            ${notice.title}
                    </a>
                </td>
                <td>
                    <c:choose>
                        <c:when test="${not empty notice.formattedDate}">
                            ${notice.formattedDate}
                        </c:when>
                        <c:otherwise>-</c:otherwise>
                    </c:choose>
                </td>
                <td>${notice.viewCount}</td>
            </tr>
        </c:forEach>
        </tbody>
    </table>

    <!-- 관리자 작성 버튼 -->
    <c:if test="${not empty sessionScope.loginAdmin and sessionScope.loginAdmin.roleId == 1}">
        <div class="write-btn-wrapper">
            <a href="${pageContext.request.contextPath}/notice/form" class="write-btn">공지 작성</a>
        </div>
    </c:if>

    <!-- ✅ 페이징 -->
    <div class="pagination">
        <c:if test="${hasPrevBlock}">
            <a href="${pageContext.request.contextPath}/notice/list?page=${startPage - 1}&keyword=${keyword}" class="page-link">&laquo; 이전</a>
        </c:if>

        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <a href="${pageContext.request.contextPath}/notice/list?page=${i}&keyword=${keyword}" class="page-link ${i == currentPage ? 'active' : ''}">
                    ${i}
            </a>
        </c:forEach>

        <c:if test="${hasNextBlock}">
            <a href="${pageContext.request.contextPath}/notice/list?page=${endPage + 1}&keyword=${keyword}" class="page-link">다음 &raquo;</a>
        </c:if>
    </div>
</div>
</body>
</html>
