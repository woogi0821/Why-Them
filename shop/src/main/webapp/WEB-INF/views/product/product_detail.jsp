<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <%-- 1. 타이틀 보안 처리 --%>
  <title><c:out value="${product.name}" /> - WHY THEM</title>
  <style>
    /* ... 기존 스타일 유지 ... */
    .detail-wrapper { max-width: 1100px; margin: 0 auto; padding: 60px 20px; display: flex; justify-content: space-between; }
    .image-section { width: 55%; }
    .image-section img { width: 100%; height: auto; display: block; border-radius: 2px; }
    .info-section { width: 38%; position: sticky; top: 50px; height: fit-content; }
    .brand-text { font-size: 13px; letter-spacing: 2px; color: #999; margin-bottom: 15px; text-transform: uppercase; }
    .title-text { font-size: 26px; font-weight: 300; margin-bottom: 25px; line-height: 1.4; color: #111; }
    .price-text { font-size: 18px; font-weight: 400; margin-bottom: 40px; color: #333; }
    .desc-text { font-size: 14px; line-height: 1.8; color: #666; margin-bottom: 50px; border-top: 1px solid #eee; padding-top: 30px; white-space: pre-wrap; }

    .action-btns { display: flex; flex-direction: column; gap: 12px; }
    .btn-buy { background: #111; color: #fff; padding: 18px; border: none; cursor: pointer; font-size: 14px; letter-spacing: 1px; transition: 0.3s; }
    .btn-buy:hover { background: #333; }

    .btn-cart {
      background: #fff; color: #111; padding: 18px; border: 1px solid #111;
      cursor: pointer; font-size: 14px; letter-spacing: 1px; transition: all 0.3s;
    }
    .btn-cart:hover { background: #f9f9f9; }

    .btn-cart.active { background: #111; color: #fff; border-color: #111; }

    #toast-msg {
      font-family: 'Noto Sans KR', sans-serif;
      position: fixed; bottom: 50px; left: 50%; transform: translateX(-50%);
      background: rgba(26, 26, 26, 0.95); color: #fff; padding: 12px 24px;
      border-radius: 30px; font-size: 13px; opacity: 0; transition: opacity 0.3s ease-in-out;
      z-index: 9999; letter-spacing: 1px; box-shadow: 0 4px 10px rgba(0,0,0,0.2);
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
        <%-- 2. 이미지 alt 속성 보안 처리 --%>
        <img src="${product.imageUrl}" alt="<c:out value='${product.name}' />">
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
      <%-- 5. 상품 설명 보안 처리 (white-space: pre-wrap 유지) --%>
      <c:out value="${product.description}" />
    </div>

    <div class="action-btns">
      <button type="button" class="btn-buy" onclick="alert('주문 페이지로 이동합니다.')">ADD TO BAG</button>

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

<script>
  function toggleDetailWish(productId) {
    fetch('/wishlist/toggle', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'productId=' + productId
    })
            .then(response => response.text())
            .then(result => {
              const btn = document.getElementById('btn-wish');

              if (result === 'login') {
                if(confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
                  location.href = '/member/login';
                }
              }
              else if (result === 'add') {
                btn.classList.add('active');
                btn.innerText = 'REMOVE FROM WISHLIST';
                showToast('위시리스트에 담았습니다.');
              }
              else if (result === 'remove') {
                btn.classList.remove('active');
                btn.innerText = 'ADD TO WISHLIST';
                showToast('위시리스트에서 삭제했습니다.');
              }
            })
            .catch(err => console.error(err));
  }

  function showToast(message) {
    let toast = document.getElementById('toast-msg');
    if (!toast) {
      toast = document.createElement('div');
      toast.id = 'toast-msg';
      document.body.appendChild(toast);
    }
    toast.innerText = message;
    toast.style.opacity = '1';
    setTimeout(() => { toast.style.opacity = '0'; }, 2000);
  }
</script>

</body>
</html>