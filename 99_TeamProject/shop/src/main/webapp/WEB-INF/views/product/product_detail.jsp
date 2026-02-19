<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
  <meta charset="UTF-8">
  <title>${product.name} - WHY THEM</title>
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

    /* 찜 완료 상태 스타일 (검정 배경) */
    .btn-cart.active {
      background: #111; color: #fff; border-color: #111;
    }
    /* 토스트 메시지 스타일 (메인 페이지와 통일) */
    #toast-msg {
      font-family: 'Noto Sans KR', sans-serif;
      position: fixed;
      bottom: 50px;
      left: 50%;
      transform: translateX(-50%);
      background: rgba(26, 26, 26, 0.95); /* 깊은 검정색 */
      color: #fff;
      padding: 12px 24px;
      border-radius: 30px; /* 둥글게 */
      font-size: 13px;
      opacity: 0;
      transition: opacity 0.3s ease-in-out;
      z-index: 9999;
      letter-spacing: 1px;
      box-shadow: 0 4px 10px rgba(0,0,0,0.2);
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


    <h1 class="title-text"><c:out value="${product.name}" /></h1>

    <p class="price-text">
      KRW <fmt:formatNumber value="${product.price}" pattern="#,###"/>
    </p>

    <div class="desc-text">
      <c:out value="${product.description}" />
    </div>

    <div class="action-btns">
      <button type="button" class="btn-buy-now" onclick="buyNow('<c:out value="${product.productId}"/>')">BUY NOW</button>
      <button type="button" class="btn-bag" onclick="addToCart('<c:out value="${product.productId}"/>')">ADD TO BAG</button>

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
  /* ★ [추가] 장바구니 담기 기능 */
  function addToCart(productId) {
    // 1. 보이지 않는 가짜 폼(Form)을 생성
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/cart/add'; // CartController의 매핑 주소

    // 2. 컨트롤러가 기다리는 'productId' 데이터 세팅
    const idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'productId';
    idInput.value = productId;
    form.appendChild(idInput);

    // 3. 컨트롤러가 기다리는 'quantity' 데이터 세팅 (상세 페이지 기본 수량 1개)
    const qtyInput = document.createElement('input');
    qtyInput.type = 'hidden';
    qtyInput.name = 'quantity';
    qtyInput.value = '1';
    form.appendChild(qtyInput);

    // 4. 문서에 폼을 붙이고 전송
    document.body.appendChild(form);
    form.submit();
  }

  /* 찜하기 토글 (중복 제거 및 최적화) */
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
            .catch(err => {
              console.error(err);
            });
  }

  /* 토스트 메시지 출력 함수 */
  function showToast(message) {
    let toast = document.getElementById('toast-msg');

    if (!toast) {
      toast = document.createElement('div');
      toast.id = 'toast-msg';
      document.body.appendChild(toast);
    }

    toast.innerText = message;
    toast.style.opacity = '1';

    setTimeout(() => {
      toast.style.opacity = '0';
    }, 2000);
  }
  /* ★ [추가] 바로 구매 기능 */
  function buyNow(productId) {
    // 결제팀으로 상품번호와 수량(1개)을 바로 쏴줍니다.
    const form = document.createElement('form');
    form.method = 'GET'; // 결제팀이 GET을 쓰는지 POST를 쓰는지에 따라 수정 필요
    form.action = '/order/form'; // ★ 결제팀의 결제 폼 주소 (임의 작성)

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
</script>

</body>
</html>