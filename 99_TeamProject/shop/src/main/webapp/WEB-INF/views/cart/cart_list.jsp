<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE - CART</title>
    <link rel="stylesheet" href="/css/cart.css">
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

        <form action="/order/form" method="get" id="orderForm">

            <table class="cart-table">
                <colgroup>
                    <col style="width: 5%;">  <col style="width: 50%;"> <col style="width: 15%;"> <col style="width: 15%;"> <col style="width: 10%;"> </colgroup>
                <thead>
                <tr>
                    <th><input type="checkbox" id="checkAll" checked></th> <th>PRODUCT</th>
                    <th>QTY</th>
                    <th>PRICE</th>
                    <th>DELETE</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${cartList}" varStatus="status">
                    <tr>
                        <td>
                            <input type="checkbox" name="cartItemIds" value="${item.cartItemId}" class="item-check" checked>
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
                            <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/> KRW
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
                        <span>FREE</span> </div>
                    <div class="summary-row total">
                        <span>TOTAL</span>
                        <span style="font-family: 'Cormorant Garamond';">
                                <fmt:formatNumber value="${totalPrice}" pattern="#,###"/> KRW
                            </span>
                    </div>
                </div>

                <button type="submit" class="btn-checkout">CHECKOUT</button>
            </div>

        </form>
    </c:if>
</div>

<jsp:include page="/common/footer.jsp" />

<form action="/cart/remove" method="post" id="removeForm">
    <input type="hidden" name="cartItemId" id="removeTargetId">
</form>

<script>
    // 개별 삭제 스크립트
    function removeCartItem(cartItemId) {
        if(confirm('이 상품을 장바구니에서 삭제하시겠습니까?')) {
            document.getElementById('removeTargetId').value = cartItemId;
            document.getElementById('removeForm').submit();
        }
    }

    // 전체 선택/해제 스크립트 (UX용)
    const checkAll = document.getElementById('checkAll');
    if(checkAll) {
        checkAll.addEventListener('change', function() {
            const checkboxes = document.querySelectorAll('.item-check');
            checkboxes.forEach(cb => cb.checked = this.checked);
        });
    }
</script>

</body>
</html>