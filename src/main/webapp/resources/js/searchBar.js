// 초기 인원 수 설정
let adult = 2;
let child = 0;

// 팝업 열고 닫기
function togglePopup(id) {
    const popup = document.getElementById(id);
    popup.style.display = (popup.style.display === 'flex') ? 'none' : 'flex';
}

// 지역/날짜 탭 전환
function showTab(tab) {
    document.getElementById('regionTab').style.display = (tab === 'region') ? 'block' : 'none';
    document.getElementById('dateTab').style.display = (tab === 'date') ? 'block' : 'none';
}

// 인원 수 변경
function changePerson(type, delta) {
    if (type === 'adult') {
        adult = Math.max(0, adult + delta);
        document.getElementById('adultCount').innerText = adult;
    } else {
        child = Math.max(0, child + delta);
        document.getElementById('childCount').innerText = child;
    }
}

// 인원 수 라벨 갱신
function updatePersonLabel() {
    document.getElementById('person-label').textContent = `성인 ${adult}명, 아동 ${child}명`;
}

// 적용 버튼 클릭 시
function applyPerson() {
    updatePersonLabel();
    togglePopup('personPopup');
}

// 지역 선택 시 라벨 변경
document.addEventListener("DOMContentLoaded", () => {
    document.querySelectorAll(".region-main li").forEach(item => {
        item.addEventListener("click", () => {
            document.getElementById("region-label").textContent = item.textContent;
            togglePopup('searchPopup');
        });
    });

    updatePersonLabel(); // 페이지 로딩 시 인원 초기화 라벨 표시
});

// 검색 버튼 클릭 시 hidden input 세팅 후 submit
function submitSearch() {
    const form = document.getElementById("searchForm");

    document.getElementById("districtInput").value = document.getElementById("region-label").textContent;
    document.getElementById("adultInput").value = adult;
    document.getElementById("babyInput").value = child;

    form.submit();
}
