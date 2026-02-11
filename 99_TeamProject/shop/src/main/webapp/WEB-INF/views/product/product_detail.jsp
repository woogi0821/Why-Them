<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${product.name} - WHY THEM</title>
  <style>
    /* 상세페이지 레이아웃 */
    .detail-wrapper {
      max-width: 1100px;
      margin: 0 auto;
      padding: 60px 20px;
      display: flex;
      justify-content: space-between;
    }

    /* 왼쪽: 상품 이미지 */
    .image-section {
      width: 55%;
    }
    .image-section img {
      width: 100%;
      height: auto;
      display: block;
      border-radius: 2px;
    }

    /* 오른쪽: 상품 정보 */
    .info-section {
      width: 38%;
      position: sticky; /* 스크롤 시 정보창 고정 효과 */
      top: 50px;
      height: fit-content;
    }

    .brand-text {
      font-size: 13px;
      letter-spacing: 2px;
      color: #999;
      margin-bottom: 15px;
      text-transform: uppercase;
    }

    .title-text {
      font-size: 26px;
      font-weight: 300;
      margin-bottom: 25px;
      line-height: 1.4;
      color: #111;
    }

    .price-text {
      font-size: 18px;
      font-weight: 400;
      margin-bottom: 40px;
      color: #333;
    }

    .desc-text {
      font-size: 14px;
      line-height: 1.8;
      color: #666;
      margin-bottom: 50px;
      border-top: 1px solid #eee;
      padding-top: 30px;
      white-space: pre-wrap; /* 줄바꿈 적용 */
    }

    /* 버튼 디자인 */
    .action-btns {
      display: flex;
      flex-direction: column;
      gap: 12px;
    }
    .btn-buy {
      background: #111;
      color: #fff;
      padding: 18px;
      border: none;
      cursor: pointer;
      font-size: 14px;
      letter-spacing: 1px;
      transition: 0.3s;
    }
    .btn-buy:hover { background: #333; }

    .btn-cart {
      background: #fff;
      color: #111;
      padding: 18px;
      border: 1px solid #111;
      cursor: pointer;
      font-size: 14px;
      letter-spacing: 1px;
    }

    @media (max-width: 850px) {
      .detail-wrapper { flex-direction: column; }
      .image-section, .info-section { width: 100%; }
      .info-section { margin-top: 40px; }
    }
  </style>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="detail-wrapper">
  <div class="image-section">
    <c:choose>
      <c:when test="${not empty product.imageUrl}">
        <img src="${product.imageUrl}" alt="상품 이미지">
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
        <c:when test="${product.categoryId == 2}">SHIRT</c:when>
        <c:when test="${product.categoryId == 3}">SWEATER</c:when>
        <c:when test="${product.categoryId == 4}">PANTS</c:when>
        <c:when test="${product.categoryId == 5}">SKIRTS</c:when>
        <c:when test="${product.categoryId == 6}">DRESS</c:when>
        <c:when test="${product.categoryId == 7}">SUIT</c:when>
        <c:when test="${product.categoryId == 8}">SHOSES</c:when>
        <c:when test="${product.categoryId == 9}">SANDALS</c:when>
        <c:when test="${product.categoryId == 10}">BAG</c:when>
        <c:when test="${product.categoryId == 11}">HAT</c:when>
        <c:otherwise>ACCESSORY</c:otherwise>
      </c:choose>
    </p>
    <h1 class="title-text">${product.name}</h1>

    <p class="price-text">
      KRW <fmt:formatNumber value="${product.price}" pattern="#,###"/>
    </p>

    <div class="desc-text">
      ${product.description}
    </div>

    <div class="action-btns">
      <button type="button" class="btn-buy" onclick="alert('주문 페이지로 이동합니다.')">ADD TO BAG</button>
      <button type="button" class="btn-cart">WISH LIST</button>
    </div>
  </div>
</div>

</body>
</html>