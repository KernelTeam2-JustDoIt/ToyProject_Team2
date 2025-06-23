<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="accommodation-list">
  <c:forEach var="room" items="${roomList}">
    <a href="${pageContext.request.contextPath}/domestic/hotel/${room.accommodationId}" class="accommodation-card">
      <img class="thumbnail" src="${room.accommodationImageFilePath}" alt="${room.accommodationName}">
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