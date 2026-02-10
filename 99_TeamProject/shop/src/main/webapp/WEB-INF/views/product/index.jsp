<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>라라 부티크 | LALA BOUTIQUE</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400&family=Noto+Sans+KR:wght@100;300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body {
            background: #fff;
            font-family: 'Cormorant Garamond', serif;
            color: #111;
            -webkit-font-smoothing: antialiased;
        }

        /* 상단 유틸 */
        .top-utils {
            position: absolute;
            top: 35px;
            right: 60px;
            font-size: 10px;
            display: flex;
            gap: 35px;
            letter-spacing: 2px;
            color: #999;
            text-transform: uppercase;
            font-family: 'Noto Sans KR';
            z-index: 1001;
        }
        .top-utils span { cursor: pointer; }

        /* 헤더 */
        header {
            height: 160px;
            display: flex;
            justify-content: center;
            align-items: center;
            cursor: pointer;
        }
        .logo {
            font-size: 45px;
            letter-spacing: 25px;
            text-transform: uppercase;
            font-weight: 300;
            margin-right: -25px;
        }

        /* 네비게이션 */
        .nav-wrapper {
            position: sticky;
            top: 0;
            z-index: 1000;
            background: #fff;
            border-top: 1px solid #f2f2f2;
            border-bottom: 1px solid #f2f2f2;
        }

        .menu-bar {
            width: 100%;
            max-width: 1100px;
            margin: auto;
            height: 70px;
            display: flex;
            justify-content: space-around;
            align-items: center;
        }

        .menu-link {
            font-size: 13px;
            font-weight: 300;
            letter-spacing: 6px;
            color: #222;
            text-transform: uppercase;
            cursor: pointer;
            height: 100%;
            display: flex;
            align-items: center;
        }

        /* 풀 드롭다운 */
        .full-dropdown {
            display: none;
            position: absolute;
            top: 71px;
            left: 0;
            width: 100%;
            background: #fff;
            border-bottom: 1px solid #eee;
            padding: 40px 0 60px;
            box-shadow: 0 10px 20px rgba(0,0,0,0.02);
        }
        .nav-wrapper:hover .full-dropdown { display: block; }

        .drop-container {
            max-width: 1100px;
            margin: auto;
            display: flex;
            justify-content: space-around;
        }

        .drop-column { width: 120px; text-align: center; }

        .drop-link {
            font-size: 10px;
            color: #bbb;
            cursor: pointer;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 15px;
            display: block;
            transition: 0.3s;
        }
        .drop-link:hover { color: #000; }

        /* 메인 영역 */
        #main-area {
            min-height: 400px;
            padding: 120px 0;
            text-align: center;
        }
        #main-area h2 {
            font-weight: 300;
            letter-spacing: 15px;
            text-transform: uppercase;
            color: #ddd;
        }

        /* 푸터 */
        footer {
            padding: 100px 40px;
            border-top: 1px solid #eee;
            font-size: 10px;
            color: #ccc;
            text-align: center;
            letter-spacing: 2px;
        }

        .footer-del {
            position: absolute;
            bottom: 20px;
            right: 40px;
            font-size: 9px;
            color: #eee;
            cursor: pointer;
            text-decoration: none;
        }
        /* 상품 그리드 레이아웃 */
        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개씩 */
            gap: 60px 20px; /* 위아래 간격 60px, 좌우 20px */
            max-width: 1200px;
            margin: 80px auto;
            padding: 0 40px;
        }

        /* 상품 카드 */
        .p-card {
            cursor: pointer;
            transition: opacity 0.3s;
        }
        .p-card:hover {
            opacity: 0.7;
        }

        /* 이미지 박스 - 홈페이지와 동일한 비율 유지 */
        .img-wrap {
            width: 100%;
            aspect-ratio: 3 / 4; /* 세로가 약간 긴 비율 */
            background: #f9f9f9;
            overflow: hidden;
            margin-bottom: 20px;
        }
        .img-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover; /* 이미지가 꽉 차게 */
        }

        /* 상품 정보 텍스트 */
        .info-box {
            text-align: left; /* 홈페이지처럼 왼쪽 정렬 */
            padding: 0 5px;
        }
        .info-box .brand {
            font-size: 10px;
            color: #999;
            letter-spacing: 2px;
            text-transform: uppercase;
            margin-bottom: 8px;
            font-family: 'Noto Sans KR';
        }
        .info-box .name {
            font-size: 13px;
            color: #222;
            letter-spacing: 1px;
            margin-bottom: 10px;
            font-weight: 300;
        }
        .info-box .price {
            font-size: 12px;
            color: #111;
            letter-spacing: 1px;
            font-family: 'Noto Sans KR';
        }

        /* 반응형: 화면이 작아지면 2개씩 보이게 */
        @media (max-width: 900px) {
            .product-grid {
                grid-template-columns: repeat(2, 1fr);
            }
        }
        main {
            min-height: 500px;
            padding-bottom: 150px; /* 푸터와의 간격 */
        }

        .product-grid {
            display: grid;
            grid-template-columns: repeat(4, 1fr); /* 한 줄에 4개씩 */
            gap: 50px 30px;
        }

        .p-card { cursor: pointer; text-align: left; }

        .img-wrap {
            width: 100%;
            height: 400px; /* 이미지 높이 조절 */
            overflow: hidden;
            background: #f9f9f9;
            margin-bottom: 20px;
        }

        .img-wrap img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            transition: 0.6s;
        }

        .p-card:hover img { transform: scale(1.05); }

        .info-box .brand { font-size: 10px; color: #999; letter-spacing: 2px; text-transform: uppercase; }
        .info-box .name { font-size: 14px; margin: 8px 0; color: #222; font-weight: 300; font-family: 'Noto Sans KR'; }
        .info-box .price { font-size: 12px; font-weight: 400; letter-spacing: 1px; }
    </style>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<%--<div class="search-filter-section">--%>
<%--    <div class="filter-btns">--%>
<%--        <button onclick="location.href='?sort=new'" class="${param.sort == 'new' or empty param.sort ? 'active' : ''}">신상품순</button>--%>
<%--        <button onclick="location.href='?sort=low'" class="${param.sort == 'low' ? 'active' : ''}">가격 낮은 순</button>--%>
<%--        <button onclick="location.href='?sort=high'" class="${param.sort == 'high' ? 'active' : ''}">가격 높은 순</button>--%>
<%--    </div>--%>
<%--</div>--%>

<div class="nav-wrapper">
    <div class="menu-bar">
        <span class="menu-link">TOP</span>
        <span class="menu-link">BOTTOM</span>
        <span class="menu-link">SET</span>
        <span class="menu-link">SHOES</span>
        <span class="menu-link">ACC</span>
    </div>

    <div class="full-dropdown">
        <div class="drop-container">
            <div class="drop-column">
                <a href="/main?categoryId=1" class="drop-link ${selectedCategory == 1 ? 'active' : ''}">COAT</a>
                <a href="/main?categoryId=2" class="drop-link ${selectedCategory == 2 ? 'active' : ''}">SHIRTS</a>
                <a href="/main?categoryId=3" class="drop-link ${selectedCategory == 3 ? 'active' : ''}">SWEATER</a>
            </div>
            <div class="drop-column">
                <a href="/main?categoryId=4" class="drop-link ${selectedCategory == 4 ? 'active' : ''}">PANTS</a>
                <a href="/main?categoryId=5" class="drop-link ${selectedCategory == 5 ? 'active' : ''}">SKIRTS</a>
            </div>
            <div class="drop-column">
                <a href="/main?categoryId=6" class="drop-link ${selectedCategory == 6 ? 'active' : ''}">ONEPIECE</a>
                <a href="/main?categoryId=7" class="drop-link ${selectedCategory == 7 ? 'active' : ''}">SUIT</a>
            </div>
            <div class="drop-column">
                <a href="/main?categoryId=8" class="drop-link ${selectedCategory == 8 ? 'active' : ''}">DRESSSHOE</a>
                <a href="/main?categoryId=9" class="drop-link ${selectedCategory == 9 ? 'active' : ''}">SANDALS</a>
            </div>
            <div class="drop-column">
                <a href="/main?categoryId=10" class="drop-link ${selectedCategory == 10 ? 'active' : ''}">BAG</a>
                <a href="/main?categoryId=11" class="drop-link ${selectedCategory == 11 ? 'active' : ''}">HAT</a>
            </div>
        </div>
    </div>
</div>

<div class="product-grid" style="max-width: 1200px; margin: 0 auto; padding: 0 20px;">
    <c:forEach var="item" items="${productList}">
        <div class="p-card" onclick="location.href='/product/detail?productId=${item.productId}'">
            <div class="img-wrap">
                <c:choose>
                    <c:when test="${not empty item.imageUrl}">
                        <img src="${item.imageUrl}" alt="${item.name}">
                    </c:when>
                    <c:otherwise>
                        <img src="/img/no-image.jpg">
                    </c:otherwise>
                </c:choose>
            </div>
            <div class="info-box">
                <p class="brand">${item.brandName}</p>
                <p class="name">${item.name}</p>
                <p class="price">
                    <fmt:formatNumber value="${item.price}" pattern="#,###"/>원
                </p>
            </div>
        </div>
    </c:forEach>
</div>
</main>

<jsp:include page="/common/footer.jsp" />

</body>
</html>