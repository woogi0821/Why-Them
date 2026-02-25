<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE - CART</title>
    <link rel="stylesheet" href="/css/cart_list.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="cart-container">
    <h2 class="cart-title">SHOPPING BAG</h2>

    <c:if test="${empty cartList}">
        <div id="empty-area">
            <p class="empty-msg">장바구니에 담긴 상품이 없습니다.</p>
            <a href="/" class="btn-go-home">CONTINUE SHOPPING</a>
        </div>
    </c:if>

    <c:if test="${not empty cartList}">
        <form id="orderForm" name="orderForm" action="${pageContext.request.contextPath}/order/cartConfirm" method="post">

            <table class="cart-table">
                <colgroup>
                    <col style="width: 5%;"> <col style="width: 50%;"> <col style="width: 15%;"> <col style="width: 15%;"> <col style="width: 10%;">
                </colgroup>
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll" checked></th>
                    <th>PRODUCT</th>
                    <th>QTY</th>
                    <th>PRICE</th>
                    <th>DELETE</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${cartList}" varStatus="status">
                    <tr class="${item.status == 'STOP' ? 'item-stopped' : ''}">
                        <td>
                            <c:choose>
                                <%-- 🚩 수정: 판매 중지 상품은 체크박스 비활성화 및 name 제거 --%>
                                <c:when test="${item.status == 'STOP'}">
                                    <input type="checkbox" class="item-check" disabled>
                                </c:when>
                                <c:otherwise>
                                    <input type="checkbox" name="cartItemIds" value="${item.cartItemId}" class="item-check" checked>
                                </c:otherwise>
                            </c:choose>
                        </td>

                        <td>
                            <div class="item-info">
                                <c:choose>
                                    <c:when test="${not empty item.imageUrl}">
                                        <img src="${item.imageUrl}" alt="${item.productName}">
                                    </c:when>
                                    <c:otherwise>
                                        <div style="width:80px; height:100px; background:#eee;"></div>
                                    </c:otherwise>
                                </c:choose>

                                <div class="text-wrap">
                                        <%-- 🚩 수정: 판매 중지 배지 표시 --%>
                                    <c:if test="${item.status == 'STOP'}">
                                        <span class="stop-badge">SOLD OUT</span>
                                    </c:if>
                                    <p class="brand" style="font-size:11px; color:#888; margin-bottom:5px;">${item.brandName}</p>
                                    <p class="name" style="font-weight:500;">${item.productName}</p>
                                </div>
                            </div>
                        </td>

                        <td>
                            <div class="qty-control">
                                <button type="button" onclick="alert('수량 변경 기능은 준비중입니다.')">-</button>
                                <input type="text" value="${item.quantity}" readonly>
                                <button type="button" onclick="alert('수량 변경 기능은 준비중입니다.')">+</button>
                            </div>
                        </td>

                        <td class="price-col">
                            <span class="item-price" data-price="${item.price * item.quantity}">
                                <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> KRW
                            </span>
                        </td>

                        <td>
                            <button type="button" class="btn-del-sm" onclick="removeCartItem(${item.cartItemId})">✕</button>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <div class="cart-footer">
                <div class="total-summary">
                    <div class="summary-row">
                        <span>SUBTOTAL</span>
                        <span><fmt:formatNumber value="${totalPrice}" pattern="#,###"/> KRW</span>
                    </div>
                    <div class="summary-row">
                        <span>SHIPPING</span>
                        <span>FREE</span>
                    </div>
                    <div class="summary-row total">
                        <span>TOTAL</span>
                        <span id="totalPriceDisplay" style="font-family: 'Cormorant Garamond';">
                            <fmt:formatNumber value="${totalPrice}" pattern="#,###"/> KRW
                        </span>
                    </div>
                </div>
                <input type="hidden" id="totalPriceInput" name="totalPrice" value="${totalPrice}">
                <button type="button" class="btn-checkout" onclick="selectedItemsOrder()">CHECKOUT</button>
            </div>

        </form>
    </c:if>
</div>

<jsp:include page="/common/footer.jsp" />

<form action="/cart/remove" method="post" id="removeForm">
    <input type="hidden" name="cartItemId" id="removeTargetId">
</form>

<script src="${pageContext.request.contextPath}/js/cart_list.js"></script>

</body>
</html>