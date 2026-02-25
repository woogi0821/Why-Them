// 개별 삭제 스크립트
function removeCartItem(cartItemId) {
    if(confirm('이 상품을 장바구니에서 삭제하시겠습니까?')) {
        document.getElementById('removeTargetId').value = cartItemId;
        document.getElementById('removeForm').submit();
    }
}

// 전체 선택/해제 스크립트
const checkAll = document.getElementById('checkAll');
if(checkAll) {
    checkAll.addEventListener('change', function() {
        // 🚩 수정: 판매 중지(disabled)가 아닌 체크박스만 선택
        const checkboxes = document.querySelectorAll('.item-check:not(:disabled)');
        checkboxes.forEach(cb => cb.checked = this.checked);
        updateTotalPrice();
    });
}

// 개별 체크박스 변경 시 금액 업데이트 이벤트 등록
document.querySelectorAll('.item-check').forEach(cb => {
    cb.addEventListener('change', updateTotalPrice);
});

// 상품 총 금액 구하기
function updateTotalPrice() {
    const checkedItems = document.querySelectorAll('.item-check:checked');
    let total = 0;

    checkedItems.forEach(cb => {
        const row = cb.closest('tr');
        const priceElement = row.querySelector('.item-price');
        const price = parseInt(priceElement.dataset.price);
        total += price;
    });

    const formatted = total.toLocaleString('ko-KR') + " KRW";
    document.getElementById('totalPriceDisplay').innerText = formatted;
    document.getElementById('totalPriceInput').value = total;
}

// 선택항목 주문 전송
function selectedItemsOrder() {
    if (!document.querySelector('.item-check:checked'))
        return alert("주문할 상품을 선택해주세요!");

    if (confirm("선택하신 상품을 주문하시겠습니까?")) {
        document.getElementById('orderForm').submit();
    }
}

// 🚩 초기 로딩 시 금액 업데이트 한 번 실행
window.onload = updateTotalPrice;