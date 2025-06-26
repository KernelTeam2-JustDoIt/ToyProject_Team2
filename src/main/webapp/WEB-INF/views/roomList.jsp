<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>객실 목록</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pension_style.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
<h2>객실 목록</h2>
<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>ID</th>
        <th>객실명</th>
        <th>가격</th>
        <th>상세</th>
    </tr>
    <c:forEach items="${roomList}" var="room">
        <tr>
            <td>${room.roomId}</td>
            <td>${room.roomName}</td>
            <td>${room.price}원</td>
            <td><a href="${pageContext.request.contextPath}/rooms/${room.roomId}">보기</a></td>
        </tr>
    </c:forEach>
</table>
</body>
</html> 