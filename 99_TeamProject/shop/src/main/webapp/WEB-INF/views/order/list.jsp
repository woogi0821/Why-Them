<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/fmt" prefix="fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE - LIST</title>
    <link rel="stylesheet" href="/css/cart.css">
</head>
<body>
<jsp:include page="/common/header.jsp" />

<div class="cart-container">
    <h2 class="cart-title">ORDER LIST</h2>

    <c:if test="${empty payments}">
        <div id="empty-area">
            <p class="empty-msg">주문 내역이 없습니다.</p>
            <a href="/" class="btn-go-home">CONTINUE SHOPPING</a>
        </div>
    </c:if>

    <c:if test="${not empty payments}">
        <table class="cart-table">
            <colgroup>
                <col style="width: 5%;">  <col style="width: 15%;"> <col style="width: 15%;"> <col style="width: 15%;"> <col style="width: 15%;"></colgroup>
            <thead>
            <tr>
                <th>NO</th>
                <th>PRICE</th>
                <th>PAYMENT</th>
                <th>DATE</th>
                <th>STATUS</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${payments}">
                <tr>
                    <td>
                        <p class="name">${item.orderId}</p>
                    </td>
                    <td>
                        <p class="name"><fmt:formatNumber value="${item.amount}" pattern="#,###"/></p>
                    </td>
                    <td>
                        <c:choose>
                            <c:when test="${item.paymentMethod == 'K'}">카카오페이</c:when>
                            <c:when test="${item.paymentMethod == 'N'}">네이버페이</c:when>
                            <c:when test="${item.paymentMethod == 'C'}">신용/체크카드</c:when>
                            <c:when test="${item.paymentMethod == '0'}"> </c:when>
                            <c:otherwise>기타</c:otherwise>
                        </c:choose>
                    </td>
                    <td class="status-info">
                        <p class="name">${item.paidAt}</p>
                    </td>
                    <td class="status-info">
                        <c:choose>
                            <c:when test="${item.status == 'READY'}">
                                <a href="${pageContext.request.contextPath}/order/${item.orderId}/confirm" class="btn-checkout">결제대기</a>
                            </c:when>
                            <c:when test="${item.status == 'PAID'}">결제완료</c:when>
                            <c:otherwise>기타</c:otherwise>
                        </c:choose>
                    </td>
                </tr>
            </c:forEach>
            </tbody>
        </table>

        <div class="cart-footer">
            <a href="/" class="btn-go-home">홈으로</a>
        </div>
    </c:if>
</div>

</body>
</html>