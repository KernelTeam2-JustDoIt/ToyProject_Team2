<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>예약/결제</title>
</head>
<body>
<h2>예약/결제</h2>
<table border="1" cellpadding="8" cellspacing="0">
    <tr>
        <th>상품명</th>
        <th>숙박 기간</th>
        <th>금액</th>
    </tr>
    <c:forEach items="${cart}" var="item">
        <tr>
            <td>${item.roomName}</td>
            <td>${item.checkInDate} ~ ${item.checkOutDate}</td>
            <td>${item.price}원</td>
        </tr>
    </c:forEach>
</table>

<h3>총 결제 금액 : ${totalPrice}원</h3>

<form action="/reservation/complete" method="post">
    <button type="submit">${totalPrice}원 결제하기</button>
</form>
<br>
<a href="/cart">장바구니로 돌아가기</a>
</body>
</html> 