<%-- /WEB-INF/views/index.jsp --%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0" />
    <title>야눕자 메인 페이지</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/header.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/index.css" />
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/footer.css" />
</head>
<body>

<%@ include file="/WEB-INF/views/common/header.jsp" %>

<main>
    <!-- 공지사항 영역 -->
    <!-- 공지사항 배너 -->
    <c:choose>
        <c:when test="${not empty latestNotice}">
            <div class="notice-banner">
                <a href="${pageContext.request.contextPath}/notice/${latestNotice.noticeId}" class="notice-tag" target="_blank">공지</a>
                <a href="${pageContext.request.contextPath}/notice/${latestNotice.noticeId}" class="notice-text" target="_blank">
                        ${latestNotice.title}
                </a>
            </div>
        </c:when>
        <c:otherwise>
            <div class="notice-banner">
                <span class="notice-tag">공지</span>
                <span class="notice-text">등록된 공지사항이 없습니다.</span>
            </div>
        </c:otherwise>
    </c:choose>


    <section class="section">
        <div class="category-boxes">
            <a href="#" class="category-box">
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="국내숙소" />
                <p>국내숙소</p>
            </a>
            <a href="#" class="category-box">
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="해외숙소" />
                <p>해외숙소</p>
            </a>
            <a href="#" class="category-box">
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="내주변" />
                <p>내주변</p>
            </a>
        </div>

        <div class="event-slider">
            <button class="prev">&#10094;</button>
            <div class="event-track">
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="이벤트1" />
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="이벤트2" />
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="이벤트3" />
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="이벤트4" />
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="이벤트5" />
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="이벤트6" />
                <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="이벤트7" />
            </div>
            <button class="next">&#10095;</button>
        </div>

        <section class="hot-places">
            <h2>관심이 많은 숙소 </h2>
            <p>주간 조회수가 많은 숙소 Top 10</p>
            <div class="hot-slider">
                <button class="hot-prev">&#10094;</button>
                <div class="hot-track">
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소1" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소2" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소3" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소4" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소5" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소6" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소7" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소8" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소9" />
                    <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="숙소10" />
                </div>
                <button class="hot-next">&#10095;</button>
            </div>

            <section class="popular-places">
                <div class="popular-slider">
                    <h2>많이 찾는 숙소 </h2>
                    <p>주간 인기 숙소 Top 10</p>
                    <button class="popular-prev">&#10094;</button>
                    <div class="popular-track">
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기1" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기2" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기3" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기4" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기5" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기6" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기7" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기8" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기9" />
                        <img src="${pageContext.request.contextPath}/resources/image/hotel1.png" alt="인기10" />
                    </div>
                    <button class="popular-next">&#10095;</button>
                </div>
            </section>

        </section>

    </section>
</main>

<%@ include file="/WEB-INF/views/common/footer.jsp" %>

<script>
    function initializeSlider(sliderSelector, trackSelector, prevBtnSelector, nextBtnSelector) {
        const slider = document.querySelector(sliderSelector);
        const track = document.querySelector(trackSelector);
        const prevBtn = document.querySelector(prevBtnSelector);
        const nextBtn = document.querySelector(nextBtnSelector);

        if (!slider || !track || !prevBtn || !nextBtn) {
            console.warn("[Slider Init] One or more elements not found for selector: " + sliderSelector);
            return;
        }

        let currentIndex = 0;
        const slideMarginRight = 16;
        let slideWidth = 0;

        if (track.children.length > 0) {
            const firstSlide = track.children[0];
            const computedStyle = getComputedStyle(firstSlide);
            const imageWidth = firstSlide.offsetWidth;
            const marginRight = parseFloat(computedStyle.marginRight);

            if (isNaN(marginRight) || imageWidth === 0) {
                console.warn("[" + sliderSelector + "] Image width or margin is invalid. imageWidth: " + imageWidth + ", marginRight: " + marginRight + ". Using default 316px.");
                slideWidth = 316;
            } else {
                slideWidth = imageWidth + marginRight;
            }

            console.log("[" + sliderSelector + "] Image Width: " + imageWidth + "px, Margin Right: " + marginRight + "px, Calculated Slide Width: " + slideWidth + "px");
        } else {
            console.warn("[" + sliderSelector + "] No slides found in track.");
            return;
        }

        const sliderVisibleWidth = slider.offsetWidth;
        const visibleCount = Math.max(1, Math.floor(sliderVisibleWidth / slideWidth));
        const maxIndex = Math.max(0, track.children.length - visibleCount);

        console.log("--- " + sliderSelector + " Slider Init ---");
        console.log("Slider Visible Width: " + sliderVisibleWidth + "px");
        console.log("Slide Width (incl. margin): " + slideWidth + "px");
        console.log("Visible Slides: " + visibleCount);
        console.log("Total Slides: " + track.children.length);
        console.log("Max Index: " + maxIndex);
        console.log("------------------------------------");


        prevBtn.addEventListener('click', () => {
            if (currentIndex > 0) {
                currentIndex--;
                // 여기를 변경
                track.style.transform = "translateX(-" + (slideWidth * currentIndex) + "px)";
                console.log("[" + sliderSelector + "] Prev clicked. New index: " + currentIndex + ", Transform: translateX(-" + (slideWidth * currentIndex) + "px)");
            } else {
                console.log("[" + sliderSelector + "] Already at first slide.");
            }
        });

        nextBtn.addEventListener('click', () => {
            // 여기를 변경
            console.log("[" + sliderSelector + "] Inside next click - slideWidth: " + slideWidth + ", currentIndex: " + currentIndex);

            if (currentIndex < maxIndex) {
                currentIndex++;
                // 여기를 변경
                track.style.transform = "translateX(-" + (slideWidth * currentIndex) + "px)";
                console.log("[" + sliderSelector + "] Next clicked. New index: " + currentIndex + ", Transform: translateX(-" + (slideWidth * currentIndex) + "px)");
            } else {
                console.log("[" + sliderSelector + "] Already at last slide or no more slides.");
            }
        });

        // (선택 사항) 창 크기 변경 시 슬라이더 재계산 로직 추가 (Debounce 포함 권장)
        // 이 부분은 주석 처리 유지하거나 삭제합니다.
        // let resizeTimer;
        // window.addEventListener('resize', () => {
        //     clearTimeout(resizeTimer);
        //     resizeTimer = setTimeout(() => {
        //         initializeSlider(sliderSelector, trackSelector, prevBtnSelector, nextBtnSelector);
        //     }, 250);
        // });
    }

    window.addEventListener('load', function () {
        initializeSlider(
            '.event-slider',
            '.event-track',
            '.event-slider .prev',
            '.event-slider .next'
        );

        initializeSlider(
            '.hot-slider',
            '.hot-track',
            '.hot-slider .hot-prev',
            '.hot-slider .hot-next'
        );

        initializeSlider(
            '.popular-slider',
            '.popular-track',
            '.popular-slider .popular-prev',
            '.popular-slider .popular-next'
        );
    });
</script>

</body>
</html>