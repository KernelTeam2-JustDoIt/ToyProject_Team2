<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>예약/결제 - 숙박 예약</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/common_cart.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
</head>
<body>
    <%@ include file="/WEB-INF/views/common/header.jsp" %>

    <div class="container" style="max-width: 800px; padding: 24px 16px;">
        <!-- 예약 상품 카드 반복 -->
        <c:forEach var="item" items="${cart}">
            <fmt:parseDate value="${item.desiredCheckInAt}" pattern="yyyy-MM-dd HH:mm:ss" var="checkInDate"/>
            <fmt:parseDate value="${item.desiredCheckOutAt}" pattern="yyyy-MM-dd HH:mm:ss" var="checkOutDate"/>
            <div class="card mb-4">
                <div class="card-content">
                    <div class="flex justify-between items-center mb-4">
                        <h2 class="font-bold">숙소</h2>
                    </div>
                    <h3 class="font-bold" style="font-size: 18px; margin-bottom: 8px;">${item.roomName}</h3>

                    <div style="display: grid; grid-template-columns: 1fr 1fr; gap: 16px; margin-bottom: 16px; font-size: 14px;">
                        <div>
                            <p class="text-gray">체크인</p>
                            <p class="font-bold">
                                <fmt:formatDate value="${checkInDate}" pattern="yyyy.MM.dd"/>
                            </p>
                            <p class="font-bold">15:00</p>
                        </div>
                        <div>
                            <p class="text-gray">체크아웃</p>
                            <p class="font-bold">
                                <fmt:formatDate value="${checkOutDate}" pattern="yyyy.MM.dd"/>
                            </p>
                            <p class="font-bold">10:00</p>
                        </div>
                    </div>

                    <p style="font-size: 14px; color: #6c757d; margin-bottom: 16px;">
                        숙박 기준 ${item.standardCapacity}명 / 최대 ${item.maximumCapacity}명
                    </p>

                    <div style="display: flex; justify-content: space-between; align-items: center; padding-top: 16px; border-top: 1px solid #e9ecef;">
                        <span style="font-size: 18px; font-weight: bold;">숙박 / 1박</span>
                        <span style="font-size: 20px; font-weight: bold; color: #2563eb;">
                            <fmt:formatNumber value="${item.price}" type="number" groupingUsed="true"/>원
                        </span>
                    </div>
                </div>
            </div>
        </c:forEach>

        <!-- 예약/결제 폼 -->
        <form action="${pageContext.request.contextPath}/reservation/complete" method="post" id="reservationForm">

            <!-- 방문 수단 & 예약자/이용자 정보 -->
            <div class="card mb-4">
                <div class="card-content">
                    <h2 class="font-bold mb-4">방문 수단 선택 *</h2>
                    <div class="radio-group" style="display:flex; gap:24px; margin-bottom:16px;">
                        <label class="radio-item"><input type="radio" name="transport" value="public" checked> 대중교통</label>
                        <label class="radio-item"><input type="radio" name="transport" value="car"> 자차</label>
                    </div>

                    <div class="form-group">
                        <label class="form-label">예약자 정보 *</label>
                        <div class="form-group" style="margin-bottom:8px;">
                            <label for="bookerName" class="form-label">성명 *</label>
                            <input type="text" id="bookerName" name="bookerName" class="form-control" placeholder="예약자의 성명을 입력해 주세요." required>
                        </div>
                        <div class="form-group">
                            <label for="bookerPhone" class="form-label">휴대폰 번호 *</label>
                            <input type="tel" id="bookerPhone" name="bookerPhone" class="form-control" placeholder="연락처" required>
                        </div>
                    </div>

                    <div class="form-group">
                        <label class="form-label">이용자 정보 *</label>
                        <div class="checkbox-item" style="margin-bottom:8px;">
                            <input type="checkbox" id="sameAsBooker" onchange="toggleUserInfo()">
                            <label for="sameAsBooker">예약자와 동일합니다</label>
                        </div>
                        <div id="userInfoSection">
                            <div class="form-group" style="margin-bottom:8px;">
                                <label for="userName" class="form-label">성명</label>
                                <input type="text" id="userName" name="userName" class="form-control" placeholder="이용자의 성명을 입력해 주세요.">
                            </div>
                            <div class="form-group">
                                <label for="userPhone" class="form-label">휴대폰 번호</label>
                                <input type="tel" id="userPhone" name="userPhone" class="form-control" placeholder="이용자의 휴대폰 번호를 입력해 주세요.">
                            </div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 결제 금액 -->
            <div class="card mb-4">
                <div class="card-content">
                    <h2 class="font-bold mb-4">결제 금액 (세금 및 봉사료 포함)</h2>
                    <div style="margin-bottom: 16px;">
                        <div style="display: flex; justify-content: space-between; margin-bottom: 8px;">
                            <span>상품 금액</span>
                            <span class="font-bold">
                                <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>원
                            </span>
                        </div>
                    </div>

                    <div style="border-top: 1px solid #e9ecef; padding-top: 16px;">
                        <div style="display: flex; justify-content: space-between; align-items: center; font-size: 18px; font-weight: bold;">
                            <span>총 결제 금액</span>
                            <span class="text-blue">
                                <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>원
                            </span>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 결제 수단 -->
            <div class="card mb-4">
                <div class="card-content">
                    <h2 class="font-bold mb-4">결제 수단</h2>
                    <div class="payment-grid">
                        <div class="payment-method" onclick="selectPayment('kakaopay')"><div class="payment-icon kakaopay"></div><span style="font-size:12px;">카카오페이</span></div>
                        <div class="payment-method" onclick="selectPayment('tosspay')"><div class="payment-icon tosspay"></div><span style="font-size:12px;">토스페이</span></div>
                        <div class="payment-method" onclick="selectPayment('naverpay')"><div class="payment-icon naverpay"></div><span style="font-size:12px;">네이버페이</span></div>
                        <div class="payment-method" onclick="selectPayment('kbpay')"><div class="payment-icon kbpay"></div><span style="font-size:12px;">KB Pay</span></div>
                        <div class="payment-method" onclick="selectPayment('card')"><div class="payment-icon card"></div><span style="font-size:12px;">카드</span></div>
                        <div class="payment-method" onclick="selectPayment('payco')"><div class="payment-icon payco"></div><span style="font-size:12px;">PAYCO</span></div>
                    </div>
                    <input type="hidden" id="selectedPayment" name="paymentMethod" required>

                    <!-- 약관 동의 -->
                    <div style="margin-top:24px;">
                        <div class="checkbox-item" style="margin-bottom:12px;">
                            <input type="checkbox" id="allAgree" onchange="toggleAllTerms()">
                            <label for="allAgree" class="font-bold">전체 동의 (선택포함)</label>
                        </div>
                        <div style="margin-left:24px;">
                            <div class="checkbox-item"><input type="checkbox" name="terms" class="term-checkbox" required> <label>[필수] 만 14세 이상 이용 동의</label></div>
                            <div class="checkbox-item"><input type="checkbox" name="terms" class="term-checkbox" required> <label>[필수] 이용약관</label></div>
                            <div class="checkbox-item"><input type="checkbox" name="terms" class="term-checkbox" required> <label>[필수] 취소 및 환불 규정</label></div>
                            <div class="checkbox-item"><input type="checkbox" name="terms" class="term-checkbox"> <label>[선택] 이벤트, 혜택 정보 수신 동의</label></div>
                        </div>
                    </div>
                </div>
            </div>

            <!-- 결제 버튼 -->
            <button type="submit" id="paymentButton" class="btn w-full" style="height: 48px; font-size: 18px; font-weight: bold; background: #2563eb; color: white;">
                <fmt:formatNumber value="${totalPrice}" type="number" groupingUsed="true"/>원 결제하기
            </button>
        </form>
    </div>

    <script>
        function toggleUserInfo() {
            const checkbox = document.getElementById('sameAsBooker');
            const userInfoSection = document.getElementById('userInfoSection');
            const bookerName = document.getElementById('bookerName').value;
            const bookerPhone = document.getElementById('bookerPhone').value;
            if (checkbox.checked) {
                document.getElementById('userName').value = bookerName;
                document.getElementById('userPhone').value = bookerPhone;
                userInfoSection.style.display = 'none';
            } else {
                userInfoSection.style.display = 'block';
            }
            validateForm();
        }

        function selectPayment(method) {
            document.querySelectorAll('.payment-method').forEach(el => el.classList.remove('selected'));
            event.currentTarget.classList.add('selected');
            document.getElementById('selectedPayment').value = method;
            validateForm();
        }

        function toggleAllTerms() {
            const allAgree = document.getElementById('allAgree');
            document.querySelectorAll('.term-checkbox').forEach(cb => cb.checked = allAgree.checked);
            validateForm();
        }

        function validateForm() {
            const bookerName = document.getElementById('bookerName').value.trim();
            const bookerPhone = document.getElementById('bookerPhone').value.trim();
            const selectedPayment = document.getElementById('selectedPayment').value;
            const requiredTerms = document.querySelectorAll('.term-checkbox[required]');
            const paymentButton = document.getElementById('paymentButton');

            let userInfoValid = true;
            if (!document.getElementById('sameAsBooker').checked) {
                const userName = document.getElementById('userName').value.trim();
                const userPhone = document.getElementById('userPhone').value.trim();
                userInfoValid = userName !== '' && userPhone !== '';
            }

            let allTermsChecked = true;
            requiredTerms.forEach(cb => { if (!cb.checked) allTermsChecked = false; });

            if (bookerName && bookerPhone && userInfoValid && selectedPayment && allTermsChecked) {
                paymentButton.disabled = false;
                paymentButton.style.background = '#2563eb';
                paymentButton.style.color = 'white';
            } else {
                paymentButton.disabled = true;
                paymentButton.style.background = '#e9ecef';
                paymentButton.style.color = '#6c757d';
            }
        }

        document.addEventListener('DOMContentLoaded', () => {
            ['bookerName','bookerPhone','userName','userPhone'].forEach(id => {
                const el = document.getElementById(id);
                if (el) el.addEventListener('input', validateForm);
            });
            document.querySelectorAll('.term-checkbox').forEach(cb => cb.addEventListener('change', validateForm));
            validateForm();
        });
    </script>
</body>
</html> 