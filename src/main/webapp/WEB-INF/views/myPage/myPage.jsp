<%-- /WEB-INF/views/myPage.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>마이페이지 - 야눕자</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
</head>
<body>
<%-- 헤더 포함 --%>
<jsp:include page="/WEB-INF/views/common/header.jsp" flush="false" />

<div class="my-page-container section">
    <aside class="sidebar">
        <div class="user-info-summary">
            <img src="https://via.placeholder.com/80/3498DB/FFFFFF?text=User" alt="프로필 사진" class="profile-pic">
            <h3><c:out value="${sessionScope.loginCustomer.customerName}" default="방문자" />님</h3>
            <p><c:out value="${sessionScope.loginCustomer.customerLoginId}" default="로그인ID" /></p>
        </div>
        <nav class="my-page-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/customer/info" class="nav-item active">내 정보</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/reservation" class="nav-item">예약 내역</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/reviews" class="nav-item">리뷰 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/settings" class="nav-item">회원 정보 수정</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/logout" class="nav-item logout-link">로그아웃</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/withdraw" class="nav-item withdraw-link" onclick="return confirm('정말로 회원 탈퇴를 하시겠습니까? 모든 정보가 삭제되며 되돌릴 수 없습니다.');">회원 탈퇴</a></li>
            </ul>
        </nav>
    </aside>

    <main class="my-page-content">
        <section id="info" class="tab-content active">
            <h2>내 정보</h2>
            <div class="content-box">
                <p><strong>고객 아이디:</strong> <c:out value="${sessionScope.loginCustomer.customerLoginId}" /></p>
                <p><strong>고객명:</strong> <c:out value="${sessionScope.loginCustomer.customerName}" /></p>
                <p><strong>이메일:</strong> <c:out value="${sessionScope.loginCustomer.customerEmail}" /></p>
                <p><strong>연락처:</strong> <c:out value="${sessionScope.loginCustomer.customerTel}" /></p>
                <p><strong>성별:</strong> <c:out value="${sessionScope.loginCustomer.customerGender eq 'M' ? '남성' : (sessionScope.loginCustomer.customerGender eq 'F' ? '여성' : '미정')}" /></p>
                <p><strong>나이:</strong> <c:out value="${sessionScope.loginCustomer.customerAge}" />세</p>
                <p><strong>직업:</strong> <c:out value="${sessionScope.loginCustomer.customerJob}" /></p>
                <p><strong>포인트:</strong> <c:out value="${sessionScope.loginCustomer.point}" />점</p>
                <p><strong>회원가입일:</strong> <fmt:formatDate value="${sessionScope.loginCustomer.joinedAt}" pattern="yyyy년 MM월 dd일 HH시 mm분" /></p>
                <p><strong>등급:</strong> <c:out value="${sessionScope.loginCustomer.gradeId}" /></p>
                <p><strong>등급 만료일:</strong> <fmt:formatDate value="${sessionScope.loginCustomer.gradeExpireDate}" pattern="yyyy년 MM월 dd일" /></p>
                <p><strong>마케팅 활용 동의:</strong> <c:out value="${sessionScope.loginCustomer.isMarketingUseAgreed == 1 ? '동의' : '비동의'}" /></p>
            </div>
        </section>

        <section id="reservation" class="tab-content">
            <h2>예약 내역</h2>
            <div class="content-box reservation-list-container">
                <c:choose>
                    <c:when test="${not empty customerReservations}">
                        <div class="reservation-grid">
                            <c:forEach var="reservation" items="${customerReservations}">
                                <div class="reservation-card">
                                    <div class="card-header">
                                        <h3><c:out value="${reservation.accommodationName}" /></h3>
                                        <span class="reservation-status ${reservation.status == '완료' ? 'status-completed' : (reservation.status == '예정' ? 'status-upcoming' : 'status-cancelled')}">
                                            <c:out value="${reservation.status}" />
                                        </span>
                                    </div>
                                    <div class="card-body">
                                        <p><strong>객실:</strong> <c:out value="${reservation.roomType}" /></p>
                                        <p><strong>체크인:</strong> <fmt:formatDate value="${reservation.checkInDate}" pattern="yyyy.MM.dd" /></p>
                                        <p><strong>체크아웃:</strong> <fmt:formatDate value="${reservation.checkOutDate}" pattern="yyyy.MM.dd" /></p>
                                        <p><strong>결제 금액:</strong> <fmt:formatNumber value="${reservation.paymentAmount}" type="currency" currencySymbol="₩" /></p>
                                        <p><strong>예약 번호:</strong> <c:out value="${reservation.reservationId}" /></p>
                                        <p><strong>예약일:</strong> <fmt:formatDate value="${reservation.reservedAt}" pattern="yyyy.MM.dd HH:mm" /></p>
                                    </div>
                                    <div class="card-footer">
                                        <button class="btn primary-btn btn-small">상세보기</button>
                                        <c:if test="${reservation.status == '예정'}">
                                            <button class="btn secondary-btn btn-small">예약 취소</button>
                                        </c:if>
                                    </div>
                                </div>
                            </c:forEach>
                        </div>
                    </c:when>
                    <c:otherwise>
                        <p class="no-reservations">아직 예약 내역이 없습니다.</p>
                    </c:otherwise>
                </c:choose>
            </div>
        </section>

        <section id="settings" class="tab-content">
            <h2>회원 정보 수정</h2>
            <div class="content-box">
                <%-- 비밀번호 재확인 폼 (선택 사항이지만 보안 강화를 위해 권장) --%>
                <form action="${pageContext.request.contextPath}/customer/update" method="post" id="updateForm">
                    <div class="form-group">
                        <label for="currentPassword">현재 비밀번호 입력 <span class="required">*</span></label>
                        <input type="password" id="currentPassword" name="currentPassword" required class="form-control">
                        <span class="error-message" id="passwordError"></span>
                    </div>

                    <div class="form-group">
                        <p>현재 이름: <strong><c:out value="${sessionScope.loginCustomer.customerName}" /></strong></p>
                        <label for="customerName">새 이름</label>
                        <input type="text" id="customerName" name="customerName" value="" placeholder="새 이름을 입력하세요" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 연락처: <strong><c:out value="${sessionScope.loginCustomer.customerTel}" /></strong></p>
                        <label for="customerTel">새 연락처</label>
                        <input type="tel" id="customerTel" name="customerTel" value="" placeholder="새 연락처를 입력하세요 (예: 010-1234-5678)" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 이메일: <strong><c:out value="${sessionScope.loginCustomer.customerEmail}" /></strong></p>
                        <label for="customerEmail">새 이메일</label>
                        <input type="email" id="customerEmail" name="customerEmail" value="" placeholder="새 이메일을 입력하세요" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 아이디: <strong><c:out value="${sessionScope.loginCustomer.customerLoginId}" /></strong></p>
                        <label for="customerId">새 아이디</label>
                        <input type="text" id="customerId" name="customerId" value="" placeholder="새 아이디를 입력하세요" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 나이: <strong><c:out value="${sessionScope.loginCustomer.customerAge}" /></strong></p>
                        <label for="customerAge">새 나이</label>
                        <input type="number" id="customerAge" name="customerAge" value="" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 직업: <strong><c:out value="${sessionScope.loginCustomer.customerJob}" /></strong></p>
                        <label for="customerJob">새 직업</label>
                        <input type="text" id="customerJob" name="customerJob" value="" placeholder="새 아이디를 입력하세요" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 성별: <strong><c:out value="${sessionScope.loginCustomer.customerAge}" /></strong></p>
                        <label for="customerAge">새 나이</label>
                        <input type="number" id="customerAge" name="customerAge" value="" class="form-control">
                    </div>

                    <div class="form-group">
                        <p><strong>성별:</strong> <c:out value="${sessionScope.loginCustomer.customerGender eq 'M' ? '남성' : (sessionScope.loginCustomer.customerGender eq 'F' ? '여성' : '미정')}" /></p>
                        <label for="customerGender">새 성별</label>
                        <select id="customerGender" name="customerGender" class="login-form-select" required>
                            <option value="">성별 선택</option>
                            <option value="M">남성</option>
                            <option value="F">여성</option>
                        </select>
                    </div>

                    <div class="form-group">
                        <p>현재 마케팅 활용 동의: <strong><c:out value="${sessionScope.loginCustomer.isMarketingUseAgreed == 1 ? '동의' : '비동의'}" /></strong></p>
                        <label class="checkbox-label">
                            <input type="checkbox" id="isMarketingUseAgreed" name="isMarketingUseAgreed" value="1" <c:if test="${sessionScope.loginCustomer.isMarketingUseAgreed == 1}">checked</c:if>>
                            마케팅 정보 수신 동의
                        </label>
                    </div>

                    <button type="submit" class="btn primary-btn">정보 수정</button>
                </form>
            </div>
        </section>

    </main>
</div>

<%-- 푸터 포함 --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />

<script>
    document.addEventListener('DOMContentLoaded', function() {
        // 탭 전환 기능
        const navItems = document.querySelectorAll('.my-page-nav .nav-item');
        const tabContents = document.querySelectorAll('.tab-content');

        // URL 해시 값을 확인하여 초기 활성화 탭 설정
        const currentHash = window.location.hash;
        let initialTabId = currentHash ? currentHash.substring(1) : 'info'; // 기본은 'info'
        let initialNavLink = document.querySelector(`.my-page-nav .nav-item[data-tab="${initialTabId}"]`);

        // 유효하지 않은 해시인 경우 'info'로 재설정
        if (!initialNavLink) {
            initialTabId = 'info';
            initialNavLink = document.querySelector(`.my-page-nav .nav-item[data-tab="info"]`);
        }

        // 초기 탭 활성화 로직
        if (initialNavLink) {
            navItems.forEach(item => item.classList.remove('active'));
            tabContents.forEach(content => content.classList.remove('active'));

            initialNavLink.classList.add('active');
            document.getElementById(initialTabId).classList.add('active');
        }

        navItems.forEach(item => {
            item.addEventListener('click', function(e) {
                // 로그아웃, 회원탈퇴 링크는 제외
                if (this.classList.contains('logout-link') || this.classList.contains('withdraw-link')) {
                    return;
                }

                e.preventDefault(); // 기본 링크 동작 방지

                // 모든 탭 비활성화
                navItems.forEach(nav => nav.classList.remove('active'));
                tabContents.forEach(content => content.classList.remove('active'));

                // 클릭한 탭 활성화
                this.classList.add('active');

                // 해당 탭 내용 활성화
                const tabId = this.dataset.tab;
                document.getElementById(tabId).classList.add('active');

                // URL 해시 변경 (페이지 새로고침 시에도 탭 유지)
                history.pushState(null, '', `#${tabId}`);
            });
        });

        // 회원 정보 수정 폼 유효성 검사 (클라이언트 측)
        const updateForm = document.getElementById('updateForm');
        if (updateForm) {
            updateForm.addEventListener('submit', function(e) {
                const currentPassword = document.getElementById('currentPassword').value;
                const newPassword = document.getElementById('newPassword').value;
                const confirmPassword = document.getElementById('confirmPassword').value;
                const passwordError = document.getElementById('passwordError');

                passwordError.textContent = ''; // 에러 메시지 초기화

                if (currentPassword.trim() === '') {
                    passwordError.textContent = '현재 비밀번호는 필수 입력입니다.';
                    e.preventDefault(); // 폼 전송 막기
                    return;
                }

                // 새 비밀번호를 입력했을 경우에만 유효성 검사
                if (newPassword.trim() !== '') {
                    if (newPassword.length < 8 || !/[a-zA-Z]/.test(newPassword) || !/[0-9]/.test(newPassword) || !/[!@#$%^&*()]/.test(newPassword)) {
                        passwordError.textContent = '새 비밀번호는 8자 이상, 영문/숫자/특수문자를 포함해야 합니다.';
                        e.preventDefault();
                        return;
                    }
                    if (newPassword !== confirmPassword) {
                        passwordError.textContent = '새 비밀번호와 비밀번호 확인이 일치하지 않습니다.';
                        e.preventDefault();
                        return;
                    }
                }

                // 모든 유효성 검사를 통과했을 경우 최종 확인
                if (!confirm('정말로 회원 정보를 수정하시겠습니까?')) {
                    e.preventDefault();
                }
            });
        }
    });
</script>
</body>
</html>