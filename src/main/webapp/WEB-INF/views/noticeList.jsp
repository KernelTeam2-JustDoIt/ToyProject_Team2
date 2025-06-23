<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>공지사항 목록</title>
    <style>
        body {
            font-family: 'Segoe UI', sans-serif;
            margin: 50px;
        }
        table {
            width: 100%;
            border-collapse: collapse;
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
        a:hover {
            text-decoration: underline;
        }
        .write-btn {
            margin-top: 20px;
            display: inline-block;
            padding: 8px 16px;
            background-color: #0066cc;
            color: white;
            text-decoration: none;
            border-radius: 4px;
        }
    </style>
</head>
<body>

<h2>공지사항 목록</h2>

<table>
    <thead>
    <tr>
        <th>번호</th>
        <th>제목</th>
        <th>작성일</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="notice" items="${noticeList}">
        <tr>
            <td>${notice.noticeId}</td>
            <td><a href="${pageContext.request.contextPath}/notice/${notice.noticeId}">${notice.title}</a></td>
            <td>${notice.postedAt}</td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<a href="${pageContext.request.contextPath}/notice/add" class="write-btn">공지 작성</a>

</body>
</html>
