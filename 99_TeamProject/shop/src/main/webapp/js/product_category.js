function toggleWishList(event, productId, btnElement) {
    event.stopPropagation(); // 카드 클릭 방지
    event.preventDefault();

    fetch('/wishlist/toggle', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'productId=' + productId
    })
        .then(response => response.text())
        .then(result => {
            if (result === 'login') {
                if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')) {
                    location.href = '/member/login';
                }
            } else if (result === 'add') {
                btnElement.classList.add('active');
                showToast('위시리스트에 담았습니다.');
            } else if (result === 'remove') {
                btnElement.classList.remove('active');
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