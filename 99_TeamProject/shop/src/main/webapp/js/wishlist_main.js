/* 1. 개별 삭제 (AJAX) */
function removeOneItem(wishId) {
    if (!confirm('이 상품을 위시리스트에서 삭제하시겠습니까?')) return;

    fetch('/wishlist/remove', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'wishId=' + wishId
    })
        .then(response => response.text())
        .then(data => {
            if (data === 'ok') {
                // 화면에서 해당 아이템 즉시 제거 (새로고침 없이)
                const item = document.getElementById('wish-item-' + wishId);
                if (item) item.remove();

                // 아이템이 하나도 없으면 새로고침해서 '텅 빔' 상태 보여주기
                if (document.querySelectorAll('.wish-item').length === 0) {
                    location.reload();
                }
            } else {
                alert('삭제에 실패했습니다. 다시 시도해주세요.');
            }
        })
        .catch(err => console.error(err));
}

/* 2. 전체 삭제 (AJAX) */
function removeAllItems() {
    if (!confirm('정말 모든 상품을 삭제하시겠습니까?\n이 작업은 되돌릴 수 없습니다.')) return;

    fetch('/wishlist/removeAll', {
        method: 'POST'
    })
        .then(response => response.text())
        .then(data => {
            if (data === 'ok') {
                alert('위시리스트가 초기화되었습니다.');
                location.reload(); // 깔끔하게 새로고침
            } else {
                alert('전체 삭제에 실패했습니다.');
            }
        })
        .catch(err => console.error(err));
}

/* 3. 장바구니 담기 (CartController 연동 완료) */
function addToCart(productId) {
    if (!confirm('이 상품을 장바구니에 담으시겠습니까?')) return;

    // 1. 보이지 않는 가짜 폼(Form)을 생성
    const form = document.createElement('form');
    form.method = 'POST';
    form.action = '/cart/add';

    // 2. 컨트롤러가 기다리는 'productId' 데이터 세팅
    const idInput = document.createElement('input');
    idInput.type = 'hidden';
    idInput.name = 'productId';
    idInput.value = productId;
    form.appendChild(idInput);

    // 3. 컨트롤러가 기다리는 'quantity' (위시리스트에서 담을 땐 기본 1개)
    const qtyInput = document.createElement('input');
    qtyInput.type = 'hidden';
    qtyInput.name = 'quantity';
    qtyInput.value = '1';
    form.appendChild(qtyInput);

    // 4. 문서에 폼을 붙이고 전송 (발사!)
    document.body.appendChild(form);
    form.submit();

    // 전송 직후 컨트롤러 로직(INSERT)이 돌고, 알아서 /cart/list 로 리다이렉트 됩니다.
}