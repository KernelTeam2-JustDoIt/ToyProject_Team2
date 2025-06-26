<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>${room.accommodationName} - 숙소 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_cart.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>
    <!-- Header -->
    <%--
    <header class="header">
        <div class="header-container">
            <div class="header-left">
                <button class="btn btn-ghost" onclick="history.back()">←</button>
                <h1 class="font-bold">${room.accommodationName} (${room.roomName})</h1>
            </div>
            <div class="header-right">
                <a href="${pageContext.request.contextPath}/cart" class="btn btn-ghost">장바구니</a>
            </div>
        </div>
    </header>
    --%>

    <!-- Navigation Tabs (간략화) -->
    <nav class="nav-tabs">
        <div class="nav-tabs-container">
            <a href="#" class="nav-tab active">객실선택</a>
            <a href="#" class="nav-tab">숙소소개</a>
            <a href="#" class="nav-tab">이용안내</a>
        </div>
    </nav>

    <!-- 객실 카드 -->
    <div class="container">
        <div class="card">
            <div class="room-card">
                <div class="room-image">
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="${room.roomName}" />
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
                        <div class="price-info">
                            <div class="cancellation-policy">
                                체크인 ${room.checkInTime} / 체크아웃 ${room.checkOutTime}
                            </div>
                            <div class="current-price">${room.price}원 / 1박</div>
                            <div class="action-buttons" style="margin-top:8px;">
                                <form action="${pageContext.request.contextPath}/cart/add" method="post">
                                    <input type="hidden" name="roomId" value="${room.roomId}" />
                                    <button class="btn btn-primary">장바구니에 담기</button>
                                </form>
                            </div>
                        </div>
                    </div>
                </div>
            </div>
        </div>
    </div>
</body>
</html> 