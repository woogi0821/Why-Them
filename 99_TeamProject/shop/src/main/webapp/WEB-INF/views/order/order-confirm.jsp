<%--
  Created by IntelliJ IDEA.
  User: user
  Date: 26. 2. 19.
  Time: 오전 10:56
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <meta charset="UTF-8" />
    <title>Order Confirm</title>
    <style>
        * {
            box-sizing: border-box;
            font-family: "Inter", "Noto Sans KR", sans-serif;
        }

        body {
            margin: 0;
            background: #f1f3f6;
            color: #222;
        }

        .page {
            max-width: 900px;
            margin: 0 auto;
            padding: 40px 20px 100px;
        }

        .steps {
            display: flex;
            justify-content: center;
            gap: 30px;
            margin-bottom: 30px;
            font-size: 14px;
            color: #aaa;
        }

        .steps .active {
            color: #111;
            font-weight: 700;
        }

        h1 {
            font-size: 24px;
            margin-bottom: 20px;
        }

        .section {
            background: #fff;
            border-radius: 8px;
            padding: 20px;
            margin-bottom: 20px;
            border: 1px solid #e5e7eb;
        }

        .section-title {
            font-size: 16px;
            font-weight: 700;
            margin-bottom: 15px;
            border-left: 4px solid #4f46e5;
            padding-left: 8px;
        }

        /* 상품 */
        .product-row {
            display: flex;
            gap: 20px;
            padding: 15px 0;
            border-bottom: 1px solid #eee;
        }

        .product-row:last-child {
            border-bottom: none;
        }

        .product-img {
            width: 80px;
            height: 80px;
            background: #ddd;
            border-radius: 6px;
        }

        .product-info {
            flex: 1;
        }

        .product-name {
            font-size: 15px;
            font-weight: 600;
            margin-bottom: 6px;
        }

        .product-option {
            font-size: 13px;
            color: #666;
            margin-bottom: 6px;
        }

        .product-price {
            font-size: 15px;
            font-weight: 700;
        }

        /* 배송 */
        .shipping-info p {
            margin: 4px 0;
            font-size: 14px;
            color: #444;
        }

        /* 결제 요약 */
        .summary-row {
            display: flex;
            justify-content: space-between;
            margin-bottom: 10px;
            font-size: 14px;
        }

        .summary-total {
            display: flex;
            justify-content: space-between;
            margin-top: 15px;
            padding-top: 15px;
            border-top: 1px solid #ddd;
            font-size: 18px;
            font-weight: 700;
            color: #111;
        }

        .payment-box {
            position: fixed;
            left: 0;
            right: 0;
            bottom: 0;
            background: #fff;
            border-top: 1px solid #ddd;
            padding: 15px 20px;
        }

        .payment-inner {
            max-width: 900px;
            margin: 0 auto;
            display: flex;
            justify-content: space-between;
            align-items: center;
        }

        .pay-total {
            font-size: 18px;
            font-weight: 700;
        }

        .order-btn {
            padding: 14px 28px;
            background: #4f46e5;
            border: none;
            border-radius: 6px;
            color: #fff;
            font-size: 15px;
            font-weight: 600;
            cursor: pointer;
        }

        .order-btn:hover {
            background: #4338ca;
        }

        @media (max-width: 768px) {
            .page {
                padding-bottom: 120px;
            }
            .product-row {
                flex-direction: column;
            }
        }

    </style>
</head>
<body>

<div class="page">

    <div class="steps">
        <span class="active">주문 확인</span>
        <span>결제 정보</span>
        <span>완료</span>
    </div>

    <h1>주문/결제</h1>

    <!-- 상품 정보 -->
    <div class="section">
        <div class="section-title">주문 상품 정보</div>

        <div class="product-row">
            <div class="product-img"></div>
            <div class="product-info">
                <div class="product-name">베이직 반팔 티셔츠</div>
                <div class="product-option">화이트 / M</div>
                <div class="product-price">₩25,000</div>
            </div>
        </div>

        <div class="product-row">
            <div class="product-img"></div>
            <div class="product-info">
                <div class="product-name">데님 팬츠</div>
                <div class="product-option">블루 / 30</div>
                <div class="product-price">₩28,000</div>
            </div>
        </div>
    </div>

    <!-- 배송 정보 -->
    <div class="section">
        <div class="section-title">배송지 정보</div>
        <div class="shipping-info">
            <p><strong>홍길동</strong></p>
            <p>010-1234-5678</p>
            <p>서울특별시 강남구 테헤란로 123</p>
            <p>요청사항: 경비실에 맡겨주세요</p>
        </div>
    </div>

    <!-- 결제 금액 -->
    <div class="section">
        <div class="section-title">결제 금액</div>

        <div class="summary-row">
            <span>상품 금액</span>
            <span>₩53,000</span>
        </div>

        <div class="summary-row">
            <span>배송비</span>
            <span>₩0</span>
        </div>

        <div class="summary-total">
            <span>총 결제 예정 금액</span>
            <span>₩53,000</span>
        </div>
    </div>

</div>

<!-- 하단 결제 영역 -->
<div class="payment-box">
    <div class="payment-inner">
        <div class="pay-total">₩53,000</div>
        <button class="order-btn">결제 진행</button>
    </div>
</div>

</body>
</html>
