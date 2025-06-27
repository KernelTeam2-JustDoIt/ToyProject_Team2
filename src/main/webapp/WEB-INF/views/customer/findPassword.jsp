<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
    <title>비밀번호 변경 및 잠금계정 해제</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/findPassword.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">

    <script>
        let savedLoginId = "";

        //  인증코드 요청 - 아이디 & 이메일을 통해 인증코드를 이메일로 전송
        function sendVerificationCode() {
            const loginId = document.querySelector('input[name="customerLoginId"]').value;
            const email = document.querySelector('input[name="customerEmail"]').value;

            if (!loginId || !email) {
                alert("아이디와 이메일을 입력하세요.");
                return;
            }

            savedLoginId = loginId; // 인증 성공 시 이후 단계에서 아이디 전달용으로 사용

            fetch('${pageContext.request.contextPath}/customer/sendCode', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'
                },
                body: JSON.stringify({ customerLoginId: loginId, customerEmail: email })
            })
                .then(response => {
                    if (response.ok) {
                        alert("이메일로 인증코드가 전송되었습니다.");
                        document.getElementById('code-section').style.display = 'block'; // 인증 입력칸 표시
                    } else {
                        alert("회원 정보가 일치하지 않거나 오류가 발생했습니다.");
                    }
                });
        }

        //  인증코드 확인 - 이메일로 받은 코드가 맞는지 서버에 검증 요청
        function verifyCode() {
            const code = document.querySelector('input[name="verificationCode"]').value;

            fetch('${pageContext.request.contextPath}/customer/verifyCode', {
                method: 'POST',
                headers: { 'Content-Type': 'application/json' },
                body: JSON.stringify({ code: code })
            })
                .then(response => response.text())
                .then(result => {
                    if (result === 'success') {
                        alert("인증 성공! 비밀번호를 변경하세요.");
                        document.getElementById('customerLoginIdHidden').value = savedLoginId; // 숨겨진 필드에 아이디 세팅
                        document.getElementById('password-section').style.display = 'block'; // 비밀번호 변경폼 표시
                    } else {
                        alert("인증 코드가 올바르지 않습니다.");
                    }
                });
        }

        // 비밀번호 유효성 검사 함수 - 형식 및 일치 여부 확인
        function validatePasswordChangeForm() {
            const newPw = document.querySelector('input[name="newPassword"]').value;
            const confirmPw = document.querySelector('input[name="confirmPassword"]').value;

            // 영문 + 숫자 + 특수문자 포함, 최소 8자
            const pwRegex = /^(?=.*[A-Za-z])(?=.*\d)(?=.*[!@#$%^&*()_+{}\[\]:;<>,.?~\\/-])[A-Za-z\d!@#$%^&*()_+{}\[\]:;<>,.?~\\/-]{8,}$/;

            if (!pwRegex.test(newPw)) {
                alert("비밀번호는 영문과 숫자, 특수문자를 포함한 8자 이상이어야 합니다.");
                return false;
            }

            if (newPw !== confirmPw) {
                alert("비밀번호가 일치하지 않습니다.");
                return false;
            }

            return true; // 제출 허용
        }
    </script>
</head>
<body>

<%@ include file="../common/header.jsp" %>

<div class="find-container">
    <h2>비밀번호 변경 및 잠금계정 해제</h2>

    <!--  1단계: 아이디 & 이메일 입력 폼 -->
    <div class="find-form">
        <input type="text" name="customerLoginId" placeholder="아이디 입력" required>
        <input type="email" name="customerEmail" placeholder="가입한 이메일 주소 입력" required>
        <button type="button" onclick="sendVerificationCode()">인증코드 받기</button>
    </div>

    <!--  2단계: 인증코드 입력 폼 -->
    <div id="code-section" style="display: none; margin-top: 20px;">
        <input type="text" name="verificationCode" placeholder="인증코드 입력">
        <button type="button" onclick="verifyCode()">인증 확인</button>
    </div>

    <!-- 3단계: 비밀번호 변경 form -->
    <!--  유효성 검사 함수 validatePasswordChangeForm() 호출됨 -->
    <form action="${pageContext.request.contextPath}/customer/changePassword"
          method="post"
          id="password-section"
          style="display: none; margin-top: 20px;"
          onsubmit="return validatePasswordChangeForm()">

        <!-- 숨겨진 아이디 전달용 hidden 필드 -->
        <input type="hidden" name="customerLoginId" id="customerLoginIdHidden">

        <!-- 새 비밀번호 입력 -->
        <input type="password" name="newPassword" placeholder="새 비밀번호 입력" required>

        <!-- 새 비밀번호 확인 -->
        <input type="password" name="confirmPassword" placeholder="새 비밀번호 확인" required>

        <!-- 제출 버튼 -->
        <button type="submit">비밀번호 변경</button>
    </form>

    <!-- 로그인/회원가입 링크 -->
    <div class="find-links">
        <a href="${pageContext.request.contextPath}/customer/login">로그인</a>
        <span>|</span>
        <a href="${pageContext.request.contextPath}/customer">회원가입</a>
    </div>
</div>

<footer>
    &copy; 2025 YANUPJA. All rights reserved.
</footer>

</body>
</html>
