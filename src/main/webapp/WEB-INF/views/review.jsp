<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>


<html>
<head>
    <title>숙소 후기</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/review.css"/>
</head>
<body>
<%@ include file="/WEB-INF/views/common/searchHeader.jsp" %>

<div class="review-container">

    <!-- 숙소 평점 -->
    <div class="review-score-box">
        <div class="score-title">숙소 평점</div>
        <div class="score-value">
            <span class="star">★</span>
            <span class="score">${review.reviewScore}</span>
        </div>
    </div>

    <!-- 숙소 후기 사진 -->
    <div class="review-photo-box">
        <div class="slider-header">
            <span class="section-title">숙소 후기사진</span>
            <a class="review-more" href="#">전체보기 (${review.reviewCnt})</a>
        </div>

        <div class="photo-slider-wrapper">
            <button class="slider-btn left" onclick="moveReviewPhoto(-1)">❮</button>
            <div class="photo-slider" id="reviewPhotoSlider">
                <c:forEach var="photo" items="${reviewImages}">
                    <img class="review-photo" src="/yanupja/${photo.accommodationImageFilePath}" alt="후기 사진">
                </c:forEach>
            </div>
            <button class="slider-btn right" onclick="moveReviewPhoto(1)">❯</button>
        </div>
    </div>

    <!-- 후기 리스트 영역 -->
    <div id="reviewContainer">
        <c:forEach var="reviewItem" items="${reviewList}">
            <div class="review-item">
                <div class="review-header">
                    <div class="review-stars">
                        <c:forEach begin="1" end="5" var="i">
                            <c:choose>
                                <c:when test="${i <= reviewItem.reviewScore}">
                                    <i class="star filled">★</i>
                                </c:when>
                                <c:otherwise>
                                    <i class="star">★</i>
                                </c:otherwise>
                            </c:choose>
                        </c:forEach>
                    </div>
                    <div class="review-meta">
                        <span class="review-writer">고객1</span>
                        <span class="review-type">${reviewItem.accommodationName} | ${reviewItem.rating}</span>
                    </div>
                    <div class="review-date">${reviewItem.createdAt}</div>
                </div>

                <div class="review-content">
                    <p>${reviewItem.reviewDetail}</p>
                </div>

                <div class="review-reply">
                    <strong>숙소 답변</strong>
                    <div class="reply-content short" id="reply_${reviewItem.reviewId}">
                        <p>고객님의 소중한 의견 감사합니다. 더욱 노력하겠습니다.</p>
                        <div class="reply-date">2025-06-24</div>
                    </div>
                    <button class="btn-toggle" onclick="toggleReply('reply_${reviewItem.reviewId}', this)">더보기 ▼</button>
                </div>
            </div>
        </c:forEach>
    </div>

    <!-- 더보기 버튼 -->
    <c:if test="${hasMore}">
        <button id="loadMoreBtn" onclick="loadMoreReviews()">더보기</button>
    </c:if>
</div>

</body>

<!-- JS 스크립트 -->
<script>
    let currentPage = 1;
    const accommodationId = "${accommodationId}"; // 문자열로 감싸야 안전

    function loadMoreReviews() {
        currentPage++;
        fetch(`/yanupja/domestic/review/more?accommodationId=${accommodationId}&page=${currentPage}`)
            .then(res => res.text())
            .then(html => {
                if (html.trim() === '') {
                    document.getElementById("loadMoreBtn").style.display = "none";
                } else {
                    document.getElementById("reviewContainer").insertAdjacentHTML("beforeend", html);
                }
            });
    }

    function toggleReply(id, btn) {
        const content = document.getElementById(id);
        const isExpanded = content.classList.contains("expanded");

        if (isExpanded) {
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