<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html>

<head>
    <meta charset="UTF-8">
    <title>${accomm.accommodationName} - 상세보기</title>

    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/accommDetail_style.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/searchHeader.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/roomPreview.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/reviewPreview.css">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/noticeAccomm.css">
</head>
<body>

<!-- Header -->
<%@ include file="searchHeader.jsp"%>

<!-- Body -->
<div class="hotel-container">

    <!-- 이미지 슬라이더 -->
    <div class="slider">
        <c:forEach var="img" items="${accommImage}" varStatus="status">
            <img class="slide-image <c:if test='${status.first}'>active</c:if>"
                 src="${pageContext.request.contextPath}${img.accommodationImageFilePath}"
                 alt="숙소 이미지 ${status.index + 1}" />
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
            <a class="review-more" href="${pageContext.request.contextPath}/domestic/review/${accomm.accommodationId}">전체보기 ></a>
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
            <div class="room-card"
                 onclick="goToRoomDetail('${room.roomId}', '${room.accommodationId}')"
                 style="cursor: pointer;">

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
                    <button class="left" onclick="event.stopPropagation(); changeRoomImage(this, -1)">❮</button>
                    <button class="right" onclick="event.stopPropagation(); changeRoomImage(this, 1)">❯</button>
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
                        <button class="cart-btn" onclick="event.stopPropagation(); postAddToCart('${room.roomId}')">🛒</button>
                        <button class="reserve-btn" onclick="event.stopPropagation(); reserveRoom('${room.roomId}')">예약하기</button>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 이용안내/예약공지/길안내 섹션 -->
    <div class="notice-box">

        <!-- 길안내 -->
        <div class="notice-section">
            <h3>길안내</h3>
            <div class="notice-content">
                <pre>${accomm.directions}</pre>
            </div>
            <button class="notice-toggle">전체보기</button>
        </div>

        <!-- 이용안내 -->
        <div class="notice-section">
            <h3>이용 안내</h3>
            <div class="notice-content">
                <pre>${accomm.guideLine}</pre>
            </div>
            <button class="notice-toggle">전체보기</button>
        </div>

        <!-- 예약공지 -->
        <div class="notice-section">
            <h3>예약 공지</h3>
            <div class="notice-content">
                <pre>${accomm.reserveNotice}</pre>
            </div>
            <button class="notice-toggle">전체보기</button>
        </div>

        <!-- 후기요약 -->
        <div class="notice-section">
            <h3>후기요약</h3>
            <div class="notice-content">
                <pre>${accomm.summaryReview}</pre>
            </div>
            <button class="notice-toggle">전체보기</button>
        </div>

    </div>

    <script>
        function postAddToCart(roomId) {
            const data = {
                roomId: roomId,
                checkIn: '${param.checkIn}',
                checkOut: '${param.checkOut}',
                adultCount: '${param.adultCnt}',
                childCount: '${param.babyCnt}'
            };

            fetch('${pageContext.request.contextPath}/cart/add', {
                method: 'POST',
                headers: {
                    'Content-Type': 'application/json'  // 서버가 JSON 받을 준비가 되어 있어야 함
                },
                body: JSON.stringify(data)
            })
                .then(response => {
                    if (response.ok) {
                        alert("장바구니에 추가되었습니다!");
                    } else {
                        alert("추가 실패 😥");
                    }
                })
                .catch(error => {
                    console.error("에러 발생:", error);
                    alert("오류가 발생했습니다.");
                });
        }
    </script>

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

<!-- 이용안내 토글 -->
<script>
    document.querySelectorAll('.notice-toggle').forEach(button => {
        button.addEventListener('click', function() {
            const content = this.previousElementSibling;
            const expanded = content.classList.toggle('expanded');

            if (expanded) {
                content.style.maxHeight = "1000px";
                this.textContent = "간단히 보기";
            } else {
                content.style.maxHeight = "120px";
                this.textContent = "전체보기";
            }
        });
    });
</script>

<script>
    function goToRoomDetail(roomId, accommodationId) {
        window.location.href = '/yanupja/domestic/room/' + roomId + '?accommodationId=' + accommodationId;
    }

    function addToCart(roomId) {
        console.log("장바구니 추가:", roomId);
        // 여기에 AJAX 또는 form 처리 로직 추가
    }

    function reserveRoom(roomId) {
        console.log("예약하기 클릭:", roomId);
        // 예약 로직 처리
    }
</script>
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script src="${pageContext.request.contextPath}/resources/js/searchHeader.js"></script>

</body>
</html>
