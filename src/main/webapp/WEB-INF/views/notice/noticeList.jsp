<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeList.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/adminHeader.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />
    <meta charset="UTF-8">
    <title>공지사항</title>
</head>
<body>
<%-- 로그인한 사람이 관리자면 adminHeader.jsp include --%>
<c:choose>
    <c:when test="${not empty sessionScope.loginAdmin}">
        <jsp:include page="/WEB-INF/views/common/adminHeader.jsp" />
    </c:when>
    <c:otherwise>
        <jsp:include page="/WEB-INF/views/common/header.jsp" />
    </c:otherwise>
</c:choose>

<div class="notice-list-container">
    <!-- ✅ 공지사항 타이틀 -->
    <div class="notice-title-wrapper">
        <h2 class="notice-title">
            <a href="${pageContext.request.contextPath}/notice/list" class="notice-title-link">공지사항</a>
        </h2>
    </div>

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
            <tr class="${notice.noticeStatus == 'NOACT' ? 'inactive-notice' : ''}">
                <td>
                    <a href="${pageContext.request.contextPath}/notice/${notice.noticeId}"
                       class="${notice.noticeStatus == 'NOACT' ? 'inactive-link' : ''}">
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
 <!--관리자 전용 작성 버튼-->
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
    <jsp:include page="/WEB-INF/views/common/footer.jsp"/>
</body>
</html>
