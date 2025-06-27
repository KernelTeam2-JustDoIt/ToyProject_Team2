<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>장바구니 - 숙박 예약</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="container" style="max-width: 800px; padding: 24px 16px;">
        <!-- Empty cart -->
        <c:if test="${empty cart}">
            <div class="empty-state">
                <div class="empty-icon">🛒</div>
                <h2 class="empty-title">아직 장바구니가 비어있어요</h2>
                <p class="empty-subtitle">원하는 상품을 담아주시면 한 번에 예약할 수 있어요.</p>
                <a href="${pageContext.request.contextPath}/" class="btn btn-primary">담으러 가기</a>
            </div>
        </c:if>

        <!-- Cart list -->
        <c:if test="${not empty cart}">
            <form action="${pageContext.request.contextPath}/cart/checkout" method="post">
                <table class="cart-table" style="width:100%; border-collapse:collapse; margin-bottom:24px;">
                    <thead>
                        <tr style="background:#f8f9fa;">
                            <th style="padding:8px;">선택</th>
                            <th style="padding:8px; text-align:left;">상품명</th>
                            <th style="padding:8px;">숙박 기간</th>
                            <th style="padding:8px;">인원</th>
                            <th style="padding:8px;">금액</th>
<%--                            <th style="padding:5px;">삭제</th>--%>
                        </tr>
                    </thead>
                    <tbody>
                        <c:forEach var="item" items="${cart}">
                            <tr style="border-bottom:1px solid #e9ecef;">
                                <td style="text-align:center; padding:8px;">
                                    <input type="checkbox" name="selectedCartId" value="${item.cartId}" checked>
                                </td>
                                <td style="padding:8px;">${item.roomName}</td>
                                <td style="padding:8px; font-size:14px; color:#6c757d;">
                                    체크인 ${item.checkinTime} | 체크아웃 ${item.checkoutTime}<br/>
                                    기준 ${item.standardCapacity}명 / 최대 ${item.maximumCapacity}명
                                </td>

                                <td style="padding:8px; text-align:center;">
                                    <form action="${pageContext.request.contextPath}/cart/update"
                                          method="post"
                                          style="display:inline-block;">
                                        <input type="hidden" name="cartId"   value="${item.cartId}"/>
                                        <input type="hidden" name="roomId"   value="${item.roomId}"/>
                                        성인
                                        <input type="number"
                                               name="adultCount"
                                               value="${item.adultCount}"
                                               min="0"
                                               data-cart-id="${item.cartId}"
                                               class="adult-count-input"
                                               style="width:40px; margin:0 4px;"/>
                                        아동
                                        <input type="number"
                                               name="childCount"
                                               value="${item.childCount}"
                                               min="0"
                                               data-cart-id="${item.cartId}"
                                               class="child-count-input"
                                               style="width:40px; margin:0 4px;"/>
                                        <button type="submit"
                                                style="padding:4px 8px; font-size:12px; margin-left:4px;">
                                            수정
                                        </button>
                                    </form>
                            <td style="padding:8px; font-weight:bold; text-align:right;">${item.price}원</td>
                                <!-- 삭제 버튼 -->
                                <td style="padding:8px; text-align:center;">
                                    <form action="${pageContext.request.contextPath}/cart/delete"
                                          method="post"
                                          style="display:inline-block; margin:0;">
                                        <input type="hidden" name="cartId" value="${item.cartId}"/>
                                        <button type="submit"
                                                style="background:none;
                                                   border:none;
                                                   color:#dc3545;
                                                   cursor:pointer;
                                                   padding:4px 8px;
                                                   font-size:12px;">
                                            삭제
                                        </button>
                                    </form>
                                </td>
                            </tr>
                        </c:forEach>
                    </tbody>
                </table>



                <div style="text-align:right; margin-bottom:24px;">
                    <button type="submit" class="btn btn-primary" onclick="return validateCheckout()">구매하기</button>
                </div>
            </form>
        </c:if>
    </div>

    <script>
        function validateCheckout() {
            const checkboxes = document.querySelectorAll('input[name="selectedCartId"]:checked');
            if (checkboxes.length === 0) {
                alert('구매할 상품을 선택해주세요.');
                return false;
            }
            
            // 선택된 상품들의 인원수 검증
            for (let checkbox of checkboxes) {
                const cartId = checkbox.value;
                const adultInput = document.querySelector(`input.adult-count-input[data-cart-id="${cartId}"]`);
                const childInput = document.querySelector(`input.child-count-input[data-cart-id="${cartId}"]`);
                
                const adultCount = parseInt(adultInput.value) || 0;
                const childCount = parseInt(childInput.value) || 0;
                
                if (adultCount + childCount < 1) {
                    alert('선택한 상품의 인원수를 1명 이상 입력해주세요.');
                    adultInput.focus();
                    return false;
                }
            }
            
            return true;
        }
    </script>
</body>
</html>