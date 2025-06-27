<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약 내역</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <style>
        .review-btn {
            background-color: #007bff;
            color: white;
            border: none;
            padding: 8px 16px;
            border-radius: 4px;
            font-size: 14px;
            cursor: pointer;
            text-decoration: none;
            display: inline-block;
            margin-top: 8px;
        }
        .review-btn:hover {
            background-color: #0056b3;
        }
        .review-btn.disabled {
            background-color: #6c757d;
            cursor: not-allowed;
            opacity: 0.6;
        }
        .review-btn.disabled:hover {
            background-color: #6c757d;
        }
        .button-container {
            display: flex;
            gap: 8px;
            align-items: center;
            margin-top: 8px;
        }
    </style>
</head>
<body>
<%@ include file="/WEB-INF/views/common/header.jsp" %>

<div class="container" style="max-width: 800px; padding: 24px 16px;">
    <!-- 주문이 없는 경우 -->
    <c:if test="${empty orders}">
        <div class="empty-state">
            <p class="empty-title">아직 예약 내역이 없습니다.</p>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary">숙소 둘러보기</a>
        </div>
    </c:if>

    <!-- 주문 목록 -->
    <c:forEach var="order" items="${orders}">
        <c:set var="item" value="${order.items[0]}"/>
        <div class="card">
            <div class="card-content">
                <!-- 상단 날짜 & 상세보기 링크 -->
                <div class="flex justify-between items-center mb-2">
                    <h3 class="font-bold">
                        <fmt:parseDate var="checkInDate" value="${item.checkInAt}" pattern="yyyy-MM-dd"/>
                        <fmt:formatDate value="${checkInDate}" pattern="yyyy.MM.dd (E)"/>
                    </h3>
                    <a href="${pageContext.request.contextPath}/orders/detail?orderId=${order.orderId}" class="text-blue" style="font-size:14px; text-decoration:none;">상세 보기 &gt;</a>
                </div>

                <div class="room-card">
                    <!-- 이미지 -->
                    <div class="room-image" style="width:120px; height:90px;">
                        <c:choose>
                            <c:when test="${not empty item.thumbnailUrl}">
                                <img src="${item.thumbnailUrl}" alt="room-img"/>
                            </c:when>
                            <c:otherwise>
                                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="room-img"/>
                            </c:otherwise>
                        </c:choose>
                    </div>
                    <!-- 정보 -->
                    <div class="room-details" style="flex:1; padding-left:16px;">
                        <div class="flex justify-between items-center mb-1">
                            <span class="badge">${order.status eq 'COMPLETED' ? '이용완료' : order.status}</span>
                        </div>
                        <p class="font-bold mb-1">${item.accommodationName}</p>
                        <p class="text-gray mb-1" style="font-size:14px;">${item.roomName}</p>
                        <p class="text-gray" style="font-size:12px;">${item.checkInAt} ~ ${item.checkOutDate}</p>
                        
                        <!-- 리뷰 작성 버튼 -->
                        <c:if test="${order.status eq 'COMPLETED'}">
                            <div class="button-container">
                                <c:choose>
                                    <c:when test="${item.canWriteReview}">
                                        <a href="${pageContext.request.contextPath}/domestic/review/${item.accommId}" class="review-btn">
                                            리뷰 작성
                                        </a>
                                    </c:when>
                                    <c:otherwise>
                                        <button class="review-btn disabled" disabled>
                                            리뷰 작성 기간 만료
                                        </button>
                                    </c:otherwise>
                                </c:choose>
                                <c:if test="${not item.canWriteReview && item.daysAfterCheckout > 7}">
                                    <small style="color: #6c757d; margin-left: 8px;">
                                        (체크아웃 후 일주일 이내에만 작성 가능)
                                    </small>
                                </c:if>
                            </div>
                        </c:if>
                    </div>
                </div>
            </div>
        </div>
    </c:forEach>
</div>
</body>
</html> 