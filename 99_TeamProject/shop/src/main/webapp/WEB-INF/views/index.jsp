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

    </style>
</head>
<body>
<div id="main-wrapper">

    <jsp:include page="/common/header.jsp" />

    <%-- 중간 생략 (Header 등 동일) --%>

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
                <a href="/product/new/all" class="view-more">VIEW ALL +</a>
            </div>

            <div class="grid-container">
                <c:forEach var="item" items="${newList}" >
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
                <a href="/product/best/all" class="view-more">VIEW ALL +</a>
            </div>

            <div class="grid-container">
                <c:forEach var="item" items="${bestList}">
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

    <%-- 중간 생략 (Footer 등 동일) --%>

    <jsp:include page="/common/footer.jsp" />

</div>
</body>
</html>