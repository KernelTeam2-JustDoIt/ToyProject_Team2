<%@ page contentType="text/html;charset=UTF-8" %>
<%@ page import="java.util.*" %>
<%
    // 예시용 이미지 및 리뷰 리스트는 DB 연동 시 서버에서 가져오는 부분으로 대체됨
%>

<html>
<head>
    <title>호텔 상세 페이지</title>
    <style>
        body { font-family: Arial, sans-serif; padding: 20px; }
        .slider { width: 800px; position: relative; margin-bottom: 30px; }
        .slider img { width: 100%; height: auto; display: none; border-radius: 10px; }
        .slider img.active { display: block; }

        .nav-btn {
            position: absolute; top: 50%; transform: translateY(-50%);
            background-color: rgba(0,0,0,0.4); color: white;
            padding: 10px 15px; cursor: pointer; border-radius: 50%;
            font-size: 18px; user-select: none;
        }
        .prev { left: 10px; }
        .next { right: 10px; }

        .reviews { max-width: 800px; }
        .review { border-bottom: 1px solid #ddd; padding: 10px 0; }
        .review-title { font-weight: bold; font-size: 16px; color: #333; }
        .review-meta { font-size: 13px; color: #777; }
        .review a { text-decoration: none; color: inherit; display: block; }
        .review:hover { background-color: #f9f9f9; }
    </style>
</head>
<body>

<h2>신라스테이 삼성</h2>

<!-- 이미지 슬라이더 -->
<div class="slider">
    <img src="/images/img1.jpg" class="active">
    <img src="/images/img2.jpg">
    <img src="/images/img3.jpg">
    <div class="nav-btn prev" onclick="changeSlide(-1)">❮</div>
    <div class="nav-btn next" onclick="changeSlide(1)">❯</div>
</div>

<!-- 리뷰 리스트 -->
<div class="reviews">
    <h3>리뷰</h3>

    <div class="review">
        <a href="reviewDetail.jsp?id=1">
            <div class="review-title">조식이 정말 훌륭했어요!</div>
            <div class="review-meta">⭐ 5.0 | 2024-05-30</div>
        </a>
    </div>

    <div class="review">
        <a href="reviewDetail.jsp?id=2">
            <div class="review-title">위치가 정말 최고!</div>
            <div class="review-meta">⭐ 5.0 | 2023-10-01</div>
        </a>
    </div>

    <div class="review">
        <a href="reviewDetail.jsp?id=3">
            <div class="review-title">침대가 너무 편했어요</div>
            <div class="review-meta">⭐ 4.8 | 2023-07-15</div>
        </a>
    </div>
</div>

<script>
    let current = 0;
    const images = document.querySelectorAll(".slider img");

    function changeSlide(step) {
        images[current].classList.remove("active");
        current = (current + step + images.length) % images.length;
        images[current].classList.add("active");
    }
</script>

</body>
</html>

