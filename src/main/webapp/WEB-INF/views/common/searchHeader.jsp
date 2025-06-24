<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/searchHeader.css">
<header>
  <div class="header">
    <button onclick="history.back()">←</button>

    <input type="text" placeholder="숙소 검색...">

    <div class="right-icons">
      <a href="/home.jsp">
        <img src="${pageContext.request.contextPath}/resources/image/home.png" alt="홈" />
      </a>
      <a href="/cart.jsp">
        <img src="${pageContext.request.contextPath}/resources/image/cart.png" alt="장바구니" />
      </a>
    </div>
  </div>
</header>
