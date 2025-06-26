<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>로그인</title>
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/login_style.css">
    <link rel="stylesheet" type="text/css" href="${pageContext.request.contextPath}/resources/css/header.css">
</head>
<body>

<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/" style="text-decoration: none; color: inherit;">
            야눕자
        </a>
    </div>


    <div class="header-right">
        <%-- 로그인되지 않은 경우 (로그인/회원가입 메뉴 표시) --%>
        <%--TODO 세션에 로그인 유저인지 어떻게 확인하는지, 변수명 맞추기--%>
        <c:if test="${empty sessionScope.loginCustomer}">
            <div class="auth-links">
                <a href="${pageContext.request.contextPath}/customer/login" class="icon-link">
                    <img src="${pageContext.request.contextPath}/resources/image/login_image.jpg" alt="로그인" />
                    <span>로그인</span>
                </a>
                <a href="${pageContext.request.contextPath}/customer" class="icon-link">
                    <img src="${pageContext.request.contextPath}/resources/image/signup_image.png" alt="회원가입" />
                    <span>회원가입</span>
                </a>
            </div>
        </c:if>

        <div class="icon-links">
            <%-- 로그인된 경우 (마이 페이지 메뉴 표시) --%>
            <%--TODO 세션에 로그인 유저인지 어떻게 확인하는지, 변수명 맞추기--%>
            <c:if test="${not empty sessionScope.loginCustomer}">
                <a href="${pageContext.request.contextPath}/myPage" class="icon-link">
                    <img src="https://cdn-icons-png.flaticon.com/512/747/747376.png" alt="마이" />
                    <span>마이페이지</span> <%-- "마이" 대신 "마이페이지"로 변경 --%>
                </a>
            </c:if>

            <a href="${pageContext.request.contextPath}/cart/list" class="icon-link">
                <img src="https://cdn-icons-png.flaticon.com/512/263/263142.png" alt="장바구니" />
                <span>장바구니</span>
            </a>
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