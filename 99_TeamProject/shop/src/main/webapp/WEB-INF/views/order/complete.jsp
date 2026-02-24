<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>
<html lang="ko">
<head>
    <meta charset="UTF-8"/>
    <title>Payment Complete</title>
    <link rel="stylesheet" href="/css/order.css">
</head>
<body>
<jsp:include page="/common/header.jsp"/>

<div class="page">
    <div class="steps">
        <span>주문 확인</span>
        <span>결제 정보</span>
        <span class="active">완료</span>
    </div>

    <div class="complete-box">
        <div class="check-icon">✓</div>
        <h1>결제가 완료되었습니다 🎉</h1>
        <div class="sub-text">
            주문이 정상적으로 접수되었습니다.<br/>
            이용해주셔서 감사합니다.
        </div>

        <div class="order-summary">
            <div class="summary-row">
                <span>주문번호</span>
                <span>${orderId}</span>
            </div>
            <div class="summary-row">
                <span>결제 수단</span>
                <span>
                    ${paymentMethod == 'K' ? '카카오페이' :
                      paymentMethod == 'N' ? '네이버페이' :
                      paymentMethod == 'C'  ? '신용/체크카드':'기타'}
                </span>
            </div>
            <div class="summary-row">
                <span>총 결제 금액</span>
                <span><fmt:formatNumber value="${amount}" pattern="#,###"/></span>
            </div>
        </div>

        <div class="btn-group">
            <a href="/" class="btn btn-primary">홈으로 이동</a>
            <a href="/order/list" class="btn btn-outline">주문내역 보기</a>
        </div>
    </div>
</div>

</body>
</html>

