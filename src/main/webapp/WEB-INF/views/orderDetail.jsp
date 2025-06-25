<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>예약 상세</title>
</head>
<body>
<h2>예약 상세</h2>
<p>주문 번호 : ${order.orderId}</p>
<p>주문 일시 : ${order.orderDate}</p>
<p>결제 상태 : ${order.status}</p>

<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>상품명</th>
        <th>금액</th>
        <th>수량</th>
    </tr>
    <c:forEach items="${order.items}" var="item">
        <tr>
            <td>${item.roomName}</td>
            <td>${item.price}원</td>
            <td>${item.quantity}</td>
        </tr>
    </c:forEach>
</table>

<p><strong>총 결제 금액 : ${order.totalPrice}원</strong></p>
<br>
<a href="/orders">목록으로</a>
</body>
</html> 