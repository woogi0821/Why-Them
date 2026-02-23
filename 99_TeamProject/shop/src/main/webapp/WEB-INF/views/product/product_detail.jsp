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

    /* 위시리스트 버튼 스타일 */
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
    .action-btns { display: flex; flex-direction: column; gap: 12px; }

    /* 1. 바로 구매 버튼 (강조 - 검정) */
    .btn-buy-now {
      background: #111; color: #fff; padding: 18px; border: 1px solid #111;
      cursor: pointer; font-size: 14px; letter-spacing: 1px; transition: 0.3s;
    }
    .btn-buy-now:hover { background: #333; }

    /* 2. 장바구니 / 3. 위시리스트 버튼 (서브 - 흰색) */
    .btn-cart, .btn-bag {
      background: #fff; color: #111; padding: 18px; border: 1px solid #111;
      cursor: pointer; font-size: 14px; letter-spacing: 1px; transition: all 0.3s;
    }
    .btn-cart:hover, .btn-bag:hover { background: #f9f9f9; }

    /* 찜 완료 상태 스타일 (검정 배경) */
    .btn-cart.active { background: #111; color: #fff; border-color: #111; }

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

<script>
  /* ★ [복구됨] 장바구니 즉시 담기 (AJAX 연동 - 화면 깜빡임 없이 뱃지 갱신) */
  function addToCart(productId) {
    fetch('/cart/addAjax', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'productId=' + productId + '&quantity=1'
    })
    .then(response => response.json())
    .then(data => {
      if (data.status === 'login') {
        if(confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
          location.href = '/member/login';
        }
      } else if (data.status === 'success') {
        showToast('장바구니에 상품을 담았습니다.');
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

  /* ★ [복구됨] 찜하기 토글 (헤더 N 뱃지 연동 포함) */
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
        
        // 헤더 N 뱃지 연동
        if (typeof showWishNewBadge === 'function') {
            showWishNewBadge();
        }
      }
      else if (result === 'remove') {
        btn.classList.remove('active');
        btn.innerText = 'ADD TO WISHLIST';
        showToast('위시리스트에서 삭제했습니다.');
      }
    })
    .catch(err => {
      console.error(err);
    });
  }

  /* 토스트 메시지 출력 함수 (중복 선언 및 에러 제거 완료) */
  function showToast(message) {
    let toast = document.getElementById('toast-msg');
    if (!toast) {
      toast = document.createElement('div');
      toast.id = 'toast-msg';
      toast.style.cssText = `
          position: fixed; bottom: 50px; left: 50%; transform: translateX(-50%);
          background: rgba(0,0,0,0.8); color: #fff; padding: 12px 24px;
          border-radius: 30px; font-size: 14px; opacity: 0; transition: opacity 0.3s; z-index: 9999;
          font-family: 'Noto Sans KR', sans-serif;
      `;
      document.body.appendChild(toast);
    }
    toast.innerText = message;
    toast.style.opacity = '1';

    setTimeout(() => { toast.style.opacity = '0'; }, 2000);
  }

  /* 바로 구매 기능 */
  /* ★ [완벽 수정] 바로 구매 기능 (컨트롤러 매핑 완료) */
  function buyNow(productId) {
    if (!confirm("해당 상품을 바로 구매하시겠습니까?")) {
      return;
    }

    var form = document.createElement('form');
    // 1. 컨트롤러가 기다리는 POST 방식으로 변경
    form.method = 'POST';
    // 2. 컨트롤러의 실제 매핑 주소로 변경
    form.action = '/order/directConfirm';

    var idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'productId';
    idInput.value = productId;
    form.appendChild(idInput);

    var qtyInput = document.createElement('input');
    qtyInput.type = 'hidden';
    qtyInput.name = 'quantity';
    qtyInput.value = '1'; // 상세페이지 기본 구매 수량 1개
    form.appendChild(qtyInput);

    document.body.appendChild(form);
    form.submit();
  }
</script>

</body>
</html>