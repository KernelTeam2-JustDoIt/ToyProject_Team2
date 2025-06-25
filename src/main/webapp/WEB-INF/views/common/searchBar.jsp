<%@ page contentType="text/html;charset=UTF-8" language="java" %>

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
