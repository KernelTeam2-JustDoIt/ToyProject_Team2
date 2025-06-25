<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>예약 내역</title>
</head>
<body>
<h2>예약 내역</h2>
<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>주문 번호</th>
        <th>주문 일시</th>
        <th>금액</th>
        <th>상태</th>
        <th>액션</th>
    </tr>
    <c:forEach items="${orders}" var="order">
        <tr>
            <td>${order.orderId}</td>
            <td>${order.orderDate}</td>
            <td>${order.totalPrice}원</td>
            <td>${order.status}</td>
            <td>
                <a href="/orders/detail?orderId=${order.orderId}">상세보기</a>
            </td>
        </tr>
    </c:forEach>
</table>
<br>
<a href="/">메인으로</a>
</body>
</html> 