<%@ page contentType="text/html; charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>야눕자</title>
    <link rel="stylesheet" href="<c:url value='/resources/css/main_style.css' />" />
</head>

<body>

<header>
    <div class="logo">야눕자</div>

    <div class="search-bar">
        <input type="text" placeholder="신나는 토요일 불타는 이 밤" />
    </div>

    <div class="header-right">
        <div class="auth-links">
            <a href="#" class="icon-link">
                <img src="" alt="로그인" />
                <span>로그인</span>
            </a>
            <a href="#" class="icon-link">
                <img src="/경로/avatar-signup.png" alt="회원가입" />
                <span>회원가입</span>
            </a>
        </div>

        <div class="icon-links">
            <a href="#" class="icon-link">
                <img src="https://cdn-icons-png.flaticon.com/512/747/747376.png" alt="마이" />
                <span>마이</span>
            </a>
            <a href="#" class="icon-link">
                <img src="https://cdn-icons-png.flaticon.com/512/535/535234.png" alt="찜" />
                <span>찜</span>
            </a>
            <a href="#" class="icon-link">
                <img src="https://cdn-icons-png.flaticon.com/512/263/263142.png" alt="장바구니" />
                <span>장바구니</span>
            </a>
        </div>
    </div>
</header>

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
            <img src="https://via.placeholder.com/300x200?text=국내숙소" alt="국내숙소" />
            <p>국내숙소</p>
        </a>
        <a href="#" class="category-box">
            <img src="https://via.placeholder.com/300x200?text=해외숙소" alt="해외숙소" />
            <p>해외숙소</p>
        </a>
        <a href="#" class="category-box">
            <img src="https://via.placeholder.com/300x200?text=내주변" alt="내주변" />
            <p>내주변</p>
        </a>
    </div>

    <!-- 이벤트 슬라이더 -->
    <!-- 기존 코드 유지 -->

    <!-- 이벤트 슬라이더 (이미지 크기 축소됨) -->
    <div class="event-slider">
        <button class="prev">&#10094;</button>
        <div class="event-track">
            <img src="https://via.placeholder.com/300x150?text=이벤트1" alt="이벤트1" />
            <img src="https://via.placeholder.com/300x150?text=이벤트2" alt="이벤트2" />
            <img src="https://via.placeholder.com/300x150?text=이벤트3" alt="이벤트4" />
            <img src="https://via.placeholder.com/300x150?text=이벤트3" alt="이벤트5" />
            <img src="https://via.placeholder.com/300x150?text=이벤트3" alt="이벤트6" />
            <img src="https://via.placeholder.com/300x150?text=이벤트3" alt="이벤트7" />
        </div>
        <button class="next">&#10095;</button>
    </div>

    <!-- 관심 많은 숙소 슬라이더 -->
    <section class="hot-places">
        <h2>관심이 많은 숙소 </h2>
        <p>주간 조회수가 많은 숙소 Top 10</p>
        <div class="hot-slider">
            <button class="hot-prev">&#10094;</button>
            <div class="hot-track">
                <img src="https://via.placeholder.com/300x150?text=숙소1" alt="숙소1" />
                <img src="https://via.placeholder.com/300x150?text=숙소2" alt="숙소2" />
                <img src="https://via.placeholder.com/300x150?text=숙소3" alt="숙소3" />
                <img src="https://via.placeholder.com/300x150?text=숙소4" alt="숙소4" />
                <img src="https://via.placeholder.com/300x150?text=숙소5" alt="숙소5" />
                <img src="https://via.placeholder.com/300x150?text=숙소6" alt="숙소6" />
                <img src="https://via.placeholder.com/300x150?text=숙소7" alt="숙소7" />
                <img src="https://via.placeholder.com/300x150?text=숙소8" alt="숙소8" />
                <img src="https://via.placeholder.com/300x150?text=숙소9" alt="숙소9" />
                <img src="https://via.placeholder.com/300x150?text=숙소10" alt="숙소10" />
            </div>
            <button class="hot-next">&#10095;</button>
        </div>

        <section class="popular-places">
            <div class="popular-slider">
                <h2>많이 찾는 숙소 </h2>
                <p>주간 인기 숙소 Top 10</p>
                <button class="popular-prev">&#10094;</button>
                <div class="popular-track">
                    <img src="https://via.placeholder.com/300x150?text=인기1" alt="인기1" />
                    <img src="https://via.placeholder.com/300x150?text=인기2" alt="인기2" />
                    <img src="https://via.placeholder.com/300x150?text=인기3" alt="인기3" />
                    <img src="https://via.placeholder.com/300x150?text=인기4" alt="인기4" />
                    <img src="https://via.placeholder.com/300x150?text=인기5" alt="인기5" />
                    <img src="https://via.placeholder.com/300x150?text=인기6" alt="인기6" />
                    <img src="https://via.placeholder.com/300x150?text=인기7" alt="인기7" />
                    <img src="https://via.placeholder.com/300x150?text=인기8" alt="인기8" />
                    <img src="https://via.placeholder.com/300x150?text=인기9" alt="인기9" />
                    <img src="https://via.placeholder.com/300x150?text=인기10" alt="인기10" />
                </div>
                <button class="popular-next">&#10095;</button>
            </div>
        </section>

    </section>

</section>

<footer>
    © 2025 야놀자 벤치마킹
</footer>

<script>
    const track = document.querySelector('.event-track');
    const prevBtn = document.querySelector('.prev');
    const nextBtn = document.querySelector('.next');

    let currentIndex = 0;
    const slideWidth = 316; // 300px 이미지 + 16px margin
    const visibleCount = Math.floor(document.querySelector('.event-slider').offsetWidth / slideWidth);
    const maxIndex = track.children.length - visibleCount;

    prevBtn.addEventListener('click', () => {
        if (currentIndex > 0) {
            currentIndex--;
            track.style.transform = `translateX(-${slideWidth * currentIndex}px)`;
        }
    });

    nextBtn.addEventListener('click', () => {
        if (currentIndex < maxIndex) {
            currentIndex++;
            track.style.transform = `translateX(-${slideWidth * currentIndex}px)`;
        }
    });


    // 관심 숙소 슬라이더 (이벤트 슬라이더와 동일한 방식)
    const hotTrack = document.querySelector('.hot-track');
    const hotPrev = document.querySelector('.hot-prev');
    const hotNext = document.querySelector('.hot-next');

    let hotIndex = 0;
    const hotSlideWidth = 316;
    const hotVisibleCount = Math.floor(document.querySelector('.hot-slider').offsetWidth / hotSlideWidth);
    const hotMaxIndex = hotTrack.children.length - hotVisibleCount;

    hotPrev.addEventListener('click', () => {
        if (hotIndex > 0) {
            hotIndex--;
            hotTrack.style.transform = `translateX(-${hotSlideWidth * hotIndex}px)`;
        }
    });

    hotNext.addEventListener('click', () => {
        if (hotIndex < hotMaxIndex) {
            hotIndex++;
            hotTrack.style.transform = `translateX(-${hotSlideWidth * hotIndex}px)`;
        }
    });

    // 많이 찾는 숙소 슬라이더
    const popularTrack = document.querySelector('.popular-track');
    const popularPrev = document.querySelector('.popular-prev');
    const popularNext = document.querySelector('.popular-next');

    let popularIndex = 0;
    const popularSlideWidth = 316;
    const popularVisibleCount = Math.floor(document.querySelector('.popular-slider').offsetWidth / popularSlideWidth);
    const popularMaxIndex = popularTrack.children.length - popularVisibleCount;

    popularPrev.addEventListener('click', () => {
        if (popularIndex > 0) {
            popularIndex--;
            popularTrack.style.transform = `translateX(-${popularSlideWidth * popularIndex}px)`;
        }
    });

    popularNext.addEventListener('click', () => {
        if (popularIndex < popularMaxIndex) {
            popularIndex++;
            popularTrack.style.transform = `translateX(-${popularSlideWidth * popularIndex}px)`;
        }
    });


</script>

</body>
</html>
