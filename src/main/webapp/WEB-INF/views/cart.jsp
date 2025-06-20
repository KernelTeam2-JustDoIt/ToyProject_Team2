<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>장바구니</title>
    <style>
        * { box-sizing: border-box; margin: 0; padding: 0; }
        body { font-family: sans-serif; background: #f5f5f5; color: #333; }
        .header {
            display: flex;
            align-items: center;
            padding: 16px;
            background: #fff;
            border-bottom: 1px solid #ddd;
        }
        .header .back, .header .home {
            width: 24px; height: 24px;
            background-size: contain;
            cursor: pointer;
        }
        .header .back { background-image: url('data:image/svg+xml;base64,...'); }
        .header .home { margin-left: auto; background-image: url('data:image/svg+xml;base64,...'); }
        .header h1 { flex: 1; text-align: center; font-size: 18px; }

        .tabs {
            display: flex;
            background: #fff;
            border-bottom: 1px solid #ddd;
        }
        .tabs li {
            flex: 1;
            text-align: center;
            padding: 12px 0;
            list-style: none;
            cursor: pointer;
        }
        .tabs li.active { font-weight: bold; border-bottom: 2px solid #000; }

        .cart-container {
            margin: 16px;
        }
        .select-all {
            display: flex;
            align-items: center;
            margin-bottom: 8px;
        }
        .select-all input { margin-right: 8px; }
        .select-all span { margin-left: auto; color: #888; cursor: pointer; }

        .cart-item {
            background: #fff;
            display: flex;
            padding: 16px;
            margin-bottom: 12px;
            border-radius: 4px;
            position: relative;
        }
        .cart-item input { margin-right: 12px; }
        .cart-item img {
            width: 80px; height: 80px;
            border-radius: 4px;
            object-fit: cover;
            margin-right: 12px;
        }
        .item-info {
            flex: 1;
            font-size: 14px;
        }
        .item-info .title { font-weight: bold; margin-bottom: 4px; }
        .item-info .dates { color: #555; margin: 4px 0; }
        .item-info .details { color: #888; font-size: 12px; }
        .item-price {
            font-size: 16px;
            font-weight: bold;
            color: #d33;
            text-align: right;
            white-space: nowrap;
        }
        .cart-item .remove {
            position: absolute;
            top: 8px; right: 8px;
            font-size: 16px; cursor: pointer;
            color: #aaa;
        }

        .summary {
            background: #fff;
            padding: 16px;
            border-radius: 4px;
            font-size: 14px;
            margin: 0 16px 80px;
        }
        .summary .line {
            display: flex;
            justify-content: space-between;
            margin-bottom: 8px;
        }
        .summary .total {
            font-weight: bold;
            font-size: 16px;
        }
        .summary .note {
            font-size: 12px;
            color: #666;
            margin-top: 8px;
        }

        .btn-buy {
            position: fixed;
            bottom: 0; left: 0; right: 0;
            background: #ccc;
            color: #fff;
            text-align: center;
            padding: 16px;
            font-size: 16px;
            cursor: not-allowed;
        }
    </style>
</head>
<body>

<header class="header">
    <div class="back" title="뒤로가기"></div>
    <h1>장바구니</h1>
    <div class="home" title="홈"></div>
</header>

<ul class="tabs">
    <li class="active">전체(1)</li>
    <li>국내숙소(1)</li>
    <li>레저/티켓(0)</li>
    <li>교통(0)</li>
</ul>

<div class="cart-container">
    <div class="select-all">
        <label><input type="checkbox"> 전체 선택 (0/1)</label>
        <span>선택 삭제</span>
    </div>

    <div class="cart-item">
        <input type="checkbox" checked>
        <img src="https://via.placeholder.com/80" alt="서머셋 팰리스">
        <div class="item-info">
            <div class="title">서머셋 팰리스</div>
            <div class="dates">2025.06.23 (월) – 2025.06.27 (금) · 4박</div>
            <div class="details">
                체크인 15:00 | 체크아웃 12:00<br>
                기준 2명 / 최대 3명
            </div>
        </div>
        <div class="item-price">
            727,680원<br>
            <span style="font-size:12px; color:#888;">취소 및 환불규정</span>
        </div>
        <div class="remove" title="삭제">×</div>
    </div>

    <div class="summary">
        <div class="line"><span>상품 금액</span><span>0원</span></div>
        <div class="line"><span>할인 금액</span><span>-0원</span></div>
        <div class="line total"><span>결제 예정 금액</span><span>0원</span></div>
        <div class="note">NOL 카드 결제 시, 10% 적립</div>
        <div class="note">
            • 장바구니에 담은 상품은 최대 30일간 보관되고 최대 20개까지 담을 수 있습니다.<br>
            • 장바구니에서 수량 및 상세 옵션을 수정할 수 없는 상품도 있습니다. 삭제 후 다시 담아주세요.<br>
            • 쿠폰 및 포인트가 적용된 최종 결제 금액은 다를 수 있으므로 예약완료에서 확인해 주세요.
        </div>
    </div>
</div>

<div class="accommodation-list">
    <c:forEach var="cart" items="${cartList}">
        <div class="accommodation-card">

            <div class="info">
                <div class="name">${cart.cartId}</div>
                <div class="name">${cart.roomId}</div>

            </div>
        </div>
    </c:forEach>
</div>

<div class="btn-buy">구매하기</div>

</body>
</html>