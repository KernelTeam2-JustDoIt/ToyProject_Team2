<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<html>
<head>
    <title>Title</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/review.css">
</head>
<body>
    <%@ include file="common/searchHeader.jsp"%>

    <div class="review-container">

        <!-- 숙소 평점 -->
        <div class="review-score-box">
            <div class="score-title">숙소 평점</div>
            <div class="score-value">
                <span class="star">★</span>
                <span class="score">${review.rating}</span>
            </div>
        </div>

        <!-- 숙소 후기 사진 -->
        <div class="review-photo-box">
            <div class="slider-header">
                <span class="section-title">숙소 후기사진</span>
                <a class="review-more" href="#">전체보기 (${review.totalPhotoCount})</a>
            </div>

            <div class="photo-slider-wrapper">
                <button class="slider-btn left" onclick="moveReviewPhoto(-1)">❮</button>

                <div class="photo-slider" id="reviewPhotoSlider">
                    <c:forEach var="photo" items="${reviews}">
                        <img class="review-photo" src="${photo.imagePath}" alt="후기 사진">
                    </c:forEach>
                </div>

                <button class="slider-btn right" onclick="moveReviewPhoto(1)">❯</button>
            </div>
        </div>


        <!-- 필터 및 후기 리스트 -->
        <div class="review-list">
            <c:forEach var="review" items="${reviewList}">
                <div class="review-item">
                    <!-- 상단 영역 -->
                    <div class="review-header">
                        <div class="review-stars">
                            <c:forEach begin="1" end="5" var="i">
                            <i class="star <c:if test='${i <= fn:round(review.score)}'>filled</c:if>'></i>
                    </c:forEach>
                </div>
                <div class="review-meta">
                            <span class="review-writer">${review.writerMasked}</span>
                            <span class="review-type">${review.roomName} | ${review.stayType}</span>
                        </div>
                        <div class="review-date">${review.writeDate}</div>
                    </div>

                    <!-- 리뷰 본문 -->
                    <div class="review-content">
                        <p>${review.content}</p>
                    </div>

                    <!-- 숙소 답변 -->
                    <c:if test="${not empty review.replyContent}">
                        <div class="review-reply">
                            <strong>숙소 답변</strong>
                            <div class="reply-content short" id="reply_${review.reviewId}">
                                <p>${review.replyContent}</p>
                                <div class="reply-date">${review.replyDate}</div>
                            </div>
                            <button class="btn-toggle" onclick="toggleReply('reply_${review.reviewId}', this)">더보기 ▼</button>
                        </div>
                    </c:if>

                </div>
            </c:forEach>
        </div>


    </div>

</body>

<!-- 슬라이더 -->
<script>
    let photoScrollX = 0;

    function moveReviewPhoto(direction) {
        const slider = document.getElementById("reviewPhotoSlider");
        const scrollAmount = 300;

        photoScrollX += direction * scrollAmount;
        if (photoScrollX < 0) photoScrollX = 0;
        slider.scrollTo({ left: photoScrollX, behavior: 'smooth' });
    }
</script>

<!-- 답변 -->
<script>
    function toggleReply(id, btn) {
        const content = document.getElementById(id);
        const expanded = content.classList.contains("expanded");

        if (expanded) {
            content.classList.remove("expanded");
            content.classList.add("short");
            btn.innerText = "더보기 ▼";
        } else {
            content.classList.remove("short");
            content.classList.add("expanded");
            btn.innerText = "접기 ▲";
        }
    }
</script>


</html>
