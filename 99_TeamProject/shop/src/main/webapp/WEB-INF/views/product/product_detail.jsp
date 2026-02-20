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

    /* ★ [추가] 바로결제 버튼 스타일 (강조: 검정) */
    .btn-buy-now { background: #111; color: #fff; padding: 18px; border: 1px solid #111; cursor: pointer; font-size: 14px; letter-spacing: 1px; transition: 0.3s; }
    .btn-buy-now:hover { background: #333; }

    /* 장바구니 버튼 스타일 (서브: 흰색으로 변경) */
    .btn-buy { background: #fff; color: #111; padding: 18px; border: 1px solid #111; cursor: pointer; font-size: 14px; letter-spacing: 1px; transition: 0.3s; }
    .btn-buy:hover { background: #f9f9f9; }

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

    <p class="price-text">
      KRW <fmt:formatNumber value="${product.price}" pattern="#,###"/>
    </p>

    <div class="desc-text">
      <%-- 5. 상품 설명 보안 처리 (white-space: pre-wrap 유지) --%>
      <c:out value="${product.description}" />
    </div>

    <div class="action-btns">
      <%-- ★ [추가] 바로결제 버튼 --%>
      <button type="button" class="btn-buy-now" onclick="buyNow('<c:out value="${product.productId}"/>')">BUY NOW</button>

      <%-- 기존 장바구니 버튼 (기능 유지) --%>
        <button type="button" class="btn-buy" onclick="addToCart('<c:out value="${product.productId}"/>')">ADD TO BAG</button>
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
  /* ★ [추가] 바로 구매 기능 */
  function buyNow(productId) {
    // 결제팀으로 상품번호와 수량(1개)을 GET 방식으로 전송
    const form = document.createElement('form');
    form.method = 'GET';
    form.action = '/order/form'; // 결제 폼 주소

    const idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'productId';
    idInput.value = productId;
    form.appendChild(idInput);

    const qtyInput = document.createElement('input');
    qtyInput.type = 'hidden';
    qtyInput.name = 'quantity';
    qtyInput.value = '1';
    form.appendChild(qtyInput);

    document.body.appendChild(form);
    form.submit();
  }

  /* 기존 기능 완벽 유지 */
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
  /* ★ [추가] 장바구니 담기 기능 */
  function addToCart(productId) {
    // 장바구니 컨트롤러로 상품번호와 수량(1개)을 POST 방식으로 전송
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/cart/add'; // ★ 장바구니 추가 폼 주소

    const idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'productId';
    idInput.value = productId;
    form.appendChild(idInput);

    const qtyInput = document.createElement('input');
    qtyInput.type = 'hidden';
    qtyInput.name = 'quantity';
    qtyInput.value = '1';
    form.appendChild(qtyInput);

    document.body.appendChild(form);
    form.submit();
  }
  /* ★ [수정됨] 장바구니 즉시 담기 (AJAX 연동) */
  function addToCart(productId) {
    // 1. fetch를 이용해 백그라운드로 상품번호와 수량(1개 고정)을 컨트롤러로 전송
    fetch('/cart/addAjax', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'productId=' + productId + '&quantity=1'
    })
            .then(response => response.json()) // 2. 백엔드에서 JSON 데이터를 받아옵니다 (status, cartCount)
            .then(data => {
              if (data.status === 'login') {
                if(confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
                  location.href = '/member/login';
                }
              } else if (data.status === 'success') {
                // 3. 성공 시: 토스트 메시지 띄우기
                if (typeof showToast === 'function') {
                  showToast('장바구니에 상품을 담았습니다.');
                }

                // 4. 성공 시: 헤더에 있는 뱃지 업데이트 함수 즉시 실행! (비서 역할)
                if (typeof updateCartBadgeCount === 'function') {
                  updateCartBadgeCount(data.cartCount);
                }
              }
            })
            .catch(err => {
              console.error(err);
              alert("서버 통신 중 오류가 발생했습니다.");
            });
  }
</script>

</body>
</html>