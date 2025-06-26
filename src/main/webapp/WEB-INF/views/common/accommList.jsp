<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="accommodation-list">
  <c:forEach var="room" items="${roomList}">
    <div class="accommodation-card">
      <img class="thumbnail" src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="${room.roomName}">
      <div class="info">
        <div class="name">${room.roomName}</div>
        <div class="price">가격 <span class="final-price">${room.price}원~</span></div>
        <div class="detail-link"><a href="${pageContext.request.contextPath}/room/${room.roomId}">상세보기</a></div>
      </div>
    </div>
  </c:forEach>
</div>
