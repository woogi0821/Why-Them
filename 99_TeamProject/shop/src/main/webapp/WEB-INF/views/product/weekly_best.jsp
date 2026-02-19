<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | WEEKLY BEST</title>
    <link rel="stylesheet" href="/css/index.css">
    <style>
        /* 순위 배지 스타일 보완 */
        .product-card { position: relative; cursor: pointer; }
        .rank-badge {
            position: absolute;
            top: 10px;
            left: 10px;
            background-color: #000;
            color: #fff;
            padding: 5px 12px;
            font-weight: bold;
            font-size: 1.1rem;
            z-index: 10;
            border-radius: 2px;
        }
        /* 상품 정보 스타일 (기존 css에 없다면 추가) */
        .info-box { padding: 10px 0; text-align: center; }
        .info-box .name { font-weight: bold; margin-bottom: 5px; }
        .info-box .price { color: #555; }
    </style>
</head>
<body>
<div id="main-wrapper">

    <jsp:include page="/common/header.jsp" />

    <main id="content-body">
        <section class="weekly-best-section">
            <h2 id="main-title" class="stitle">
                <c:out value="${not empty categoryName ? categoryName : 'WEEKLY BEST'}" />
            </h2>

            <div id="grid-root" class="grid-container">
                <c:forEach var="item" items="${bestAllList}" varStatus="status">
                    <div class="product-card" onclick="location.href='/product/detail?productId=${item.productId}'">

                        <span class="rank-badge">${status.count}</span>

                        <div class="img-box">
                            <c:choose>
                                <c:when test="${not empty item.imageUrl}">
                                    <img src="${item.imageUrl}" alt="${item.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="/img/no-image.jpg" alt="No Image">
                                </c:otherwise>
                            </c:choose>
                        </div>

                        <div class="info-box">
                            <p class="brand">${item.brandName}</p>
                            <p class="name">${item.name}</p>
                            <p class="price">
                                ₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/>
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>
    </main>

    <jsp:include page="/common/footer.jsp" />

</div>

<script src="/js/data.js"></script>
<script src="/js/homepage.js"></script>
</body>
</html>