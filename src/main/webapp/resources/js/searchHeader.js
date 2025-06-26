document.addEventListener("DOMContentLoaded", () => {
    const backButton = document.getElementById("back-button");
    const homeButton = document.getElementById("home-button");
    const cartButton = document.getElementById("cart-button");
    const searchButton = document.getElementById("search-button"); // 검색 버튼 (선택)
    const searchInput = document.getElementById("searchInput");   // 검색창

    if (backButton) {
        backButton.addEventListener("click", () => {
            history.back(); // 브라우저 뒤로가기
        });
    }

    if (homeButton) {
        homeButton.addEventListener("click", () => {
            window.location.href = "/"; // 홈페이지 경로
        });
    }

    if (cartButton) {
        cartButton.addEventListener("click", () => {
            window.location.href = "/cart"; // 장바구니 페이지 경로
        });
    }

    // ✅ 검색 함수 정의
    function doSearch() {
        const query = searchInput?.value;
        if (!query || !query.trim()) return;
        window.location.href = contextPath + `/domestic/hotel?keyword=` + encodeURIComponent(query);
    }

    // ✅ 버튼 클릭 시 검색
    if (searchButton) {
        searchButton.addEventListener("click", doSearch);
    }

    // ✅ 엔터키로 검색
    if (searchInput) {
        searchInput.addEventListener("keydown", function (e) {
            if (e.key === "Enter") {
                doSearch();
            }
        });
    }
});
