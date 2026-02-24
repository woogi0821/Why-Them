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