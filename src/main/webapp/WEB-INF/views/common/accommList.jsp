<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="accommodation-list">
  <c:forEach var="room" items="${roomList}">
    <a href="${pageContext.request.contextPath}/domestic/hotel/${room.accommodationId}" class="accommodation-card">
      <img class="thumbnail" src="/yanupja${room.accommodationImageFilePath}" alt="${room.accommodationName}">
      <div class="info">
        <div class="name">${room.accommodationName}</div>
        <div class="location">📍 ${room.provinceName} ${room.districtName}</div>
        <div class="rating">⭐ ${room.reviewScore} (${room.reviewCnt})</div>
        <div class="checkin">숙박 ${room.checkIn} ~ ${room.checkOut}</div>
        <div class="price">최저가 <span class="final-price">${room.price}원~</span></div>
      </div>
    </a>
  </c:forEach>
</div>

      <!-- ★ 장바구니 아이콘: 카드 우측 상단에 절대 위치 -->
<%--      <div class="actions">--%>
<%--        <a class="add-to-cart"--%>
<%--           href="${pageContext.request.contextPath}/cart/add"--%>
<%--           title="장바구니 보기">--%>
<%--          <i class="fas fa-shopping-cart"></i>--%>
<%--        </a>--%>
<%--      </div>--%>
<c:forEach var="room" items="${roomList}">
      <div class="actions">
      <form class="add-to-cart-form"
            action="${pageContext.request.contextPath}/cart/add"
            method="post"
            style="position:absolute; top:8px; right:8px;">
        <!-- 필요한 파라미터들을 hidden 으로 -->
        <input type="hidden" name="roomId" value="${room.accommodationId}" />
        <input type="hidden" name="adultCount" value="${condition.adultCnt}" />
        <input type="hidden" name="childCount" value="${condition.babyCnt}" />


        <button type="submit"
                class="add-to-cart"
                title="장바구니에 담기"
                >
          <i class="fas fa-shopping-cart"></i>
        </button>
      </form>
      </div>


    </div>
</c:forEach>
</div>
