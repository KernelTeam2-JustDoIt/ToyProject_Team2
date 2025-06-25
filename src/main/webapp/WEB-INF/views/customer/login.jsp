<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login_style.css">
</head>
<body>

<header>
    <div class="logo">YANUPJA</div>
    <div class="header-right">
        <div class="auth-links">
            <a href="${pageContext.request.contextPath}/customer/login">로그인</a>
            <a href="${pageContext.request.contextPath}/customer/join">회원가입</a>
        </div>
    </div>
</header>

<div class="login-container">
    <h2>로그인</h2>
    <form action="${pageContext.request.contextPath}/customer/login" method="post" class="login-form">
        <!-- 오류 메시지 표시 영역 -->
        <c:if test="${not empty error}">
            <div class="error-message" style="color: red; margin-bottom: 10px;">
                    ${error}
            </div>
        </c:if>
        <input type="text" name="customerLoginId" placeholder="아이디" required>
        <input type="password" name="customerPassword" placeholder="비밀번호" required>
        <button type="submit">로그인</button>
    </form>

    <div class="login-links">
        <a href="${pageContext.request.contextPath}/customer">회원가입</a>
        <span>|</span>
        <a href="${pageContext.request.contextPath}/customer/findPassword">비밀번호 변경 및 잠금계정 해제</a>
    </div>
</div>
    <footer>
        &copy; 2025 YANUPJA. All rights reserved.
    </footer>

</body>
</html>