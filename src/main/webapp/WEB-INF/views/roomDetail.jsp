<%@ page contentType="text/html;charset=UTF-8" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<html>
<head>
    <title>객실 상세정보</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/roomDetail.css">
</head>
<body>
 <%@ include file="common/searchHeader.jsp"%>

 <div class="room-container">

     <!-- 이미지 슬라이드 -->
     <div class="slider">
         <c:forEach var="img" items="${room.imageList}">
             <img class="slide-img" src="${img.roomImageFilePath}" alt="객실 이미지">
         </c:forEach>
         <div class="slider-btn prev" onclick="prevSlide()">❮</div>
         <div class="slider-btn next" onclick="nextSlide()">❯</div>
     </div>

     <!-- 객실 정보 -->
     <div class="room-info">
         <h2>${room.roomName}</h2>
         <span>기준 인원: ${room.standardCapacity}인 / 최대 인원: ${room.maximumCapacity}인</span>

         <span>
            침대:
            <c:forEach var="bed" items="${room.bedList}" varStatus="loop">
                ${bed.bedType} ${bed.bedCount}개<c:if test="${!loop.last}">, </c:if>
            </c:forEach>
        </span>

         <span>넓이: ${room.roomSize}㎡</span>
     </div>

     <!-- 숙박 정보 박스 -->
     <div class="stay-box">
         <div class="stay-left">
             <div>숙박</div>
             <div>체크인 <strong>${room.checkinTime}</strong> ~ 체크아웃 <strong>${room.checkoutTime}</strong></div>
         </div>
         <div class="stay-right">
             <div class="price"><fmt:formatNumber value="${room.price}" type="number" groupingUsed="true"/>원</div>
             <div class="per-night">/1박</div>
         </div>
     </div>

     <!-- 기본정보 -->
     <div class="section">
         <h3>기본정보</h3>
         <div class="section-content short" id="basicInfo">
             <pre>${room.basicInfo}</pre>
         </div>
         <button class="btn-showall" onclick="toggleSection('basicInfo', this)">전체보기</button>
     </div>

     <!-- 시설/서비스 -->
     <div class="section">
         <h3>시설/서비스</h3>
         <div class="section-content short" id="facilityInfo">
             <pre>${room.facilityServiceInfo}</pre>
         </div>
         <button class="btn-showall" onclick="toggleSection('facilityInfo', this)">전체보기</button>
     </div>
 </div>
</body>

<!-- 이미지 슬라이ㅑ더-->
<script>
    let currentSlide = 0;
    function showSlide(index) {
        const slides = document.getElementsByClassName("slide-img");
        if (index >= slides.length) currentSlide = 0;
        else if (index < 0) currentSlide = slides.length - 1;
        else currentSlide = index;

        for (let i = 0; i < slides.length; i++) {
            slides[i].classList.remove("active");
        }
        slides[currentSlide].classList.add("active");
    }

    function nextSlide() { showSlide(currentSlide + 1); }
    function prevSlide() { showSlide(currentSlide - 1); }

    window.onload = () => showSlide(currentSlide);
</script>

<!-- 토글 -->
<script>
    function toggleSection(id, btn) {
        const content = document.getElementById(id);
        const isExpanded = content.classList.contains("expanded");

        if (isExpanded) {
            content.classList.remove("expanded");
            content.classList.add("short");
            btn.innerText = "전체보기";
        } else {
            content.classList.remove("short");
            content.classList.add("expanded");
            btn.innerText = "접기";
        }
    }
</script>

</html>
