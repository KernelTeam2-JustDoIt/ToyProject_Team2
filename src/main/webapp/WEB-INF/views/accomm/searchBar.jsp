<%@ page contentType="text/html;charset=UTF-8" language="java" %>

<div class="search-bar">
  <div class="search-options-row">
    <div class="search-option" onclick="togglePopup('searchPopup'); showTab('region')">
      <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTEyIDJDOC4xMzQgMiA1IDUuMTM0IDUgOUM1IDEwLjg4NSA1LjQxMSAxMi41MzQgNi4xNTUgMTMuODY3TDEyIDIyTDE3Ljg0NSAxMy44NjdDMTguNTg5IDEyLjUzNCAxOSAxMC44ODUgMTkgOUMxOSA1LjEzNCAxNS44NjYgMiAxMiAyWiIgc3Ryb2tlPSIjNjY2IiBzdHJva2Utd2lkdGg9IjIiIGZpbGw9Im5vbmUiLz4KPGNpcmNsZSBjeD0iMTIiIGN5PSI5IiByPSIzIiBzdHJva2U9IiM2NjYiIHN0cm9rZS13aWR0aD0iMiIgZmlsbD0ibm9uZSIvPgo8L3N2Zz4K" alt="위치" style="width: 16px; height: 16px;">
      <span id="region-label">강남/역삼/삼성</span>
    </div>
    <div class="search-option" onclick="togglePopup('searchPopup'); showTab('date')">
      <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHJlY3QgeD0iMyIgeT0iNCIgd2lkdGg9IjE4IiBoZWlnaHQ9IjE4IiByeD0iMiIgcnk9IjIiIHN0cm9rZT0iIzY2NiIgc3Ryb2tlLXdpZHRoPSIyIiBmaWxsPSJub25lIi8+CjxsaW5lIHgxPSIxNiIgeTE9IjIiIHgyPSIxNiIgeTI9IjYiIHN0cm9rZT0iIzY2NiIgc3Ryb2tlLXdpZHRoPSIyIi8+CjxsaW5lIHgxPSI4IiB5MT0iMiIgeDI9IjgiIHkyPSI2IiBzdHJva2U9IiM2NjYiIHN0cm9rZS13aWR0aD0iMiIvPgo8bGluZSB4MT0iMyIgeTE9IjEwIiB4Mj0iMjEiIHkyPSIxMCIgc3Ryb2tlPSIjNjY2IiBzdHJva2Utd2lkdGg9IjIiLz4KPC9zdmc+Cg==" alt="달력" style="width: 16px; height: 16px;">
      <span id="date-label">06.27~06.28, 1박</span>
    </div>
    <div class="search-option" onclick="togglePopup('personPopup')">
      <img src="data:image/svg+xml;base64,PHN2ZyB3aWR0aD0iMjQiIGhlaWdodD0iMjQiIHZpZXdCb3g9IjAgMCAyNCAyNCIgZmlsbD0ibm9uZSIgeG1sbnM9Imh0dHA6Ly93d3cudzMub3JnLzIwMDAvc3ZnIj4KPHBhdGggZD0iTTIwIDIxVjE5QzIwIDE3Ljg5NTQgMTkuMTA0NiAxNyAxOCAxN0g2QzQuODk1NDMgMTcgNCAxNy44OTU0IDQgMTlWMjEiIHN0cm9rZT0iIzY2NiIgc3Ryb2tlLXdpZHRoPSIyIiBzdHJva2UtbGluZWNhcD0icm91bmQiIHN0cm9rZS1saW5lam9pbj0icm91bmQiLz4KPGNpcmNsZSBjeD0iMTIiIGN5PSI3IiByPSI0IiBzdHJva2U9IiM2NjYiIHN0cm9rZS13aWR0aD0iMiIgc3Ryb2tlLWxpbmVjYXA9InJvdW5kIiBzdHJva2UtbGluZWpvaW49InJvdW5kIi8+Cjwvc3ZnPgo=" alt="인원" style="width: 16px; height: 16px;">
      <span id="person-label">성인 2명, 아동 0명</span>
    </div>
  </div>
  <div class="search-button-row">
    <button type="submit" class="search-submit-btn" onclick="submitSearch()">검색</button>
  </div>
</div>
