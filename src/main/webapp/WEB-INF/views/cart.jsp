<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/cart.css'/>">
</head>
<body>

<header class="header">
    <div class="back" title="뒤로가기" onclick="history.back()"></div>
    <h1>장바구니</h1>
    <div class="home" title="홈" onclick="location.href='/'"></div>
</header>

<div class="cart-container">
    <div class="summary-bar">
        전체 항목: <strong>${fn:length(cartList)}</strong>개
    </div>

    <c:forEach var="item" items="${cartList}">
        <div class="cart-item">
            <!-- 체크박스 -->
            <input type="checkbox" class="chk-item" data-cart-id="${item.cartId}"/>

            <!-- 방 정보 -->
            <div class="item-info">
                <div class="title">
                    <c:out value="${item.roomName}"/>
                    &nbsp;(숙소ID:<c:out value="${item.accommodationId}"/>) <!-- 객실 구현 시 rooId로 바꾸기-->
                </div>
                <div class="dates">
                    <fmt:formatDate value="${item.desiredCheckInAt}" pattern="yyyy.MM.dd (E)"/>
                    –
                    <fmt:formatDate value="${item.desiredCheckOutAt}" pattern="yyyy.MM.dd (E)"/>
                </div>
                <div class="details">
                    체크인 <c:out value="${item.checkinTime}"/> |
                    |
                    체크아웃 <c:out value="${item.checkoutTime}"/>
                    <br/>
                    기준인원 <c:out value="${item.standardCapacity}"/>명 /
                    최대인원 <c:out value="${item.maximumCapacity}"/>명
                </div>
            </div>

            <!-- 인원 수량 수정 폼 -->
            <form action="<c:url value='/cart/update'/>" method="post" class="form-update">
                <input type="hidden" name="cartId" value="${item.cartId}"/>
                <label>성인
                    <input type="number" name="adultCount" value="${item.adultCount}" min="1"/>
                </label>
                <label>어린이
                    <input type="number" name="childCount" value="${item.childCount}" min="0"/>
                </label>
                <button type="submit">수정</button>
            </form>

            <!-- 삭제 폼 -->
            <form action="<c:url value='/cart/delete'/>" method="post" class="form-delete">
                <input type="hidden" name="cartId" value="${item.cartId}"/>
                <button type="submit">삭제</button>
            </form>
        </div>
    </c:forEach>
</div>

</body>
</html>
