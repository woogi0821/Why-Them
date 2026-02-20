<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <title>Order Confirm</title>
    <link rel="stylesheet" href="/css/confirm.css">
</head>
<body>
<jsp:include page="/common/header.jsp"/>
<div class="page">
    <div class="steps">
        <span class="active">주문 확인</span>
        <span>결제 정보</span>
        <span>완료</span>
    </div>

    <div class="section">
        <div class="section-title">주문 상품 정보</div>
        <input type="hidden" name="orderId" value="<c:out value="${orderId}"/>" >
        <c:forEach var="item" items="${orderItems}">
            <div class="product-row">
                <div class="product-img"></div>
                <div class="product-info">
                    <div class="product-name"><c:out value="${item.productName}"/></div>
                    <div class="product-option">수량: <c:out value="${item.quantity}"/></div>
                    <div class="product-price">
                        ₩ <fmt:formatNumber value="${item.price * item.quantity}" pattern="#,###"/>
                    </div>
                </div>
            </div>
        </c:forEach>
    </div>

    <div class="section">
        <div class="section-title">배송지 정보</div>
        <div class="shipping-info">
            <p><strong><c:out value="${memberInfo.recipientName}"/></strong></p>
            <p><c:out value="${memberInfo.recipientPhone}"/></p>
            <p><c:out value="${memberInfo.fullAddress}"/></p>
        </div>
    </div>

    <div class="section">
        <div class="section-title">결제 금액</div>
        <div class="summary-row">
            <span>상품 금액</span>
            <span>₩ <fmt:formatNumber value="${totalPrice}" pattern="#,###"/></span>
        </div>
        <div class="summary-row">
            <span>배송비</span>
            <span>₩0</span>
        </div>
        <div class="summary-total">
            <span>총 결제 예정 금액</span>
            <span>₩ <fmt:formatNumber value="${totalPrice}" pattern="#,###"/></span>
        </div>
    </div>
</div>

<div class="payment-box">
    <div class="payment-inner">
        <button class="order-btn" onclick="fn_payment()">결제 진행</button>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
    function fn_payment() {
        var orderId = $("input[name='orderId']").val();
        if (!orderId) {
            alert("주문 정보가 없습니다.");
            return;
        }
        // payment 페이지로 이동
        window.location.href = "/order/" + orderId + "/payment";
    }
</script>

</body>
</html>
