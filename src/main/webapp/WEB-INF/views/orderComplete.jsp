<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html>
<head>
    <title>결제 완료</title>
</head>
<body>
<h2>결제가 완료되었습니다!</h2>
<p>주문 번호 : ${order.orderId}</p>
<p>결제 금액 : ${order.totalPrice}원</p>
<p>결제 상태 : ${order.status}</p>
<p>주문 일시 : ${order.orderDate}</p>
<br>
<a href="/orders">예약 내역 보러가기</a>
</body>
</html> 