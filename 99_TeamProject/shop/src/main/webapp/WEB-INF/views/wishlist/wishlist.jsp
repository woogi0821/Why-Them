<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>MY WISHLIST | LALA BOUTIQUE</title>

    <link rel="icon" type="image/png" href="/images/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="/images/favicon.svg" />
    <link rel="shortcut icon" href="/images/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/images/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="LALA BOUTIQUE" />
    <link rel="manifest" href="/images/site.webmanifest" />

    <style>
        /* === 위시리스트 전용 스타일 === */
        .wish-wrapper {
            max-width: 1200px;
            margin: 0 auto;
            padding: 80px 20px 120px;
            min-height: 600px;
        }

        /* 1. 페이지 타이틀 & 상단 요약 */
        .page-header {
            text-align: center;
            margin-bottom: 60px;
            position: relative;
        }
        .page-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 42px;
            letter-spacing: 3px;
            font-weight: 500;
            color: #1a1a1a;
            margin-bottom: 20px;
        }

        /* 총 금액 박스 */
        .summary-box {
            display: inline-block;
            background-color: #f9f9f9;
            padding: 15px 40px;
            border-radius: 50px;
            font-size: 14px;
            color: #555;
            font-family: 'Noto Sans KR', sans-serif;
        }
        .summary-box strong {
            color: #1a1a1a;
            font-weight: 700;
            font-size: 18px;
            margin-left: 10px;
            font-family: 'Cormorant Garamond', serif; /* 숫자 강조 */
        }

        /* 전체 삭제 버튼 (오른쪽 상단 배치) */
        .top-actions {
            display: flex;
            justify-content: flex-end;
            margin-bottom: 20px;
            border-bottom: 1px solid #eee;
            padding-bottom: 10px;
        }
        .btn-delete-all {
            background: #fff;
            border: 1px solid #ddd;
            color: #888;
            padding: 8px 15px;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s;
            font-family: 'Noto Sans KR';
        }
        .btn-delete-all:hover {
            border-color: #1a1a1a;
            color: #1a1a1a;
            background: #fff;
        }

        /* 2. 상품 리스트 그리드 (카드형) */
        .wish-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개 */
            gap: 40px 20px;
        }

        .wish-item {
            position: relative;
            text-align: left;
        }

        /* 이미지 영역 */
        .img-box {
            position: relative;
            width: 100%;
            height: 350px; /* 세로로 긴 이미지 비율 유지 */
            overflow: hidden;
            background-color: #f4f4f4;
            margin-bottom: 15px;
        }
        .img-box img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: transform 0.5s ease;
        }
        .wish-item:hover .img-box img {
            transform: scale(1.05); /* 호버 시 살짝 확대 */
        }

        /* 개별 삭제 버튼 (X) */
        .btn-remove {
            position: absolute;
            top: 10px;
            right: 10px;
            background: rgba(255, 255, 255, 0.8);
            border: none;
            width: 30px; height: 30px;
            font-size: 16px;
            color: #1a1a1a;
            cursor: pointer;
            z-index: 10;
            display: flex;
            align-items: center;
            justify-content: center;
            transition: background 0.3s;
        }
        .btn-remove:hover {
            background: #1a1a1a;
            color: #fff;
        }

        /* 상품 정보 */
        .item-info h4 {
            font-size: 14px;
            font-weight: 400;
            margin-bottom: 5px;
            color: #333;
            overflow: hidden;
            text-overflow: ellipsis;
            white-space: nowrap;
        }
        .item-info .price {
            font-size: 15px;
            font-weight: 600;
            color: #1a1a1a;
            font-family: 'Cormorant Garamond', serif;
        }

        /* 장바구니 버튼 */
        .btn-cart {
            width: 100%;
            padding: 10px;
            margin-top: 15px;
            background: #1a1a1a;
            color: #fff;
            border: 1px solid #1a1a1a;
            font-size: 12px;
            cursor: pointer;
            transition: all 0.3s;
            opacity: 0; /* 평소엔 숨김 */
            transform: translateY(10px);
        }
        .wish-item:hover .btn-cart {
            opacity: 1; /* 호버 시 등장 */
            transform: translateY(0);
        }
        .btn-cart:hover {
            background: #fff;
            color: #1a1a1a;
        }

        /* 텅 비었을 때 */
        .empty-state {
            text-align: center;
            padding: 100px 0;
            grid-column: 1 / -1; /* 전체 너비 차지 */
        }
        .empty-state p {
            color: #999;
            font-size: 15px;
            margin-bottom: 20px;
        }
        .btn-go-shop {
            display: inline-block;
            padding: 12px 30px;
            border: 1px solid #1a1a1a;
            color: #1a1a1a;
            text-decoration: none;
            font-size: 13px;
            transition: all 0.3s;
        }
        .btn-go-shop:hover {
            background: #1a1a1a;
            color: #fff;
        }

        /* 반응형 */
        @media (max-width: 1024px) {
            .wish-grid { grid-template-columns: repeat(3, 1fr); }
        }
        @media (max-width: 768px) {
            .wish-grid { grid-template-columns: repeat(2, 1fr); gap: 20px 10px; }
            .img-box { height: 250px; }
            .btn-cart { opacity: 1; transform: translateY(0); margin-top: 10px; } /* 모바일은 항상 보임 */
        }
    </style>
</head>
<body>

<jsp:include page="/common/header.jsp" /> <div class="wish-wrapper">
    <header class="page-header">
        <h2 class="page-title">WISH LIST</h2>

        <c:if test="${not empty wishlist}">
            <div class="summary-box">
                TOTAL ESTIMATED VALUE
                <strong><fmt:formatNumber value="${totalPrice}" /> KRW</strong>
            </div>
        </c:if>
    </header>

    <c:if test="${not empty wishlist}">
        <div class="top-actions">
            <button type="button" class="btn-delete-all" onclick="removeAllItems()">CLEAR ALL ITEMS</button>
        </div>
    </c:if>

    <div class="wish-grid">
        <c:choose>
            <%-- 1. 위시리스트가 비었을 때 --%>
            <c:when test="${empty wishlist}">
                <div class="empty-state">
                    <p>위시리스트에 담긴 상품이 없습니다.</p>
                    <a href="/" class="btn-go-shop">START SHOPPING</a>
                </div>
            </c:when>

            <%-- 2. 상품 리스트 반복 출력 --%>
            <c:otherwise>
                <c:forEach var="item" items="${wishlist}">
                    <div class="wish-item" id="wish-item-${item.wishId}">
                        <button type="button" class="btn-remove" onclick="removeOneItem(${item.wishId})" title="삭제">
                            &times;
                        </button>

                        <div class="img-box">
                            <a href="/product/detail?id=${item.productId}">
                                <img src="${empty item.imageUrl ? '/images/no_img.png' : item.imageUrl}" alt="${item.productName}">
                            </a>
                        </div>

                        <div class="item-info">
                            <a href="/product/detail?id=${item.productId}" style="text-decoration:none;">
                                <h4>${item.productName}</h4>
                            </a>
                            <div class="price"><fmt:formatNumber value="${item.price}" /></div>
                        </div>

                        <button type="button" class="btn-cart" onclick="addToCart(${item.productId})">
                            ADD TO CART
                        </button>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

<script>
    /* 1. 개별 삭제 (AJAX) */
    function removeOneItem(wishId) {
        if (!confirm('이 상품을 위시리스트에서 삭제하시겠습니까?')) return;

        fetch('/wishlist/remove', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'wishId=' + wishId
        })
            .then(response => response.text())
            .then(data => {
                if (data === 'ok') {
                    // 화면에서 해당 아이템 즉시 제거 (새로고침 없이)
                    const item = document.getElementById('wish-item-' + wishId);
                    if (item) item.remove();

                    // 아이템이 하나도 없으면 새로고침해서 '텅 빔' 상태 보여주기
                    if (document.querySelectorAll('.wish-item').length === 0) {
                        location.reload();
                    }
                } else {
                    alert('삭제에 실패했습니다. 다시 시도해주세요.');
                }
            })
            .catch(err => console.error(err));
    }

    /* 2. 전체 삭제 (AJAX) */
    function removeAllItems() {
        if (!confirm('정말 모든 상품을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) return;

        fetch('/wishlist/removeAll', {
            method: 'POST'
        })
            .then(response => response.text())
            .then(data => {
                if (data === 'ok') {
                    alert('위시리스트가 초기화되었습니다.');
                    location.reload(); // 깔끔하게 새로고침
                } else {
                    alert('전체 삭제에 실패했습니다.');
                }
            })
            .catch(err => console.error(err));
    }

    /* 3. 장바구니 담기 (예시 기능) */
    function addToCart(productId) {
        // 장바구니 컨트롤러가 있다면 연결
        /*
        fetch('/cart/add', { ... })
        .then(...)
        */
        alert('장바구니 기능은 아직 연결되지 않았습니다.\n(상품 ID: ' + productId + ')');
    }
</script>

</body>
</html>