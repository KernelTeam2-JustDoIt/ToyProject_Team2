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
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/myPage.css"> <%-- CSS 파일 링크 유지 --%>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script> <%-- jQuery 추가 --%>
    <%-- 이 위치에 있던 <style> 태그와 내용이 myPage.css로 옮겨졌습니다. --%>
</head>
<body>
<%-- 헤더 포함 --%>
<jsp:include page="/WEB-INF/views/common/header.jsp" flush="false" />

<%-- 예약 내역 섹션은 이미 이전 요청에서 제거되었습니다. --%>

<div class="my-page-container section">
    <aside class="sidebar">
        <div class="user-info-summary">
            <img src="https://via.placeholder.com/80/3498DB/FFFFFF?text=User" alt="프로필 사진" class="profile-pic">
            <h3><c:out value="${sessionScope.loginCustomer.customerName}" default="방문자" />님</h3>
            <p><c:out value="${sessionScope.loginCustomer.customerLoginId}" default="로그인ID" /></p>
        </div>
        <nav class="my-page-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/customer/info" class="nav-item active" data-tab="info">내 정보</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/settings" class="nav-item" data-tab="settings">회원 정보 수정</a></li>
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

        <section id="settings" class="tab-content">
            <h2>회원 정보 수정</h2>
            <div class="content-box">
                <form action="${pageContext.request.contextPath}/customer/update" method="post" id="updateForm">
                    <div class="form-group">
                        <label for="currentPassword">현재 비밀번호 입력 <span class="required">*</span></label>
                        <input type="password" id="currentPassword" name="currentPassword" required class="form-control">
                        <span class="error-message" id="passwordError"></span>
                    </div>

                    <div class="form-group">
                        <p>현재 이름: <strong><c:out value="${sessionScope.loginCustomer.customerName}" /></strong></p>
                        <label for="customerName">새 이름</label>
                        <input type="text" id="customerName" name="customerName" value="<c:out value="${sessionScope.loginCustomer.customerName}" />" placeholder="새 이름을 입력하세요" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 연락처: <strong><c:out value="${sessionScope.loginCustomer.customerTel}" /></strong></p>
                        <label for="customerTel">새 연락처</label>
                        <input type="tel" id="customerTel" name="customerTel" value="<c:out value="${sessionScope.loginCustomer.customerTel}" />" placeholder="새 연락처를 입력하세요 (예: 010-1234-5678)" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 이메일: <strong><c:out value="${sessionScope.loginCustomer.customerEmail}" /></strong></p>
                        <label for="customerEmail">새 이메일</label>
                        <input type="email" id="customerEmail" name="customerEmail"
                               value="<c:out value="${sessionScope.loginCustomer.customerEmail}" />"
                               placeholder="새 이메일을 입력하세요" class="form-control"
                               onblur="checkEmailDuplicate();">
                        <span class="error-message" id="emailCheckResult" style="font-size: 0.9em; margin-top: 5px; color: gray;">새로운 이메일을 입력하면 인증이 필요합니다.</span>
                    </div>

                    <div class="form-group">
                        <input type="text" id="emailVerificationCode" placeholder="인증코드 입력" class="form-control">
                    </div>

                    <div class="button-group">
                        <button type="button" class="btn secondary-btn" onclick="sendVerificationCode()">인증코드 전송</button>
                        <button type="button" class="btn primary-btn" onclick="verifyCode()">인증 확인</button>
                    </div>

                    <div id="verificationResult" style="margin-bottom: 16px; font-size: 0.9em;"></div>

                    <div class="form-group">
                        <p>현재 아이디: <strong><c:out value="${sessionScope.loginCustomer.customerLoginId}" /></strong></p>
                        <label for="customerLoginId">새 아이디</label>
                        <input type="text" id="customerLoginId" name="customerLoginId" value="<c:out value="${sessionScope.loginCustomer.customerLoginId}" />" placeholder="새 아이디를 입력하세요" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 나이: <strong><c:out value="${sessionScope.loginCustomer.customerAge}" /></strong></p>
                        <label for="customerAge">새 나이</label>
                        <input type="number" id="customerAge" name="customerAge" value="<c:out value="${sessionScope.loginCustomer.customerAge}" />" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 직업: <strong><c:out value="${sessionScope.loginCustomer.customerJob}" /></strong></p>
                        <label for="customerJob">새 직업</label>
                        <input type="text" id="customerJob" name="customerJob" value="<c:out value="${sessionScope.loginCustomer.customerJob}" />" placeholder="새 직업을 입력하세요" class="form-control">
                    </div>

                    <div class="form-group">
                        <p>현재 성별: <strong><c:out value="${sessionScope.loginCustomer.customerGender eq 'M' ? '남성' : (sessionScope.loginCustomer.customerGender eq 'F' ? '여성' : '미정')}" /></strong></p>
                        <label for="customerGender">새 성별</label>
                        <select id="customerGender" name="customerGender" class="login-form-select">
                            <option value="">성별 선택</option>
                            <option value="M" <c:if test="${sessionScope.loginCustomer.customerGender eq 'M'}">selected</c:if>>남성</option>
                            <option value="F" <c:if test="${sessionScope.loginCustomer.customerGender eq 'F'}">selected</c:if>>여성</option>
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
    // 이메일 중복 검사 함수
    function checkEmailDuplicate() {
        const email = $('#customerEmail').val();
        // 현재 로그인된 사용자의 이메일을 JSP에서 가져와 사용
        const originalEmail = '<c:out value="${sessionScope.loginCustomer.customerEmail}" />';

        if (!email) { // 이메일 필드가 비어있으면
            $('#emailCheckResult').text('이메일을 입력하거나 빈칸으로 두세요.').css('color', 'gray');
            return;
        }

        // 입력된 이메일이 기존 이메일과 같으면, 중복 검사 대신 'current' 상태로 처리
        if (email === originalEmail) {
            $('#emailCheckResult').text('현재 사용 중인 이메일입니다.').css('color', 'blue');
            sessionStorage.setItem("emailVerified", "true"); // 기존 이메일은 인증된 것으로 간주
            return;
        }

        $.ajax({
            url: '${pageContext.request.contextPath}/customer/check-email',
            type: 'GET',
            data: { customerEmail: email },
            success: function(result) {
                const messages = {
                    true: '이미 사용 중인 이메일입니다.', // 중복 (다른 사용자)
                    invalid: '이메일을 입력하세요.',       // 유효하지 않은 입력 (여기서는 이메일 필드가 비어있을 때 사용)
                    default: '사용 가능한 이메일입니다.'     // 사용 가능
                };
                const colors = {
                    true: 'red',
                    invalid: 'gray',
                    default: 'green'
                };
                $('#emailCheckResult').text(messages[result] || messages.default)
                    .css('color', colors[result] || colors.default);

                // 이메일이 사용 가능하면 인증 상태 초기화 (다시 인증 받아야 함)
                if (result === 'false') {
                    sessionStorage.removeItem("emailVerified");
                }
            },
            error: function() {
                $('#emailCheckResult').text('이메일 검사 중 오류가 발생했습니다.').css('color', 'red');
            }
        });
    }

    // 인증코드 전송 함수
    function sendVerificationCode() {
        const email = $('#customerEmail').val();
        const originalEmail = '<c:out value="${sessionScope.loginCustomer.customerEmail}" />';

        // 이메일이 입력되지 않았거나, 유효하지 않은 경우
        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        if (!email || !emailRegex.test(email)) {
            alert("유효한 이메일을 입력해야 인증코드를 전송할 수 있습니다.");
            return;
        }

        // 기존 이메일과 동일하면 인증코드 전송 불필요
        if (email === originalEmail) {
            alert("현재 사용 중인 이메일은 별도의 인증이 필요하지 않습니다. 다른 이메일로 변경 시에만 인증코드를 전송해주세요.");
            return;
        }

        $.post('${pageContext.request.contextPath}/customer/sendEmailVerification', { customerEmail: email }, function(response) {
            if (response === 'success') {
                alert("인증코드가 이메일로 전송되었습니다.");
                $('#verificationResult').text("인증코드를 입력 후 '인증 확인' 버튼을 눌러주세요.").css('color', 'blue');
            } else {
                alert("인증코드 전송 실패. 이메일 주소를 확인해주세요.");
                $('#verificationResult').text("인증코드 전송 실패").css('color', 'red');
            }
        }).fail(function() {
            alert("서버 통신 중 오류가 발생했습니다.");
            $('#verificationResult').text("오류 발생").css('color', 'red');
        });
    }

    // 인증 확인 함수
    function verifyCode() {
        const inputCode = $('#emailVerificationCode').val();
        const email = $('#customerEmail').val(); // 인증 요청했던 이메일
        const originalEmail = '<c:out value="${sessionScope.loginCustomer.customerEmail}" />';

        if (!inputCode) {
            alert("인증코드를 입력하세요.");
            return;
        }

        // 기존 이메일과 동일하면 인증 확인 불필요
        if (email === originalEmail) {
            alert("현재 사용 중인 이메일은 별도의 인증이 필요하지 않습니다.");
            $('#verificationResult').text("").css('color', ''); // 메시지 초기화
            sessionStorage.setItem("emailVerified", "true"); // 기존 이메일은 인증된 것으로 간주
            return;
        }

        $.post('${pageContext.request.contextPath}/customer/verifyEmailCode', { inputCode: inputCode, customerEmail: email }, function(result) {
            if (result === 'success') {
                $('#verificationResult').text("✅ 이메일 인증 성공").css('color', 'green');
                sessionStorage.setItem("emailVerified", "true"); // 세션 스토리지에 인증 완료 상태 저장
            } else {
                $('#verificationResult').text("❌ 인증코드가 올바르지 않거나 만료되었습니다.").css('color', 'red');
                sessionStorage.setItem("emailVerified", "false"); // 인증 실패
            }
        }).fail(function() {
            alert("서버 통신 중 오류가 발생했습니다.");
            $('#verificationResult').text("오류 발생").css('color', 'red');
        });
    }

    // 회원 정보 수정 폼 유효성 검사 함수
    function validateForm() {
        const currentPassword = $('#currentPassword').val().trim();
        const originalEmail = '<c:out value="${sessionScope.loginCustomer.customerEmail}" />';
        const newEmail = $('#customerEmail').val().trim();
        const emailVerified = sessionStorage.getItem("emailVerified");

        // 1. 현재 비밀번호는 필수 입력
        if (currentPassword === '') {
            $('#passwordError').text('현재 비밀번호는 필수 입력입니다.').css('color', 'red');
            return false;
        } else {
            $('#passwordError').text(''); // 에러 메시지 초기화
        }

        // 2. 이메일이 변경되었을 경우에만 유효성 검사 및 인증 요구
        if (newEmail !== originalEmail) {
            const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
            if (!newEmail || !emailRegex.test(newEmail)) {
                alert("유효한 새 이메일을 입력해야 합니다.");
                return false;
            }
            if (emailVerified !== "true") {
                alert("이메일 주소를 변경하려면 이메일 인증을 완료해주세요.");
                return false;
            }
        } else {
            // 이메일이 변경되지 않았다면, 인증 상태를 'true'로 간주
            sessionStorage.setItem("emailVerified", "true");
        }

        // 모든 유효성 검사를 통과했을 경우 최종 확인
        if (!confirm('정말로 회원 정보를 수정하시겠습니까?')) {
            return false;
        }

        return true;
    }

    document.addEventListener('DOMContentLoaded', function() {
        // 탭 전환 기능
        const navItems = document.querySelectorAll('.my-page-nav .nav-item');
        const tabContents = document.querySelectorAll('.tab-content');

        // URL 해시 값을 확인하여 초기 활성화 탭 설정
        const currentHash = window.location.hash;
        // 'reservation' 탭이 제거되었으므로, 기본값은 'info' 또는 'settings'로 유지합니다.
        let initialTabId = currentHash ? currentHash.substring(1) : 'info';
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
                if (!validateForm()) {
                    e.preventDefault(); // 유효성 검사 실패 시 폼 전송 막기
                }
            });

            // 페이지 로드 시 이메일 필드의 초기 상태를 설정하고 메시지 표시
            const customerEmailInput = document.getElementById('customerEmail');
            const originalEmail = '<c:out value="${sessionScope.loginCustomer.customerEmail}" />';
            if (customerEmailInput) {
                // 입력된 이메일이 기존 이메일과 같으면, 인증된 것으로 간주
                if (customerEmailInput.value === originalEmail) {
                    sessionStorage.setItem("emailVerified", "true");
                    $('#emailCheckResult').text('현재 사용 중인 이메일입니다.').css('color', 'blue');
                } else {
                    // 이메일이 다르다면 인증이 필요할 수 있으므로 인증 상태를 해제
                    sessionStorage.removeItem("emailVerified");
                    $('#emailCheckResult').text('새로운 이메일을 입력하면 인증이 필요합니다.').css('color', 'gray');
                }
            }
        }
    });
</script>
</body>
</html>