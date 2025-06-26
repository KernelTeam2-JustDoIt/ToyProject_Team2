<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>${room.accommodationName} - 숙박 예약</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<!-- 탭 메뉴 (간략) -->
<nav class="nav-tabs">
    <div class="nav-tabs-container">
        <a href="#" class="nav-tab active">객실선택</a>
        <a href="#" class="nav-tab">숙소소개</a>
        <a href="#" class="nav-tab">이용안내</a>
    </div>
</nav>

<!-- 객실 카드 (단일) -->
<div class="container" style="margin-top:24px;">
    <div class="card">
        <div class="room-card">
            <div class="room-image">
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="${room.roomName}">
                <div class="image-counter">1/5</div>
            </div>
            <div class="room-details">
                <div class="room-header">
                    <div class="room-info">
                        <h3>${room.roomName}</h3>
                        <p>기준 ${room.standardCapacity}인 / 최대 ${room.maximumCapacity}인</p>
                        <p>침실 ${room.bedCount}개</p>
                    </div>
                </div>

                <div class="room-pricing">
                    <div class="cancellation-policy">
                        체크인 ${room.checkInTime} ~ 체크아웃 ${room.checkOutTime}
                    </div>
                    <div class="current-price">${room.price}원 / 1박</div>

                    <!-- 장바구니 담기 -->
                    <form action="${pageContext.request.contextPath}/cart/add" method="post" style="margin-top:12px;">
                        <input type="hidden" name="roomId" value="${room.roomId}" />
                        <button class="btn btn-primary">장바구니에 담기</button>
                    </form>

                    <!-- 바로 예약하기 -->
                    <a href="${pageContext.request.contextPath}/reservation?roomId=${room.roomId}" class="btn" style="margin-top:8px; display:inline-block;">예약하기</a>
                </div>
            </div>
        </div>
    </div>
</div>
</body>
</html> 