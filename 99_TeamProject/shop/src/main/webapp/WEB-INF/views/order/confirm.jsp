<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <title>Order Confirm</title>
    <link rel="stylesheet" href="/css/order.css">
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
                <div class="product-img">
                    <c:choose>
                        <c:when test="${not empty item.imageUrl}">
                            <img src="${item.imageUrl}" alt="${item.productName}">
                        </c:when>
                        <c:otherwise>
                            <div style="width:80px; height:100px; background:#eee;"></div>
                        </c:otherwise>
                    </c:choose>
                </div>
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
        <div class="section-header" style="display: flex; justify-content: space-between; align-items: center; margin-bottom: 10px;">
            <div class="section-title">배송지 정보</div>
            <button type="button" id="addrEditBtn" onclick="fn_toggleAddrEdit()">변경</button>
        </div>

        <div class="shipping-info">
            <div id="viewMode">
                <p><strong><span id="txtRecipientName"><c:out value="${memberInfo.recipientName}"/></span></strong></p>
                <p><span id="txtRecipientPhone"><c:out value="${memberInfo.recipientPhone}"/></span></p>
                <p><span id="txtFullAddress"><c:out value="${memberInfo.fullAddress}"/></span></p>
            </div>

            <div id="editMode" style="display: none;">
                <p><input type="text" id="iptRecipientName" value="${memberInfo.recipientName}" style="width: 100%; margin-bottom: 5px;"></p>
                <p><input type="text" id="iptRecipientPhone" value="${memberInfo.recipientPhone}" style="width: 100%; margin-bottom: 5px;"></p>
                <p class="address-row">
                    <input type="text" id="iptFullAddress" value="${memberInfo.fullAddress}" placeholder="주소를 검색하세요">
                    <button type="button" class="lala-btn-outline" onclick="execDaumPostcode()">SEARCH</button>
                </p>
            </div>
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
<script src="/js/order_confirm.js"></script>

</body>
</html>
