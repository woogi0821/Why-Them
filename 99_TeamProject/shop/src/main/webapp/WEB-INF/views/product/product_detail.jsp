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

    /* [수정] 위시리스트 버튼 스타일 */
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

      <button type="button" id="btn-wish"
              class="btn-cart ${isWished ? 'active' : ''}"
              onclick="toggleDetailWish('${product.productId}')">
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
                if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')) {
                  location.href = '/member/login';
                }
              }
              else if (result === 'add') {
                // 찜 완료 상태로 변경
                btn.classList.add('active');
                btn.innerText = 'REMOVE FROM WISHLIST'; // 텍스트 변경
                alert('위시리스트에 담겼습니다.'); // 혹은 showToast 사용
              }
              else if (result === 'remove') {
                // 찜 취소 상태로 변경
                btn.classList.remove('active');
                btn.innerText = 'ADD TO WISHLIST';
                alert('위시리스트에서 삭제되었습니다.');
              }
            })
            .catch(err => console.error(err));
  }
  function toggleDetailWish(productId) {
    // 서버로 요청 전송
    fetch('/wishlist/toggle', {
      method: 'POST',
      headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
      body: 'productId=' + productId
    })
            .then(response => response.text())
            .then(result => {
              const btn = document.getElementById('btn-wish');

              if (result === 'login') {
                // 로그인은 중요한 절차라 confirm 창 유지 (또는 로그인 모달 띄우기)
                if(confirm('로그인이 필요한 서비스입니다.\n로그인 페이지로 이동하시겠습니까?')) {
                  location.href = '/member/login';
                }
              }
              else if (result === 'add') {
                // 1. 버튼 스타일 변경 (검정색)
                btn.classList.add('active');
                // 2. 텍스트 변경 (피드백 확실하게)
                btn.innerText = 'REMOVE FROM WISHLIST';
                // 3. 방해하지 않는 토스트 알림
                showToast('위시리스트에 담았습니다.');
              }
              else if (result === 'remove') {
                // 1. 버튼 스타일 변경 (흰색)
                btn.classList.remove('active');
                // 2. 텍스트 변경
                btn.innerText = 'ADD TO WISHLIST';
                // 3. 토스트 알림
                showToast('위시리스트에서 삭제했습니다.');
              }
            })
            .catch(err => {
              console.error(err);
              // 에러 상황은 사용자에게 알려주는 게 좋음 (선택사항)
              // alert('일시적인 오류가 발생했습니다.');
            });
  }

  // 토스트 메시지 출력 함수 (재사용)
  function showToast(message) {
    let toast = document.getElementById('toast-msg');

    // 토스트 요소가 없으면 생성
    if (!toast) {
      toast = document.createElement('div');
      toast.id = 'toast-msg';
      document.body.appendChild(toast);
    }

    toast.innerText = message;
    toast.style.opacity = '1';

    // 2초 뒤에 서서히 사라짐
    setTimeout(() => {
      toast.style.opacity = '0';
    }, 2000);
  }
</script>

</body>
</html>