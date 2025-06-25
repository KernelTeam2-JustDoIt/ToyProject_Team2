<%-- /WEB-INF/views/myPage.jsp --%>
<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %> <%-- 날짜 포맷을 위해 추가 --%>

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
            <h3><c:out value="${sessionScope.loginCustomer.customerName}" default="방문자" />님</h3> <%-- CUSTOMER_NAME --%>
            <p><c:out value="${sessionScope.loginCustomer.customerLoginId}" default="로그인ID" /></p> <%-- CUSTOMER_LOGIN_ID --%>
        </div>
        <nav class="my-page-nav">
            <ul>
                <li><a href="${pageContext.request.contextPath}/customer/info" class="nav-item active">내 정보</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/reservation" class="nav-item">예약 내역</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/reviews" class="nav-item">리뷰 관리</a></li>
                <li><a href="${pageContext.request.contextPath}/customer/settings" class="nav-item">회원 정보 수정</a></li>
                <li><a href="${pageContext.request.contextPath}/logout" class="nav-item logout-link">로그아웃</a></li>
            </ul>
        </nav>
    </aside>

    <main class="my-page-content">
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

            <button class="btn primary-btn">정보 수정</button>
        </div>
    </main>
</div>

<%-- 푸터 포함 --%>
<jsp:include page="/WEB-INF/views/common/footer.jsp" flush="false" />
</body>
</html>