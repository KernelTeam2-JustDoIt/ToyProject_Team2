<!-- /WEB-INF/views/common/header.jsp -->
<%@ page contentType="text/html;charset=UTF-8" %>

<header>
    <div class="logo">야눕자</div>

    <div class="search-bar">
        <input type="text" placeholder="신나는 토요일 불타는 이 밤" />
    </div>

    <div class="header-right">
        <div class="auth-links">
            <a href="#" class="icon-link">
                <img src="${pageContext.request.contextPath}/resources/image/login_image.jpg" alt="로그인" />
                <span>로그인</span>
            </a>
            <a href="#" class="icon-link">
                <img src="${pageContext.request.contextPath}/resources/image/signup_image.png" alt="회원가입" />
                <span>회원가입</span>
            </a>
        </div>

        <div class="icon-links">
            <a href="${pageContext.request.contextPath}/customer/info?customerId=${customerId}" class="icon-link">
                <img src="https://cdn-icons-png.flaticon.com/512/747/747376.png" alt="마이" />
                <span>마이</span>
            </a>
<%--            찜은 구현 안함--%>
<%--            <a href="#" class="icon-link">--%>
<%--                <img src="https://cdn-icons-png.flaticon.com/512/535/535234.png" alt="찜" />--%>
<%--                <span>찜</span>--%>
<%--            </a>--%>
            <a href="${pageContext.request.contextPath}/cart/list" class="icon-link">
                <img src="https://cdn-icons-png.flaticon.com/512/263/263142.png" alt="장바구니" />
                <span>장바구니</span>
            </a>
        </div>
    </div>
</header>