<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>결제완료 - 숙박 예약</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="container" style="max-width: 600px; padding: 40px 16px;">
        <div class="text-center">
            <div class="success-icon" style="margin-bottom:16px; color:#2563eb;">
                ✓
            </div>
            <h1 class="success-title">결제가 완료되었습니다!</h1>
            <p class="success-subtitle" style="margin-bottom:24px;">예약이 성공적으로 접수되었습니다.</p>
        </div>

        <!-- 예약번호 -->
        <div class="reservation-number" style="background:#f8f9fa; padding:12px 16px; border-radius:8px; display:flex; justify-content:space-between; margin-bottom:24px;">
            <span style="color:#6c757d;">예약번호</span>
            <strong>YNJ${order.orderId}</strong>
        </div>

        <!-- 예약 정보 카드 -->
        <div class="card mb-4">
            <div class="card-content">
                <h2 class="font-bold mb-4">예약 정보</h2>

                <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
                    <span>주문일시</span>
                    <span class="font-bold"><fmt:formatDate value="${order.orderDate}" pattern="yyyy.MM.dd HH:mm"/></span>
                </div>
                <div style="display:flex; justify-content:space-between; margin-bottom:8px;">
                    <span>결제금액</span>
                    <span class="font-bold text-blue"><fmt:formatNumber value="${order.totalPrice}" type="number" groupingUsed="true"/>원</span>
                </div>
                <div style="display:flex; justify-content:space-between;">
                    <span>결제상태</span>
                    <span class="font-bold">${order.status}</span>
                </div>
            </div>
        </div>

        <!-- 버튼 -->
        <div style="display:flex; gap:12px; margin-bottom:24px;">
            <a href="${pageContext.request.contextPath}/orders" class="btn btn-outline flex-1 text-center" style="text-decoration:none;">예약 내역 보기</a>
            <a href="${pageContext.request.contextPath}/" class="btn btn-primary flex-1 text-center" style="text-decoration:none;">홈으로 가기</a>
        </div>

        <div class="text-center" style="padding: 16px; background: #f8f9fa; border-radius: 8px; font-size:12px; color:#6c757d;">
            문의사항이 있으신가요? <strong style="color:#2563eb;">고객센터 1588-1234</strong><br/>
            평일 09:00~18:00 (주말·공휴일 휴무)
        </div>
    </div>
</body>
</html> 