<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | OFFICIAL STORE</title>
    <link rel="stylesheet" href="/css/index.css">
<%--    <style>--%>
<%--    .hero-banner {--%>
<%--    width: 100%;--%>
<%--    height: 600px; /* 시원하게 큰 높이 */--%>
<%--    background-image: url('/images/banner_main.png'); /* 고화질 이미지 필수 */--%>
<%--    background-size: cover;--%>
<%--    background-position: center;--%>
<%--    display: flex;--%>
<%--    align-items: center;--%>
<%--    justify-content: center;--%>
<%--    color: white;--%>
<%--    text-align: center;--%>
<%--    margin-bottom: 80px; /* 여백의 미 */--%>
<%--    }--%>
<%--    .hero-content h1 { font-size: 3rem; letter-spacing: 5px; font-weight: 300; }--%>
<%--    .hero-content p { font-size: 1.2rem; margin-top: 20px; letter-spacing: 2px; }--%>
<%--    </style>--%>

</head>
<body>
<div id="main-wrapper">

    <jsp:include page="/common/header.jsp" />

    <main id="content-body">
<%--        <section class="hero-banner">--%>
<%--            <div class="hero-content">--%>
<%--                <h1>2026 SPRING COLLECTION</h1>--%>
<%--                <p>Discover the new elegance.</p>--%>
<%--            </div>--%>
<%--        </section>--%>
        <section class="special-section">
            <h2 id="main-title" class="stitle">
                <c:out value="${not empty categoryName ? categoryName : 'COLLECTION'}" />
            </h2>
            <div id="grid-root" class="grid-container">
                <c:forEach var="item" items="${productList}">
                    <div class="product-card" onclick="location.href='/product/detail?productId=${item.productId}'">
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
                            <p class="name">${item.name}</p>
                            <p class="brand">${item.brandName}</p>
                            <p class="price">₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/></p>
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