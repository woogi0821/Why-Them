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
                    <%-- data-unit-price : 수량 변경 시 JS에서 단가 기준으로 재계산 --%>
                    <tr class="${item.status == 'STOP' ? 'item-stopped' : ''}"
                        data-cart-item-id="${item.cartItemId}"
                        data-unit-price="${item.price}">

                        <td>
                            <c:choose>
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
                                    <c:if test="${item.status == 'STOP'}">
                                        <span class="stop-badge">SOLD OUT</span>
                                    </c:if>
                                    <p class="brand" style="font-size:11px; color:#888; margin-bottom:5px;">${item.brandName}</p>
                                    <p class="name" style="font-weight:500;">${item.productName}</p>
                                </div>
                            </div>
                        </td>

                        <td>
                            <c:choose>
                                <%-- 판매 중지 상품은 수량 버튼 비활성화 --%>
                                <c:when test="${item.status == 'STOP'}">
                                    <div class="qty-control">
                                        <button type="button" disabled>-</button>
                                        <input type="text" value="${item.quantity}" readonly class="qty-input">
                                        <button type="button" disabled>+</button>
                                    </div>
                                </c:when>
                                <c:otherwise>
                                    <div class="qty-control">
                                        <button type="button" class="btn-qty-minus"
                                                data-cart-item-id="${item.cartItemId}">-</button>
                                        <input type="text" value="${item.quantity}" readonly class="qty-input"
                                               data-cart-item-id="${item.cartItemId}">
                                        <button type="button" class="btn-qty-plus"
                                                data-cart-item-id="${item.cartItemId}">+</button>
                                    </div>
                                </c:otherwise>
                            </c:choose>
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
                        <span id="subtotalDisplay"><fmt:formatNumber value="${totalPrice}" pattern="#,###"/> KRW</span>
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

<%-- 삭제 전용 폼 --%>
<form action="/cart/remove" method="post" id="removeForm">
    <input type="hidden" name="cartItemId" id="removeTargetId">
</form>

<script>
    /* ===========================
     * 1. 수량 변경 (AJAX)
     * =========================== */
    function updateQuantityAjax(cartItemId, newQty) {
        fetch('/cart/updateAjax', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'cartItemId=' + cartItemId + '&quantity=' + newQty
        })
        .then(res => res.json())
        .then(data => {
            if (data.status !== 'success') {
                alert('수량 변경에 실패했습니다. 다시 시도해주세요.');
            }
        })
        .catch(() => alert('서버 오류가 발생했습니다.'));
    }

    /* 수량 - 버튼 */
    document.querySelectorAll('.btn-qty-minus').forEach(btn => {
        btn.addEventListener('click', function () {
            const cartItemId = this.dataset.cartItemId;
            const row = this.closest('tr');
            const qtyInput = row.querySelector('.qty-input');
            let qty = parseInt(qtyInput.value);

            if (qty <= 1) {
                if (!confirm('수량이 1개입니다. 상품을 삭제하시겠습니까?')) return;
                removeCartItem(cartItemId);
                return;
            }

            qty--;
            qtyInput.value = qty;
            updateRowPrice(row, qty);
            updateQuantityAjax(cartItemId, qty);
            updateTotalPrice();
        });
    });

    /* 수량 + 버튼 */
    document.querySelectorAll('.btn-qty-plus').forEach(btn => {
        btn.addEventListener('click', function () {
            const cartItemId = this.dataset.cartItemId;
            const row = this.closest('tr');
            const qtyInput = row.querySelector('.qty-input');
            let qty = parseInt(qtyInput.value);

            if (qty >= 99) {
                alert('최대 99개까지 담을 수 있습니다.');
                return;
            }

            qty++;
            qtyInput.value = qty;
            updateRowPrice(row, qty);
            updateQuantityAjax(cartItemId, qty);
            updateTotalPrice();
        });
    });

    /* 행 금액 업데이트 */
    function updateRowPrice(row, qty) {
        const unitPrice = parseInt(row.dataset.unitPrice);
        const total = unitPrice * qty;
        const priceEl = row.querySelector('.item-price');
        priceEl.dataset.price = total;
        priceEl.textContent = total.toLocaleString('ko-KR') + ' KRW';
    }

    /* ===========================
     * 2. 총 금액 계산
     * =========================== */
    function updateTotalPrice() {
        const checkedItems = document.querySelectorAll('.item-check:checked');
        let total = 0;

        checkedItems.forEach(cb => {
            const row = cb.closest('tr');
            const priceEl = row.querySelector('.item-price');
            total += parseInt(priceEl.dataset.price);
        });

        const formatted = total.toLocaleString('ko-KR') + ' KRW';
        document.getElementById('totalPriceDisplay').innerText = formatted;
        document.getElementById('subtotalDisplay').innerText = formatted;
        document.getElementById('totalPriceInput').value = total;
    }

    /* ===========================
     * 3. 전체 선택 / 해제
     * =========================== */
    const checkAll = document.getElementById('checkAll');
    if (checkAll) {
        checkAll.addEventListener('change', function () {
            document.querySelectorAll('.item-check:not(:disabled)')
                    .forEach(cb => cb.checked = this.checked);
            updateTotalPrice();
        });
    }

    /* 개별 체크박스 변경 이벤트 */
    document.querySelectorAll('.item-check').forEach(cb => {
        cb.addEventListener('change', function () {
            /* 전체 선택 체크박스 상태 동기화 */
            const allEnabled = document.querySelectorAll('.item-check:not(:disabled)');
            const allChecked = document.querySelectorAll('.item-check:not(:disabled):checked');
            checkAll.checked = (allEnabled.length === allChecked.length);
            updateTotalPrice();
        });
    });

    /* ===========================
     * 4. 개별 삭제
     * =========================== */
    function removeCartItem(cartItemId) {
        if (confirm('이 상품을 장바구니에서 삭제하시겠습니까?')) {
            document.getElementById('removeTargetId').value = cartItemId;
            document.getElementById('removeForm').submit();
        }
    }

    /* ===========================
     * 5. 선택 항목 주문
     * =========================== */
    function selectedItemsOrder() {
        if (!document.querySelector('.item-check:checked')) {
            alert('주문할 상품을 선택해주세요!');
            return;
        }
        if (confirm('선택하신 상품을 주문하시겠습니까?')) {
            document.getElementById('orderForm').submit();
        }
    }

    /* ===========================
     * 6. 초기 로딩 시 금액 동기화
     * =========================== */
    window.addEventListener('DOMContentLoaded', updateTotalPrice);
</script>

</body>
</html>
