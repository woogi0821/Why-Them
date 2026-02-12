<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | OFFICIAL STORE</title>
    <link rel="stylesheet" href="/css/index.css">
    <link rel="icon" type="image/png" href="/images/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="/images/favicon.svg" />
    <link rel="shortcut icon" href="/images/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/images/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="LALA BOUTIQUE" />
    <link rel="manifest" href="/images/site.webmanifest" />
    <style>
        /* 메인 배너 스타일 */
        .hero-banner {
            width: 100%;
            height: 600px; /* 시원하게 큰 높이 */
            background-image: url('/images/banner_main.png'); /* 고화질 이미지 필수 */
            background-size: cover;
            background-position: center;
            display: flex;
            align-items: center;
            justify-content: center;
            color: white;
            text-align: center;
            margin-bottom: 80px; /* 여백의 미 */
        }
        .hero-content h1 { font-size: 3rem; letter-spacing: 5px; font-weight: 300; }
        .hero-content p { font-size: 1.2rem; margin-top: 20px; letter-spacing: 2px; }

        /* 섹션 스타일 */
        .curation-section { margin-bottom: 100px; padding: 0 50px; }
        .section-header {
            display: flex;
            justify-content: space-between;
            align-items: flex-end;
            margin-bottom: 30px;
            border-bottom: 1px solid #ddd; /* 얇은 선으로 정돈 */
            padding-bottom: 15px;
        }
        .section-title { font-size: 1.8rem; font-weight: 400; letter-spacing: 2px; }
        .view-more { color: #555; text-decoration: none; font-size: 0.9rem; }

        /* 그리드 (기존 유지하되 간격 조정) */
        .grid-container {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개씩 깔끔하게 */
            gap: 40px 20px;
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
</body>
</html>