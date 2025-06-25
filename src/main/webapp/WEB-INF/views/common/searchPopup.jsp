<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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

