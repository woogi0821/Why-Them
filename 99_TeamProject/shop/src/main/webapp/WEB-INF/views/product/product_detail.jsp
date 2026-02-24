<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <%-- 1. 타이틀 보안 처리 --%>
  <title><c:out value="${product.name}" /> - WHY THEM</title>
  <link rel="stylesheet" href="/css/product_detail.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="detail-wrapper">
  <div class="image-section">
    <c:choose>
      <c:when test="${not empty product.imageUrl}">

        <img src="<c:out value='${product.imageUrl}'/>" alt="<c:out value='${product.name}'/>">

      </c:when>
      <c:otherwise>
        <div style="width:100%; height:500px; background:#f4f4f4; display:flex; align-items:center; justify-content:center; color:#ccc;">
          No Image
        </div>
      </c:otherwise>
    </c:choose>
  </div>

  <div class="info-section">
    <p class="brand-text">
      <c:choose>
        <c:when test="${product.categoryId == 1}">COAT</c:when>
        <c:otherwise>ACCESSORY</c:otherwise>
      </c:choose>
    </p>

    <%-- 3. 상품명 보안 처리 --%>
    <h1 class="title-text"><c:out value="${product.name}" /></h1>

    <%-- 4. 조회수 표시 (추가 요청하신 부분) --%>
    <p style="font-size: 12px; color: #999; margin-bottom: 15px;">
      VIEWS <c:out value="${product.viewCount}" default="0" />
    </p>

    <p class="price-text">
      KRW <fmt:formatNumber value="${product.price}" pattern="#,###"/>
    </p>

    <div class="desc-text">
      <c:out value="${product.description}" />
    </div>

    <div class="action-btns">
      <button type="button" class="btn-buy-now" onclick="buyNow('<c:out value="${product.productId}"/>')">BUY NOW</button>
      <button type="button" class="btn-bag" onclick="addToCart('<c:out value="${product.productId}"/>')">ADD TO BAG</button>

      <%-- 6. 위시리스트 버튼 내 ID 값 및 상태 텍스트 처리 --%>
      <button type="button" id="btn-wish"
              class="btn-cart ${isWished ? 'active' : ''}"
              onclick="toggleDetailWish('<c:out value="${product.productId}"/>')">
        <c:choose>
          <c:when test="${isWished}">REMOVE FROM WISHLIST</c:when>
          <c:otherwise>ADD TO WISHLIST</c:otherwise>
        </c:choose>
      </button>
    </div>
  </div>
</div>
<script src="/js/product_detail.js"></script>

</body>
</html>