<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>장바구니</title>
</head>
<body>
<h2>장바구니</h2>
<c:if test="${param.added eq 'true'}">
    <p style="color:green;">장바구니에 상품을 담았습니다!</p>
</c:if>

<form action="/cart/checkout" method="post">
    <table border="1" cellpadding="8" cellspacing="0">
        <tr>
            <th>선택</th>
            <th>상품명</th>
            <th>숙박 기간</th>
            <th>금액</th>
        </tr>
        <c:forEach items="${cart}" var="item" varStatus="loop">
            <tr>
                <td><input type="checkbox" name="selectedIndex" value="${loop.index}" checked></td>
                <td>${item.roomName}</td>
                <td>${item.checkInDate} ~ ${item.checkOutDate}</td>
                <td>${item.price}원</td>
            </tr>
        </c:forEach>
    </table>
    <br>
    <button type="submit">구매하기</button>
</form>
<br>
<a href="/">메인으로 이동</a>
</body>
</html> 