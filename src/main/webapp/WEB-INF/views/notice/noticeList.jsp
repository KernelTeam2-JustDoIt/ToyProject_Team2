<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항</title>
    <style>
        body {
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
</div>
<div class="notice-list-container">
<table>
    <thead>
    <tr>
        <th>제목</th>
        <th>작성일</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="notice" items="${noticeList}">
        <tr>
            <td><a href="${pageContext.request.contextPath}/notice/${notice.noticeId}">${notice.title}</a></td>
            <td>${notice.formattedDate}</td>

        </tr>
    </c:forEach>
    </tbody>
</table>

<a href="${pageContext.request.contextPath}/notice/add" class="write-btn">공지 작성</a>
   <!-- 공지사항 페이징처리 -->
    <div style="margin-top: 30px; text-align: center;">
        <c:if test="${hasPrevBlock}">
            <a href="${pageContext.request.contextPath}/notice/list?page=${startPage - 1}">&laquo; 이전</a>
        </c:if>

        <c:forEach begin="${startPage}" end="${endPage}" var="i">
            <a href="${pageContext.request.contextPath}/notice/list?page=${i}"
               style="${i == currentPage ? 'font-weight:bold; text-decoration:underline;' : ''}">
                    ${i}
            </a>
        </c:forEach>

        <c:if test="${hasNextBlock}">
            <a href="${pageContext.request.contextPath}/notice/list?page=${endPage + 1}">다음 &raquo;</a>
        </c:if>
    </div>
</div>

</body>
</html>
