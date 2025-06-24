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
        <a href="/home.jsp">
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
        <img id="mainImage" src="${hotel.imagePaths[0]}" alt="숙소 이미지" />
        <button class="left" onclick="changeImage(-1)">❮</button>
        <button class="right" onclick="changeImage(1)">❯</button>
    </div>

    <!-- 숙소 정보 -->
    <div class="hotel-info">
        <h2>${hotel.name}</h2>
        <p>${hotel.address}</p>
        <p>${hotel.grade}성급</p>
    </div>

    <!-- 리뷰 섹션 -->
    <div class="review-section">
        <div class="review-header">
            <span class="star">★</span>
            <span class="score">${hotel.rating}</span>
            <span class="count">(${hotel.reviewCount})</span>
            <a class="review-more" href="review.jsp?hotelId=${hotel.id}">전체보기 ></a>
        </div>

        <div class="review-list">
            <c:forEach var="review" items="${hotel.reviews}" varStatus="status">
                <div class="review-card">
                    <div class="review-stars">
                        <c:forEach begin="1" end="${review.stars}">
                            ★
                        </c:forEach>
                    </div>
                    <div class="review-date">${review.date}</div>
                    <div class="review-content">
                        <p>${review.text}</p>
                        <c:if test="${not empty review.imagePath}">
                            <img src="${review.imagePath}" alt="리뷰 이미지" />
                        </c:if>
                    </div>
                </div>
            </c:forEach>
        </div>
    </div>

</div>


<!-- 이미지 슬라이더 Script -->
<script>
    let images = [
        <c:forEach var="img" items="${hotel.imagePaths}" varStatus="status">
        "<c:out value='${img}'/>"<c:if test="${!status.last}">,</c:if>
        </c:forEach>
    ];
    let currentIndex = 0;

    function changeImage(direction) {
        currentIndex += direction;
        if (currentIndex < 0) currentIndex = images.length - 1;
        if (currentIndex >= images.length) currentIndex = 0;
        document.getElementById("mainImage").src = images[currentIndex];
    }
</script>

</body>
</html>
