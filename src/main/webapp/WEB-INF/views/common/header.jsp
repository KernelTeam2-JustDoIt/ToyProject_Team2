<%-- header.jsp fragment: included in other JSPs. No page directive here to avoid duplicate contentType errors. --%>
<%@ page pageEncoding="UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<header>
    <div class="logo">
        <a href="${pageContext.request.contextPath}/" style="text-decoration: none; color: inherit;">
            YANUPJA
        </a>
    </div>

    <div class="search-bar">
        <input type="text" id=searchInput placeholder="신나는 토요일 불타는 이 밤" />
    </div>

    <div class="header-right">
        <%-- 로그인되지 않은 경우 (로그인/회원가입 메뉴 표시) --%>
        <c:if test="${empty sessionScope.loginCustomer}">
            <div class="auth-links">
                <a href="${pageContext.request.contextPath}/customer/login" class="icon-link">
                    <img src="${pageContext.request.contextPath}/resources/image/login_image.png" alt="로그인" />
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
            <c:if test="${not empty sessionScope.loginCustomer}">
                <a href="${pageContext.request.contextPath}/myPage" class="icon-link">
                    <img src="https://cdn-icons-png.flaticon.com/512/747/747376.png" alt="마이" />
                    <span>마이페이지</span>
                </a>
            </c:if>

            <a href="${pageContext.request.contextPath}/cart" class="icon-link">
                <img src="https://cdn-icons-png.flaticon.com/512/263/263142.png" alt="장바구니" />
                <span>장바구니</span>
            </a>

            <%-- 예약내역 메뉴 --%>
            <a href="${pageContext.request.contextPath}/orders" class="icon-link">
                <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iMyIgeT0iNCIgd2lkdGg9IjE4IiBoZWlnaHQ9IjE4IiByeD0iMiIgcnk9IjIiIHN0cm9rZT0iIzMzMyIgc3Ryb2tlLXdpZHRoPSIyIiBmaWxsPSJub25lIi8+CjxsaW5lIHgxPSIxNiIgeTE9IjIiIHgyPSIxNiIgeTI9IjYiIHN0cm9rZT0iIzMzMyIgc3Ryb2tlLXdpZHRoPSIyIi8+CjxsaW5lIHgxPSI4IiB5MT0iMiIgeDI9IjgiIHkyPSI2IiBzdHJva2U9IiMzMzMiIHN0cm9rZS13aWR0aD0iMiIvPgo8bGluZSB4MT0iMyIgeTE9IjEwIiB4Mj0iMjEiIHkyPSIxMCIgc3Ryb2tlPSIjMzMzIiBzdHJva2Utd2lkdGg9IjIiLz4KPGNpcmNsZSBjeD0iOSIgY3k9IjE2IiByPSIxIiBmaWxsPSIjMzMzIi8+CjxjaXJjbGUgY3g9IjE1IiBjeT0iMTYiIHI9IjEiIGZpbGw9IiMzMzMiLz4KPC9zdmc+Cg==" alt="예약 내역"/>
                <span>예약내역</span>
            </a>

            <%-- 로그인된 경우 로그아웃 메뉴 표시 --%>
            <c:if test="${not empty sessionScope.loginCustomer}">
                <a href="${pageContext.request.contextPath}/customer/logout" class="icon-link">
                    <img src="https://cdn-icons-png.flaticon.com/512/1828/1828490.png" alt="로그아웃" />
                    <span>로그아웃</span>
                </a>
            </c:if>
        </div>
    </div>
</header>