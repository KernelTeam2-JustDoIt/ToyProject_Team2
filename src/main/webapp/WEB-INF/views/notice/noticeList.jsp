<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <style>

        .page-link {
            display: inline-block;
            margin: 0 4px;
            padding: 6px 12px;
            border-radius: 6px;
            background-color: #f4f4f4;
            color: #333;
            text-decoration: none;
            transition: background-color 0.2s;
            font-weight: 500;
        }

        .page-link:hover {
            background-color: #e0ecff;
        }

        .page-link.active {
            background-color: #0066cc;
            color: white;
            font-weight: bold;
            cursor: default;
        }
        .body {
            font-family: 'Segoe UI', sans-serif;
            margin: 50px;
        }
        .header {
            display: flex;
            align-items: center;
            justify-content: space-between;
        }
        .home-icon {
            font-size: 20px;
            text-decoration: none;
        }
        .title {
            text-align: center;
            flex-grow: 1;
            margin-left: -20px;
            font-size: 24px;
            font-weight: bold;
        }
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 30px;
        }
        thead {
            background-color: #f0f0f0;
        }
        th, td {
            padding: 12px;
            border-bottom: 1px solid #ccc;
            text-align: left;
        }
        a {
            text-decoration: none;
            color: #0066cc;
        }
        .write-btn {
            margin-top: 20px;
            padding: 8px 16px;
            background-color: #0066cc;
            color: white;
            text-decoration: none;
            border-radius: 4px;
            display: inline-block;
        }
    </style>
</head>
<body>
<a href="<c:url value='/' />">
    <img src="${pageContext.request.contextPath}/resources/image/home_icon.png" alt="홈" style="width: 24px;" />
</a>

    <div class="title">공지사항</div>
<hr style="border: none; border-top: 1px solid #ccc; margin: 20px 0;">
    <div style="width: 24px;"></div> <!-- 우측 공간 맞추기 -->
<div class="notice-list-container">
<table>
    <thead>
    <tr>
        <th>제목</th>
        <th>작성일</th>
    </tr>
    </thead>
    <tbody>
    <!-- 상단 고정 공지 -->
    <c:forEach var="notice" items="${pinnedNotices}">
        <tr style="background-color: #fff9e6;"> <!-- 연한 노란색 배경 -->
            <td>
                <span style="color: #ff9800;">📌</span>
                <a href="${pageContext.request.contextPath}/notice/${notice.noticeId}" style="font-weight: bold;">
                        ${notice.title}
                </a>
            </td>
            <td>
                <c:choose>
                    <c:when test="${not empty notice.formattedDate}">
                        ${notice.formattedDate}
                    </c:when>
                    <c:otherwise>
                        -
                    </c:otherwise>
                </c:choose>
            </td>

        </tr>
    </c:forEach>

    <!-- 일반 공지 -->
    <c:forEach var="notice" items="${noticeList}">
        <tr
                <c:if test="${notice.noticeStatus == 'NOACT'}">
                    style="background-color: #f2f2f2; color: #888; font-style: italic;"
                </c:if>
        >
            <td>
                <a href="${pageContext.request.contextPath}/notice/${notice.noticeId}"
                   style="<c:if test='${notice.noticeStatus == "NOACT"}'>color: #888;</c:if>">
                        ${notice.title}
                </a>
            </td>
            <td>
                <c:choose>
                    <c:when test="${not empty notice.formattedDate}">
                        ${notice.formattedDate}
                    </c:when>
                    <c:otherwise>
                        -
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>

    </tbody>
</table>
 <!--관리자 전용 작성 버튼-->
    <c:if test="${not empty sessionScope.loginAdmin and sessionScope.loginAdmin.roleId == 1}">
        <a href="${pageContext.request.contextPath}/notice/form" class="write-btn">공지 작성</a>
    </c:if>

    <!-- 공지사항 페이징처리 -->
    <div style="margin-top: 30px; text-align: center;">
        <!-- 이전 버튼 -->
        <c:if test="${hasPrevBlock}">
            <a href="${pageContext.request.contextPath}/notice/list?page=${startPage - 1}"
               class="page-link"
               style="margin-right: 10px; padding: 6px 12px; background-color: #eee; border-radius: 4px; text-decoration: none;">
                &laquo; 이전
            </a>
        </c:if>

        <!-- 페이지 번호 반복 -->
        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <a href="${pageContext.request.contextPath}/notice/list?page=${i}"
               class="page-link"
               style="
                       display: inline-block;
                       margin: 0 4px;
                       padding: 6px 12px;
                       border-radius: 4px;
                       background-color: ${i == currentPage ? '#0066cc' : '#f0f0f0'};
                       color: ${i == currentPage ? 'white' : '#333'};
                       text-decoration: none;
                       font-weight: ${i == currentPage ? 'bold' : 'normal'};
                       ">
                    ${i}
            </a>
        </c:forEach>

        <!-- 다음 버튼 -->
        <c:if test="${hasNextBlock}">
            <a href="${pageContext.request.contextPath}/notice/list?page=${endPage + 1}"
               class="page-link"
               style="margin-left: 10px; padding: 6px 12px; background-color: #eee; border-radius: 4px; text-decoration: none;">
                다음 &raquo;
            </a>
        </c:if>
    </div>

</div>

</body>
</html>
