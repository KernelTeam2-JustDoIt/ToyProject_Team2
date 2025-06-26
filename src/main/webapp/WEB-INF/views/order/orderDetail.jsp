<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>예약 상세</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container" style="max-width:800px; padding:24px 16px;">
    <!-- 상품 및 이용 정보 카드 -->
    <c:set var="item" value="${order.items[0]}"/>
    <div class="card mb-4">
        <div class="card-content">
            <h2 class="font-bold mb-4">상품 및 이용정보</h2>

            <div class="room-card">
                <div class="room-image" style="width:140px; height:100px;">
                    <c:choose>
                        <c:when test="${not empty item.thumbnailUrl}">
                            <img src="${item.thumbnailUrl}" alt="thumbnail"/>
                        </c:when>
                        <c:otherwise>
                            <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="thumbnail"/>
                        </c:otherwise>
                    </c:choose>
                </div>
                <div class="room-details" style="flex:1; padding-left:16px;">
                    <p class="text-gray" style="font-size:12px;">숙소 예약번호 ${order.orderId}</p>
                    <p class="font-bold mb-1">${item.accommodationName}</p>
                    <p class="text-gray mb-1" style="font-size:14px;">${item.roomName}</p>
                    <p class="text-gray mb-1" style="font-size:12px;">${item.checkInAt} ~ ${item.checkOutDate}</p>
                    <p class="text-gray" style="font-size:12px;">체크인 ${item.checkInTime} | 체크아웃 ${item.checkOutTime}</p>
                    <p class="text-gray" style="font-size:12px;">기준 ${item.standardCapacity}명 / 최대 ${item.maximumCapacity}명</p>
                </div>
            </div>
        </div>
    </div>

    <!-- 결제 정보 -->
    <div class="card mb-4">
        <div class="card-content">
            <h2 class="font-bold mb-4">결제 금액</h2>
            <div class="flex justify-between mb-2">
                <span>상품 금액</span>
                <span><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true"/>원</span>
            </div>
            <div class="flex justify-between font-bold">
                <span>총 결제 금액</span>
                <span><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true"/>원</span>
            </div>
        </div>
    </div>

    <div class="flex gap-2 mb-4">
        <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline flex-1 text-center" style="text-decoration:none;">목록으로</a>
        <a href="#" class="btn btn-primary flex-1 text-center" style="text-decoration:none;">예약 취소하기</a>
    </div>
</div>
</body>
</html> 