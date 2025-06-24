<%@ page contentType="text/html;charset=UTF-8" %>
<%-- JSTL (JSP Standard Tag Library) 사용을 위한 태그 라이브러리 선언 --%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/" style="text-decoration: none; color: inherit;">
            야눕자
        </a>
    </div>

    <div class="search-bar">
        <input type="text" placeholder="신나는 토요일 불타는 이 밤" />
    </div>

    <div class="header-right">
        <%-- 로그인되지 않은 경우 (로그인/회원가입 메뉴 표시) --%>
        <%--TODO 세션에 로그인 유저인지 어떻게 확인하는지, 변수명 맞추기--%>
        <c:if test="${empty sessionScope.loginUser}">
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
        </c:if>

        <div class="icon-links">
            <%-- 로그인된 경우 (마이 페이지 메뉴 표시) --%>
                <%--TODO 세션에 로그인 유저인지 어떻게 확인하는지, 변수명 맞추기--%>
                <c:if test="${not empty sessionScope.loginUser}">
                <a href="${pageContext.request.contextPath}/myPage" class="icon-link">
                    <img src="https://cdn-icons-png.flaticon.com/512/747/747376.png" alt="마이" />
                    <span>마이페이지</span> <%-- "마이" 대신 "마이페이지"로 변경 --%>
                </a>
            </c:if>

            <%--찜은 구현 안함--%>
            <%--<a href="#" class="icon-link">--%>
            <%--        <img src="https://cdn-icons-png.flaticon.com/512/535/535234.png" alt="찜" />--%>
            <%--    <span>찜</span>--%>
            <%--</a>--%>
            <a href="${pageContext.request.contextPath}/cart/list" class="icon-link">
                <img src="https://cdn-icons-png.flaticon.com/512/263/263142.png" alt="장바구니" />
                <span>장바구니</span>
            </a>
        </div>
    </div>
</header>