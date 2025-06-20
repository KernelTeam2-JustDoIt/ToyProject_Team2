<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" type="text/css" href="/resources/css/login_style.css">
</head>
<body>

<header>
    <div class="logo">YANUPJA</div>
    <div class="header-right">
        <div class="auth-links">
            <a href="/customer/login">로그인</a>
            <a href="/customer/join">회원가입</a>
        </div>
    </div>
</header>

<div class="login-container">
    <h2>LOGIN PAGE</h2>
    <form action="/customer/login" method="post" class="login-form">
        <input type="text" name="customerLoginId" placeholder="아이디" required>
        <input type="password" name="customerPassword" placeholder="비밀번호" required>
        <button type="submit">로그인</button>
    </form>

    <div class="login-links">
        <a href="/customer/join">회원가입</a>
        <span>|</span>
        <a href="#">비밀번호 찾기</a>
    </div>

    <div class="social-login">
        <div class="social-btn">
            <img src="/resources/img/kakao-icon.png" alt="카카오"> 카카오 로그인
        </div>
        <div class="social-btn">
            <img src="/resources/img/naver-icon.png" alt="네이버"> 네이버 로그인
        </div>
    </div>
</div>

<footer>
    &copy; 2025 YANUPJA. All rights reserved.
</footer>

</body>
</html>

