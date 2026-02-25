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
    <link rel="stylesheet" href="/css/wishlist_main.css">
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

<script src="${pageContext.request.contextPath}/js/wishlist_main.js"></script>

</body>
</html>