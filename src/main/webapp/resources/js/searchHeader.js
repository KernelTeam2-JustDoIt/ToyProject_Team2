// searchHeader.js

document.addEventListener("DOMContentLoaded", () => {
    const backButton = document.getElementById("back-button");
    const homeButton = document.getElementById("home-button");
    const cartButton = document.getElementById("cart-button");

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
});
