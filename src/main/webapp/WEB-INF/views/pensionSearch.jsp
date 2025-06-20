<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>호텔/리조트 통합 검색</title>
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/pension_style.css">
</head>
<body>

<form id="searchForm" action="/domestic/hotel" method="post">
    <!-- 숨은 필드들 -->
    <input type="hidden" name="district" id="districtInput">
    <input type="hidden" name="checkIn" id="checkInInput">
    <input type="hidden" name="checkOut" id="checkOutInput">
    <input type="hidden" name="adultCnt" id="adultInput">
    <input type="hidden" name="babyCnt" id="babyInput">
    <input type="hidden" name="page" id="pageInput" value="${page}">

    <header>
        <div class="left-icon">←</div>
        <div class="center-title">호텔/리조트</div>
        <div class="right-icons">
            <img src="/path/to/home-icon.svg" alt="홈">
            <img src="/path/to/cart-icon.svg" alt="장바구니">
        </div>
    </header>

    <div class="search-bar">
        <div class="search-options-row">
            <div class="search-option" onclick="togglePopup('searchPopup'); showTab('region')">
                <img src="/path/to/location-icon.svg" alt="위치">
                <span id="region-label">강남/역삼/삼성</span>
            </div>
            <div class="search-option" onclick="togglePopup('searchPopup'); showTab('date')">
                <img src="/path/to/calendar-icon.svg" alt="달력">
                <span id="date-label">날짜 선택</span>
            </div>
            <div class="search-option" onclick="togglePopup('personPopup')">
                <img src="/path/to/person-icon.svg" alt="인원">
                <span id="person-label">성인 2</span>
            </div>
        </div>
        <div class="search-button-row">
            <button type="submit" class="search-submit-btn" onclick="submitSearch()">검색</button>
        </div>
    </div>

    <!-- 검색 팝업: 지역/날짜 -->
    <div class="popup" id="searchPopup">
        <div class="popup-content">
            <div class="popup-header">
                <div>
                    <button onclick="showTab('region')" type="button">지역</button>
                    <button onclick="showTab('date')" type="button">날짜</button>
                </div>
                <div class="close-btn" onclick="togglePopup('searchPopup')">✕</div>
            </div>
            <div class="tab-content" id="regionTab">
                <div class="region-container">
                    <div class="region-sidebar">
                        <div class="active">서울</div>
                        <div>부산</div>
                        <div>제주</div>
                        <div>경기</div>
                        <div>인천</div>
                        <div>강원</div>
                        <div>경상</div>
                        <div>전라</div>
                        <div>충청</div>
                    </div>
                    <div class="region-main">
                        <div class="region-tab">
                            <span>서울</span>
                            <span>전체 ▶</span>
                        </div>
                        <ul>
                            <li>강남/역삼/삼성</li>
                            <li>신사/청담/압구정</li>
                            <li>서초/교대/사당</li>
                            <li>잠실/송파/강동</li>
                            <li>을지로/명동/중구/동대문</li>
                            <li>서울역/이태원/용산</li>
                            <li>종로/인사동</li>
                            <li>홍대/합정/마포/서대문</li>
                            <li>여의도</li>
                            <li>영등포역</li>
                            <li>구로/신도림/금천</li>
                            <li>김포공항/염창/강서</li>
                            <li>건대입구/성수/왕십리</li>
                            <li>성북/강북/노원/도봉</li>
                        </ul>
                    </div>
                </div>
            </div>
            <div class="tab-content" id="dateTab" style="display:none">
                <div id="calendar-container"></div>
                <div class="calendar-footer">
                    <div>👤 성인 2</div>
                    <div><button type="button" onclick="togglePopup('personPopup')">변경하기</button></div>
                </div>
                <button type="button" class="apply-btn" id="dateApplyBtn">적용하기</button>
            </div>
        </div>
    </div>

    <!-- 인원 선택 팝업 -->
    <div class="popup" id="personPopup">
        <div class="popup-content">
            <div class="popup-header">
                <div style="font-weight: bold; font-size: 18px;">인원 선택</div>
                <div class="close-btn" onclick="togglePopup('personPopup')">✕</div>
            </div>
            <div class="tab-content">
                <div class="person-box">
                    <div class="person-row">
                        <span>성인</span>
                        <div>
                            <button type="button" onclick="changePerson('adult', -1)">-</button>
                            <span id="adultCount">2</span>
                            <button type="button" onclick="changePerson('adult', 1)">+</button>
                        </div>
                    </div>
                    <div class="person-row">
                        <span>아동</span>
                        <div>
                            <button type="button" onclick="changePerson('child', -1)">-</button>
                            <span id="childCount">0</span>
                            <button type="button" onclick="changePerson('child', 1)">+</button>
                        </div>
                    </div>
                </div>
                <button type="button" class="apply-btn" onclick="applyPerson()">적용하기</button>
            </div>
        </div>
    </div>

    <!-- 숙소 정보 -->

    <div class="accommodation-list">
        <c:forEach var="room" items="${roomList}" varStatus="status">
            <c:if test="${status.index < 6}">
                <div class="accommodation-card">
                    <img class="thumbnail" src="${room.accommodationImageFilePath}" alt="${room.accommodationName}">
                    <div class="info">
                        <div class="name">${room.accommodationName}</div>
                        <div class="location">📍 ${room.provinceName} ${room.districtName}</div>
                        <div class="rating">⭐ ${room.reviewScore} (${room.reviewCnt})</div>
                        <div class="checkin">숙박 ${room.checkIn}</div>
                        <div class="price"><span class="final-price">${room.price}원~</span></div>
                    </div>
                </div>
            </c:if>
        </c:forEach>
    </div>

    <!-- 페이징 처리 -->
    <div class="pagination">
        <c:if test="${page > 1}">
            <a href="#" onclick="goToPage(${page - 1})">이전</a>
        </c:if>

        <c:forEach var="i" begin="1" end="${totalPages}">
            <a href="#" onclick="goToPage(${i})" class="${i == page ? 'active' : ''}">${i}</a>
        </c:forEach>

        <c:if test="${page < totalPages}">
            <a href="#" onclick="goToPage(${page + 1})">다음</a>
        </c:if>
    </div>


</form>

<script>
    const container = document.getElementById("calendar-container");
    const dateLabel = document.getElementById("date-label");
    const regionLabel = document.getElementById("region-label");
    const personLabel = document.getElementById("person-label");

    let checkIn = new Date();
    let checkOut = new Date();
    checkOut.setDate(checkOut.getDate() + 1);
    updateDateLabel();

    let adult = 2;
    let child = 0;
    updatePersonLabel();

    function togglePopup(id) {
        const popup = document.getElementById(id);
        popup.style.display = (popup.style.display === 'flex') ? 'none' : 'flex';
    }

    function showTab(tab) {
        document.getElementById('regionTab').style.display = (tab === 'region') ? 'block' : 'none';
        document.getElementById('dateTab').style.display = (tab === 'date') ? 'block' : 'none';
    }

    function updateDateLabel() {
        const format = d => ("0" + (d.getMonth() + 1)).slice(-2) + '.' + ("0" + d.getDate()).slice(-2);
        const nights = Math.max(1, Math.ceil((checkOut - checkIn) / (1000 * 60 * 60 * 24)));
        dateLabel.textContent = format(checkIn) + "~" + format(checkOut) + ", " + nights + "박";
    }

    function updatePersonLabel() {
        const adultNum = Number(adult);
        const childNum = Number(child);
        personLabel.textContent = `성인 ${adultNum}명, 아동 ${childNum}명`;
    }

    function changePerson(type, delta) {
        if (type === 'adult') {
            adult = Math.max(0, adult + delta); // ✅ 전역 adult 갱신
            document.getElementById('adultCount').innerText = adult;
        } else {
            child = Math.max(0, child + delta); // ✅ 전역 child 갱신
            document.getElementById('childCount').innerText = child;
        }
    }


    function applyPerson() {
        updatePersonLabel();
        togglePopup('personPopup');
    }

    // ✅ 날짜 적용 버튼: 날짜 라벨 업데이트
    document.getElementById("dateApplyBtn").addEventListener("click", () => {
        updateDateLabel();
        togglePopup('searchPopup');
    });

    // ✅ 검색 버튼 클릭 시 POST 전송
    function submitSearch() {
        document.getElementById("districtInput").value = regionLabel.textContent;
        document.getElementById("checkInInput").value = checkIn.toISOString().slice(0, 10);  // "2025-06-19"
        document.getElementById("checkOutInput").value = checkOut.toISOString().slice(0, 10);
        document.getElementById("adultInput").value = adult;
        document.getElementById("babyInput").value = child;

        document.getElementById("searchForm").submit();
    }

    document.querySelectorAll(".region-main li").forEach(item => {
        item.addEventListener("click", () => {
            regionLabel.textContent = item.textContent;
            togglePopup('searchPopup');
        });
    });

    function generateCalendar(year, month) {
        const box = document.createElement("div");
        box.className = "calendar-box";

        const monthTitle = document.createElement("div");
        monthTitle.style.textAlign = "center";
        monthTitle.style.fontWeight = "bold";
        monthTitle.style.marginBottom = "8px";
        monthTitle.textContent = year + "." + ("0" + (month + 1)).slice(-2);
        box.appendChild(monthTitle);

        const table = document.createElement("table");
        const thead = document.createElement("thead");
        thead.innerHTML = '<tr><th>일</th><th>월</th><th>화</th><th>수</th><th>목</th><th>금</th><th>토</th></tr>';
        table.appendChild(thead);

        const tbody = document.createElement("tbody");
        const firstDay = new Date(year, month, 1);
        const lastDay = new Date(year, month + 1, 0);
        const startWeek = firstDay.getDay();

        let date = 1;
        for (let i = 0; i < 6; i++) {
            const row = document.createElement("tr");
            for (let j = 0; j < 7; j++) {
                const cell = document.createElement("td");
                if (i === 0 && j < startWeek) {
                    cell.classList.add("disabled");
                } else if (date > lastDay.getDate()) {
                    cell.innerHTML = "";
                } else {
                    cell.textContent = date;
                    cell.classList.add("day");
                    const fullDate = new Date(year, month, date);
                    cell.dataset.date = fullDate.toISOString();
                    cell.addEventListener("click", () => handleDateClick(cell, fullDate));
                    date++;
                }
                row.appendChild(cell);
            }
            tbody.appendChild(row);
            if (date > lastDay.getDate()) break;
        }
        table.appendChild(tbody);
        box.appendChild(table);
        container.appendChild(box);
    }

    function handleDateClick(cell, dateObj) {
        const allCells = document.querySelectorAll(".calendar-box .day");
        allCells.forEach(c => c.classList.remove("checkin", "checkout", "selected"));

        if (!checkIn || (checkIn && checkOut)) {
            checkIn = dateObj;
            checkOut = null;
            cell.classList.add("checkin", "selected");
        } else if (checkIn && !checkOut && dateObj > checkIn) {
            checkOut = dateObj;
            allCells.forEach(c => {
                const d = new Date(c.dataset.date);
                if (d > checkIn && d < checkOut) c.classList.add("selected");
                if (+d === +checkIn) c.classList.add("checkin");
                if (+d === +checkOut) c.classList.add("checkout");
            });
        } else {
            checkIn = dateObj;
            checkOut = null;
            cell.classList.add("checkin", "selected");
        }
    }

    const today = new Date();
    generateCalendar(today.getFullYear(), today.getMonth());
    generateCalendar(today.getFullYear(), today.getMonth() + 1);

    function goToPage(pageNum) {
        document.getElementById("pageInput").value = pageNum;
        document.getElementById("searchForm").submit();
    }

</script>

</body>
</html>
