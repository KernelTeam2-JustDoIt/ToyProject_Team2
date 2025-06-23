<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>${hotel.name} - 상세보기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/accommDetail_style.css">
</head>
<body>

<!-- Header -->
<div class="header">
    <button onclick="history.back()">←</button>

    <input type="text" placeholder="숙소 검색...">

    <div class="right-icons">
        <a href="/index.jsp">
            <img src="${pageContext.request.contextPath}/resources/image/home.png" alt="홈" />
        </a>
        <a href="/cart.jsp">
            <img src="${pageContext.request.contextPath}/resources/image/cart.png" alt="장바구니" />
        </a>
    </div>
</div>

<!-- Body -->
<div class="hotel-container">

    <!-- 이미지 슬라이더 -->
    <div class="slider">
        <c:forEach var="img" items="${accommImage}" varStatus="status">
            <c:if test="${img.isThumbnail == 1}">
                <img class="slide-image <c:if test='${status.first}'>active</c:if>'"
                     src="/yanupja${img.accommodationImageFilePath}"
                     alt="숙소 이미지 ${status.index + 1}" />
            </c:if>
        </c:forEach>

        <button class="left" onclick="changeImage(-1)">❮</button>
        <button class="right" onclick="changeImage(1)">❯</button>
    </div>

    <!-- 숙소 정보 -->
    <div class="hotel-info">
        <h2>${accomm.accommodationName}</h2>
        <p>${accomm.provinceName} ${accomm.districtName} ${accomm.roadName} ${accomm.buildingNumber}</p>
        <p>${accomm.rating}</p>
    </div>

    <!-- 리뷰 섹션 -->
    <div class="review-section">
        <div class="review-header">
            <span class="star">★</span>
            <span class="score">${review.reviewScore}</span>
            <span class="count">(${review.reviewCnt})</span>
            <a class="review-more" href="review.jsp?hotelId=${accomm.accommodationId}">전체보기 ></a>
        </div>

        <div class="review-list">
            <c:forEach var="review" items="${reviews}" varStatus="status">
                <div class="review-card">
                    <div class="review-stars">
                        <c:forEach begin="1" end="${review.reviewScore}">
                            ★
                        </c:forEach>
                    </div>
                    <div class="review-date">${review.createdAt}</div>
                    <div class="review-content">
                        <p>${review.reviewDetail}</p>
                        <c:if test="${not empty review.filePath}">
                            <img src="${review.filePath}" alt="리뷰 이미지" />
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

    <!-- 객실 정보 섹션 -->
    <div class="room-list">
        <c:forEach var="room" items="${roomList}">
            <div class="room-card">

                <!-- 왼쪽: 이미지 슬라이드 -->
                <div class="room-image-slider">
                    <div class="slides">
                        <c:forEach var="img" items="${room.imageList}" varStatus="status">
                            <c:if test="${img.isThumbnail == 1}">
                                <img class="room-slide active"
                                     src="${img.roomImageFilePath}"
                                     alt="${room.roomName} 썸네일" />
                            </c:if>
                        </c:forEach>
                        <c:forEach var="img" items="${room.imageList}" varStatus="status">
                            <c:if test="${img.isThumbnail != 1}">
                                <img class="room-slide"
                                     src="${img.roomImageFilePath}"
                                     alt="${room.roomName} 이미지 ${status.index + 1}" />
                            </c:if>
                        </c:forEach>
                    </div>
                    <button class="left" onclick="changeRoomImage(this, -1)">❮</button>
                    <button class="right" onclick="changeRoomImage(this, 1)">❯</button>
                </div>

                <!-- 오른쪽: 객실 정보 -->
                <div class="room-info">
                    <h3>${room.roomName}</h3>
                    <span class="room-category">${room.roomCategory}</span>
                    <p>👤 기준 ${room.standardCapacity}인 / 최대 ${room.maximumCapacity}인</p>
                    <p>🛏️
                        <c:forEach var="bed" items="${room.bedList}" varStatus="loop">
                            ${bed.bedType} (${bed.bedCount})<c:if test="${!loop.last}">, </c:if>
                        </c:forEach>
                    </p>
                    <p>🕒 체크인 ${room.checkinTime} ~ 체크아웃 ${room.checkoutTime}</p>
                    <p class="room-price"><strong><fmt:formatNumber value="${room.price}" type="number"/>원</strong>/1박</p>

                    <div class="room-buttons">
                        <button class="cart-btn">🛒</button>
                        <button class="reserve-btn">예약하기</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>



</div>

<!-- 이미지 슬라이드 Script -->
<script>
    let slideImages = document.querySelectorAll(".slide-image");
    let currentIndex = 0;

    function showImage(index) {
        slideImages.forEach((img, i) => {
            img.classList.toggle("active", i === index);
        });
    }

    function changeImage(direction) {
        currentIndex += direction;
        if (currentIndex < 0) currentIndex = slideImages.length - 1;
        if (currentIndex >= slideImages.length) currentIndex = 0;
        showImage(currentIndex);
    }

    // 첫 이미지 보여주기
    window.onload = function() {
        showImage(currentIndex);
    };
</script>

<script>
    // 객실 이미지 슬라이드
    function changeRoomImage(button, direction) {
        const slider = button.closest('.room-image-slider');
        const images = slider.querySelectorAll('.room-slide');
        let currentIndex = Array.from(images).findIndex(img => img.classList.contains('active'));

        images[currentIndex].classList.remove('active');
        currentIndex = (currentIndex + direction + images.length) % images.length;
        images[currentIndex].classList.add('active');
    }
</script>


</body>
</html>
