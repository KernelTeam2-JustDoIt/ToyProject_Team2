<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<html>
<head>
    <title>숙소 종류 선택</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/domesticMain.css"/>
</head>
<body>
<%@ include file="searchHeader.jsp" %>

<div class="category-container">
    <a href="${pageContext.request.contextPath}/domestic/hotel" class="category-card">
        <img src="${pageContext.request.contextPath}/resources/image/hotel_category.png" alt="호텔/리조트">
        <div class="category-card-title">호텔/리조트</div>
    </a>

    <a href="${pageContext.request.contextPath}/domestic/hotel" class="category-card">
        <img src="${pageContext.request.contextPath}/resources/image/motel_category.png" alt="모텔">
        <div class="category-card-title">모텔</div>
    </a>

    <a href="${pageContext.request.contextPath}/domestic/hotel" class="category-card">
        <img src="${pageContext.request.contextPath}/resources/image/pension_category.png" alt="펜션/풀빌라">
        <div class="category-card-title">펜션/풀빌라</div>
    </a>

    <a href="${pageContext.request.contextPath}/domestic/hotel" class="category-card">
        <img src="${pageContext.request.contextPath}/resources/image/camping_category.png" alt="글램핑/캠핑">
        <div class="category-card-title">글램핑/캠핑</div>
    </a>
</div>

<div class="carousel-container">
    <h2>이런 상품 어떠세요?</h2>
    <p class="highlight-subtitle">랜덤으로 뽑은 숙소</p>

    <div class="carousel-wrapper">
        <button class="carousel-btn prev" onclick="scrollCarousel(-1)">❮</button>

        <div class="carousel-track" id="carouselTrack">
            <c:forEach var="img" items="${imageList}">
                <a href="${pageContext.request.contextPath}/domestic/hotel/${img.accommodationId}"
                   class="carousel-item category-card">
                    <img src="${pageContext.request.contextPath}${img.accommodationImageFilePath}"
                         alt="숙소 이미지">
                    <div class="category-card-title">
                            ${img.accommodationName}
                    </div>
                </a>
            </c:forEach>
        </div>

        <button class="carousel-btn next" onclick="scrollCarousel(1)">❯</button>
    </div>
</div>

</body>
<script>
    const contextPath = "${pageContext.request.contextPath}";
</script>
<script>
    window.addEventListener("load", function () {
        const track = document.getElementById("carouselTrack");
        const gap = 16;
        const items = track.querySelectorAll(".carousel-item");
        const totalItems = items.length;
        if (totalItems === 0) return;

        const singleWidth = items[0].getBoundingClientRect().width + gap;
        const visibleCount = Math.floor(track.parentElement.offsetWidth / singleWidth);
        const maxIndex = Math.max(0, totalItems - visibleCount);

        let currentIndex = 0;

        window.scrollCarousel = function (direction) {
            currentIndex = Math.min(
                Math.max(currentIndex + direction, 0),
                maxIndex
            );
            track.style.transform =
                `translateX(${-singleWidth * currentIndex}px)`;
        };
    });
</script>
<script src="${pageContext.request.contextPath}/resources/js/searchHeader.js"></script>

</html>
