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
    <%-- 가격 표시 섹션 --%>
    <div class="price-text">
      <c:choose>
        <%-- 프로모션 정보가 존재하고 진행 중일 때 --%>
        <c:when test="${not empty product.promotion}">
          <div style="display: flex; align-items: baseline; gap: 10px;">
              <%-- 정가 (취소선) --%>
            <span style="text-decoration: line-through; color: #bbb; font-size: 15px;">
          KRW <fmt:formatNumber value="${product.price}" pattern="#,###"/>
        </span>
              <%-- 할인가 (강조) --%>
            <span style="color: #d9534f; font-weight: 500; font-size: 22px;">
          KRW <fmt:formatNumber value="${product.salePrice}" pattern="#,###"/>
        </span>
          </div>
          <%-- 이벤트 태그 --%>
          <div style="font-size: 12px; color: #d9534f; margin-top: 5px; font-weight: 400; letter-spacing: 1px;">
  <span style="border: 1px solid #d9534f; padding: 2px 6px; border-radius: 2px; text-transform: uppercase;">
    <c:choose>
      <%-- 할인 타입이 퍼센트(RATE/PERCENT)인 경우 제목 뒤에 % 수치까지 표시 --%>
      <c:when test="${product.promotion.discountType == 'PERCENT' || product.promotion.discountType == 'RATE'}">
        <c:out value="${product.promotion.promotionTitle}"/> <c:out value="${product.promotion.discountValue}"/>%
      </c:when>
      <%-- 그 외(AMOUNT - 정액 할인)인 경우 제목만 표시 (예: 5,000원 즉시 할인) --%>
      <c:otherwise>
        <c:out value="${product.promotion.promotionTitle}"/>
      </c:otherwise>
    </c:choose>
  </span>
          </div>
        </c:when>

        <%-- 프로모션이 없을 때 --%>
        <c:otherwise>
      <span style="font-size: 20px; font-weight: 400;">
        KRW <fmt:formatNumber value="${product.price}" pattern="#,###"/>
      </span>
        </c:otherwise>
      </c:choose>
    </div>

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