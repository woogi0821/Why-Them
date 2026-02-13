<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | OFFICIAL STORE</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/index.css">
    <link rel="icon" type="image/png" href="/images/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="/images/favicon.svg" />
    <link rel="shortcut icon" href="/images/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/images/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="LALA BOUTIQUE" />
    <link rel="manifest" href="/images/site.webmanifest" />

    <style>
        /* [추가된 CSS] 하트 버튼 스타일링 */
        .product-card {
            position: relative; /* 하트 버튼의 기준점 */
            cursor: pointer;
        }

        .btn-wish-icon {
            position: absolute;
            top: 15px;
            right: 15px;
            z-index: 20; /* 이미지보다 위에 떠야 함 */
            font-size: 24px;
            color: #ccc; /* 기본: 빈 하트(회색) */
            background: rgba(255, 255, 255, 0.3); /* 배경 살짝 깔아서 잘 보이게 */
            border: none;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-wish-icon:hover {
            transform: scale(1.1);
            background: rgba(255, 255, 255, 0.8);
        }

        /* 찜 된 상태 (빨간 하트) */
        .btn-wish-icon.active {
            color: #e74c3c;
        }
    </style>
</head>
<body>
<div id="main-wrapper">

    <jsp:include page="/common/header.jsp" />

    <main id="content-body">

        <section class="hero-banner">
            <div class="hero-content">
                <h1>2026 SPRING COLLECTION</h1>
                <p>Discover the new elegance.</p>
            </div>
        </section>

        <section class="curation-section">
            <div class="section-header">
                <h2 class="section-title">NEW ARRIVALS</h2>
                <a href="/product/list?sort=new" class="view-more">VIEW ALL +</a>
            </div>

            <div class="grid-container">
                <c:forEach var="item" items="${productList}" begin="0" end="3">
                    <div class="product-card" onclick="location.href='/product/detail?productId=${item.productId}'">

                        <button type="button" class="btn-wish-icon ${item.wished ? 'active' : ''}"
                                onclick="toggleWishList(event, '${item.productId}', this)">
                            ♥
                        </button>

                        <div class="img-box">
                            <img src="${not empty item.imageUrl ? item.imageUrl : '/img/no-image.jpg'}" alt="${item.name}">
                        </div>
                        <div class="info-box">
                            <p class="brand">${item.brandName}</p>
                            <p class="name">${item.name}</p>
                            <p class="price">₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <section class="curation-section">
            <div class="section-header">
                <h2 class="section-title">WEEKLY BEST</h2>
                <a href="/product/list?sort=best" class="view-more">VIEW ALL +</a>
            </div>

            <div class="grid-container">
                <c:forEach var="item" items="${productList}" begin="4" end="7">
                    <div class="product-card" onclick="location.href='/product/detail?productId=${item.productId}'">

                        <button type="button" class="btn-wish-icon ${item.wished ? 'active' : ''}"
                                onclick="toggleWishList(event, '${item.productId}', this)">
                            ♥
                        </button>

                        <div class="img-box">
                            <img src="${not empty item.imageUrl ? item.imageUrl : '/img/no-image.jpg'}" alt="${item.name}">
                        </div>
                        <div class="info-box">
                            <p class="brand">${item.brandName}</p>
                            <p class="name">${item.name}</p>
                            <p class="price">₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

    </main>

    <jsp:include page="/common/footer.jsp" />

</div>

<script>
    function toggleWishList(event, productId, btnElement) {
        // [중요] 부모 요소(카드)의 클릭 이벤트(상세페이지 이동)를 막음
        event.stopPropagation();
        event.preventDefault();

        // AJAX 요청
        fetch('/wishlist/toggle', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'productId=' + productId
        })
            .then(response => response.text())
            .then(result => {
                if (result === 'login') {
                    if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')) {
                        location.href = '/member/login';
                    }
                }
                else if (result === 'add') {
                    btnElement.classList.add('active'); // 빨갛게
                    showToast('위시리스트에 담았습니다.');
                }
                else if (result === 'remove') {
                    btnElement.classList.remove('active'); // 회색으로
                    showToast('위시리스트에서 삭제했습니다.');
                }
            })
            .catch(err => {
                console.error(err);
                alert("서버 통신 중 오류가 발생했습니다.");
            });
    }

    // 토스트 메시지 생성 함수
    function showToast(message) {
        let toast = document.getElementById('toast-msg');
        if (!toast) {
            toast = document.createElement('div');
            toast.id = 'toast-msg';
            toast.style.cssText = `
                position: fixed; bottom: 50px; left: 50%; transform: translateX(-50%);
                background: rgba(0,0,0,0.8); color: #fff; padding: 12px 24px;
                border-radius: 30px; font-size: 14px; opacity: 0; transition: opacity 0.3s; z-index: 9999;
                font-family: 'Noto Sans KR', sans-serif;
            `;
            document.body.appendChild(toast);
        }
        toast.innerText = message;
        toast.style.opacity = '1';
        setTimeout(() => { toast.style.opacity = '0'; }, 2000);
    }
</script>

</body>
</html>