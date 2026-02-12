<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | OFFICIAL STORE</title>
    <link rel="stylesheet" href="/css/index.css">
</head>
<body>
<div id="main-wrapper">

    <jsp:include page="/common/header.jsp" />

    <main id="content-body">
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