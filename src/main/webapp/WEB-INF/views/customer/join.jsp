<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>회원가입</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login_style.css">
    <script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
    <style>
        .login-form-select {
            width: 100%;
            padding: 12px;
            margin-bottom: 16px;
            border: 1px solid #ccc;
            border-radius: 4px;
            font-size: 14px;
        }

        .button-group {
            display: flex;
            gap: 10px;
            margin-bottom: 16px;
        }

        .form-group {
            margin-bottom: 16px;
            display: flex;
            flex-direction: column;
        }

        .checkbox-group {
            display: flex;
            align-items: center;
            gap: 10px;
            font-size: 14px;
        }
    </style>
</head>
<body>

<header>
    <div class="logo">YANUPJA</div>
    <div class="header-right">
        <div class="auth-links">
            <a href="/customer/login">로그인</a>
            <a href="/customer">회원가입</a>
        </div>
    </div>
</header>

<div class="login-container">
    <h2>회원가입</h2>

    <c:if test="${not empty error}">
        <div class="error-message" style="color: red;">${error}</div>
    </c:if>

    <form action="/customer/join" method="post" class="login-form" onsubmit="return validateForm()">
        <div class="form-group">
            <input type="text" id="customerName" name="customerName" placeholder="이름" required>
        </div>

        <div class="form-group">
            <input type="text" id="customerTel" name="customerTel" placeholder="전화번호" required>
        </div>

        <div class="form-group">
            <input type="email" id="customerEmail" name="customerEmail" placeholder="이메일" required onblur="checkEmailDuplicate()">
            <div id="emailCheckResult" style="font-size: 0.9em;"></div>
        </div>

        <div class="form-group">
            <input type="text" id="emailVerificationCode" placeholder="인증코드 입력">
        </div>

        <div class="button-group">
            <button type="button" class="social-btn" onclick="sendVerificationCode()">인증코드 전송</button>
            <button type="button" class="social-btn" onclick="verifyCode()">인증 확인</button>
        </div>

        <div id="verificationResult" style="margin-bottom: 10px; font-size: 0.9em;"></div>

        <div class="form-group">
            <input type="text" id="customerLoginId" name="customerLoginId" placeholder="아이디" required onblur="checkIdDuplicate()">
            <div id="idCheckResult" style="font-size: 0.9em;"></div>
        </div>

        <div class="form-group">
            <input type="password" id="customerPassword" name="customerPassword" placeholder="비밀번호" required>
        </div>

        <div class="form-group">
            <input type="number" id="customerAge" name="customerAge" placeholder="나이">
        </div>

        <div class="form-group">
            <input type="text" id="customerJob" name="customerJob" placeholder="직업">
        </div>

        <div class="form-group">
            <select id="customerGender" name="customerGender" class="login-form-select" required>
                <option value="">성별 선택</option>
                <option value="M">남성</option>
                <option value="F">여성</option>
            </select>
        </div>

        <div class="form-group horizontal-group">
            <label for="isMarketingUseAgreed">마케팅 수신 동의</label>
            <input type="checkbox" name="isMarketingUseAgreed" value="1" id="isMarketingUseAgreed"/>
            <input type="hidden" name="isMarketingUseAgreed" value="0" />
        </div>


        <input type="hidden" name="gradeId" value="1">
        <input type="hidden" name="joinedAt" value="<%= new java.sql.Timestamp(System.currentTimeMillis()) %>">
        <input type="hidden" name="gradeExpireDate" value="<%= new java.sql.Timestamp(System.currentTimeMillis() + 1000L*60*60*24*365) %>">

        <button type="submit">가입하기</button>
    </form>

    <div class="login-links">
        <a href="/customer/login">로그인</a>
        <span>|</span>
        <a href="/customer/findPassword">비밀번호 변경 및 잠금계정 해제</a>
    </div>
</div>

<footer>
    &copy; 2025 YANUPJA. All rights reserved.
</footer>

<script>
    function checkIdDuplicate() {
        const loginId = $('#customerLoginId').val();
        if (!loginId) return;

        $.ajax({
            url: '/customer/check-id',
            type: 'GET',
            data: { customerLoginId: loginId },
            success: function(isDuplicate) {
                $('#idCheckResult').text(
                    isDuplicate === "true"
                        ? '이미 사용 중인 아이디입니다.'
                        : '사용 가능한 아이디입니다.'
                ).css('color', isDuplicate === "true" ? 'red' : 'green');
            }
        });
    }

    function checkEmailDuplicate() {
        const email = $('#customerEmail').val();
        if (!email) return;

        $.ajax({
            url: '/customer/check-email',
            type: 'GET',
            data: { customerEmail: email },
            success: function(result) {
                const messages = {
                    true: '이미 사용 중인 이메일입니다.',
                    invalid: '이메일을 입력하세요.',
                    default: '사용 가능한 이메일입니다.'
                };
                const colors = {
                    true: 'red',
                    invalid: 'gray',
                    default: 'green'
                };
                $('#emailCheckResult').text(messages[result] || messages.default)
                    .css('color', colors[result] || colors.default);
            }
        });
    }

    function sendVerificationCode() {
        const email = $('#customerEmail').val();
        if (!email) {
            alert("이메일을 먼저 입력하세요.");
            return;
        }

        $.post('/customer/sendEmailVerification', { customerEmail: email }, function(response) {
            alert(response === 'success' ? "인증코드가 이메일로 전송되었습니다." : "인증코드 전송 실패");
        });
    }

    function verifyCode() {
        const inputCode = $('#emailVerificationCode').val();
        if (!inputCode) {
            alert("인증코드를 입력하세요.");
            return;
        }

        $.post('/customer/verifyEmailCode', { inputCode: inputCode }, function(result) {
            if (result === 'success') {
                $('#verificationResult').text("✅ 이메일 인증 성공").css('color', 'green');
                sessionStorage.setItem("emailVerified", "true");
            } else {
                $('#verificationResult').text("❌ 인증코드가 올바르지 않습니다").css('color', 'red');
                sessionStorage.setItem("emailVerified", "false");
            }
        });
    }

    function validateForm() {
        const name = $('#customerName').val().trim();
        const id = $('#customerLoginId').val().trim();
        const email = $('#customerEmail').val().trim();
        const tel = $('#customerTel').val().trim();
        const pwd = $('#customerPassword').val();
        const age = parseInt($('#customerAge').val(), 10);
        const job = $('#customerJob').val();
        const gender = $('#customerGender').val();
        const emailVerified = sessionStorage.getItem("emailVerified");

        const emailRegex = /^[^\s@]+@[^\s@]+\.[^\s@]+$/;
        const phoneRegex = /^01[0-9]{8,9}$/;
        const passwordRegex = /^.{8,}$/;

        if (!name) return alert("이름을 입력하세요.") || false;
        if (!id) return alert("아이디를 입력하세요.") || false;
        if (!email || !emailRegex.test(email)) return alert("유효한 이메일을 입력하세요.") || false;
        if (emailVerified !== "true") return alert("이메일 인증을 완료해주세요.") || false;
        if (!tel || !phoneRegex.test(tel)) return alert("전화번호 형식이 올바르지 않습니다.") || false;
        if (!pwd || !passwordRegex.test(pwd)) return alert("비밀번호는 8자 이상이어야 합니다.") || false;
        if (isNaN(age) || age <= 0) return alert("나이를 올바르게 입력하세요.") || false;
        if (!gender) return alert("성별을 선택하세요.") || false;
        if (!job) return alert("직업을 입력하세요.") || false;

        return true;
    }
</script>

</body>
</html>