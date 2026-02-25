<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
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

    .action-btns { display: flex; flex-direction: column; gap: 10px; } /* 버튼 간격 조정 */

    /* [수정] 버튼 스타일 구분 */
    .btn-buy {
      background: #111; color: #fff; padding: 18px; border: 1px solid #111;
      cursor: pointer; font-size: 14px; letter-spacing: 1px; transition: 0.3s; width: 100%;
    }
    .btn-buy:hover { background: #333; border-color: #333; }

    .btn-cart {
      background: #fff; color: #111; padding: 18px; border: 1px solid #ddd;
      cursor: pointer; font-size: 14px; letter-spacing: 1px; transition: all 0.3s; width: 100%;
    }
    .btn-cart:hover { border-color: #111; }

    .btn-cart.active { background: #111; color: #fff; border-color: #111; }

    /* 토스트 메시지 스타일 */

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

    <h1 class="title-text"><c:out value="${product.name}" /></h1>

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

    <%-- [수정] 가격 표시 섹션 : 할인가가 정가보다 저렴할 때만 SALE 표시 --%>
    <div class="price-text">
      <c:choose>
        <%-- 조건 강화: 프로모션이 있고 + 할인가가 0보다 크고 + ★할인가가 정가보다 작아야 함★ --%>
        <c:when test="${not empty product.promotion && product.salePrice > 0 && product.salePrice < product.price}">
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
                <c:when test="${product.promotion.discountType == 'PERCENT' || product.promotion.discountType == 'RATE'}">
                  <c:out value="${product.promotion.promotionTitle}"/> <c:out value="${product.promotion.discountValue}"/>%
                </c:when>
                <c:otherwise>
                  <c:out value="${product.promotion.promotionTitle}"/>
                </c:otherwise>
              </c:choose>
            </span>
          </div>
        </c:when>

        <%-- 그 외 (프로모션 없거나, 가격이 같거나, 기간 지남) -> 그냥 정가만 깔끔하게 출력 --%>
        <c:otherwise>
          <span style="font-size: 20px; font-weight: 400; color: #333;">
            KRW <fmt:formatNumber value="${product.price}" pattern="#,###"/>
          </span>
        </c:otherwise>
      </c:choose>
    </div>

    <div class="desc-text">
      <%-- 5. 상품 설명 보안 처리 (white-space: pre-wrap 유지) --%>
      <c:out value="${product.description}" />
    </div>
    <form name="orderForm" method="post">
      <input type="hidden" name="productId" value="${product.productId}">
      <input type="hidden" name="quantity" value="1">

      <div class="action-btns">
        <button type="button" class="btn-buy" onclick="buyNow()">BUY NOW</button>

        <button type="button" class="btn-cart" onclick="addToCart()">ADD TO BAG</button>

        <button type="button" id="btn-wish"
                class="btn-cart ${isWished ? 'active' : ''}"
                onclick="toggleDetailWish('<c:out value="${product.productId}"/>')">
          <c:choose>
            <c:when test="${isWished}">REMOVE FROM WISHLIST</c:when>
            <c:otherwise>ADD TO WISHLIST</c:otherwise>
          </c:choose>
        </button>
      </div>
    </form>

  </div>
</div>

<script>
  // [추가] 바로 구매 함수
  function buyNow() {
    // 로그인 체크가 필요하다면 여기서 JS로 확인하거나 Controller에서 처리
    const form = document.forms.orderForm;
    // OrderController의 바로구매 경로로 설정 (경로 확인 필요!)
    form.action = '/order/directConfirm';
    form.submit();
  }

  // [추가] 장바구니 담기 함수
  function addToCart() {
    const form = document.forms.orderForm;
    // CartController의 담기 경로로 설정
    form.action = '/cart/add';
    form.submit();
  }

  // [유지] 위시리스트 토글 함수

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
  // [유지] 토스트 메시지

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