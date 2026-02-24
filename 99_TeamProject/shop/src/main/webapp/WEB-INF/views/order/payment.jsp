<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <title>Payment</title>
    <link rel="stylesheet" href="/css/order.css">
</head>
<body>
<jsp:include page="/common/header.jsp"/>
<form method="post" action="${pageContext.request.contextPath}/order/${orderId}/payment">
    <div class="page">
        <div class="steps">
            <span>주문 확인</span>
            <span class="active">결제 정보</span>
            <span>완료</span>
        </div>

        <div class="section">
            <div class="section-title">결제 수단 선택</div>
            <input type="hidden" name="orderId" value="<c:out value="${orderId}"/>" >
            <div class="payment-method">
                <label class="method-item">
                    <input type="radio" name="payment" value="K" checked onclick="toggleCard(false)">
                    <span class="method-label">카카오페이</span>
                </label>

                <label class="method-item">
                    <input type="radio" name="payment" value="N" onclick="toggleCard(false)">
                    <span class="method-label">네이버페이</span>
                </label>

                <label class="method-item">
                    <input type="radio" name="payment" value="C" onclick="toggleCard(true)">
                    <span class="method-label">신용/체크카드</span>
                </label>

                <div class="card-info" id="cardInfo">
                    <input type="text" placeholder="카드 번호 (0000-0000-0000-0000)">
                    <div class="card-row">
                        <input type="text" placeholder="MM/YY">
                        <input type="text" placeholder="CVC">
                    </div>
                    <input type="text" placeholder="카드 소유자 이름">
                </div>
            </div>
        </div>
    </div>

    <div class="payment-box">
        <div class="payment-inner">
            <button class="order-btn">결제하기</button>
        </div>
    </div>
</form>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
    function toggleCard(show) {
        const cardInfo = document.getElementById("cardInfo");
        cardInfo.style.display = show ? "flex" : "none";
    }
</script>

</body>
</html>
