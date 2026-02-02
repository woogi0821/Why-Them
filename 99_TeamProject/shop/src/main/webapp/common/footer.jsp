<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<style>

    footer {
        margin-top: 150px;
        padding: 80px 20px 40px;
        border-top: 1px solid #eee;
        display: flex;
        justify-content: space-between;
        align-items: flex-end;
        background: #fafafa;
        font-size: 10px;
        color: #999;
    }

    .modal {
        display: none; /* 평소엔 숨김 */
        position: fixed;
        inset: 0;
        background: rgba(255,255,255,0.98);
        z-index: 2000;
        overflow-y: auto;
    }
    .modal-close {
        position: absolute;
        top: 40px;
        right: 40px;
        font-size: 30px;
        cursor: pointer;
        font-weight: 200;
    }

    .detail-cont { max-width: 1200px; margin: 100px auto; display: flex; gap: 80px; padding: 0 40px; }
    .detail-img { flex: 1; aspect-ratio: 3/4; }
    .detail-img img { width: 100%; height: 100%; object-fit: cover; }
    .detail-info { flex: 1; padding-top: 50px; }
    .d-name { font-family: 'Cormorant Garamond'; font-size: 40px; font-weight: 300; margin-bottom: 30px; text-transform: uppercase; }
    .d-price { font-size: 22px; color: #111; margin-bottom: 40px; border-bottom: 1px solid #eee; padding-bottom: 20px; }
    .d-desc { font-size: 13px; line-height: 2.2; color: #666; }
</style>

<div id="authModal" class="modal">
    <span class="modal-close" onclick="closeModal('authModal')">&times;</span>
    <div class="auth-box" id="authContent"></div>
</div>

<div id="detailModal" class="modal">
    <span class="modal-close" onclick="closeModal('detailModal')">&times;</span>
    <div class="detail-cont">
        <div class="detail-img"><img id="d-img" src=""></div>
        <div class="detail-info">
            <div id="d-name" class="d-name"></div>
            <div id="d-price" class="d-price"></div>
            <div class="d-desc">
                시대를 초월하는 우아함과 절제된 미학을 담은 컬렉션입니다.<br>
                엄격하게 선별된 소재와 정교한 공정을 통해 완성되었습니다.
            </div>
            <div style="margin-top: 60px; display: flex; gap: 10px;">
                <div class="auth-btn" style="flex:1" onclick="alert('Added to Cart')">ADD TO CART</div>
                <div class="auth-btn" style="flex:1; background: #fff; color: #111; border: 1px solid #111;" onclick="alert('Added to Wishlist')">WISH LIST</div>
            </div>
        </div>
    </div>
</div>

<footer>
    <div style="line-height: 2;"><b>LALA BOUTIQUE</b><br>CS: 1644-0000 | SEOUL, KOREA</div>
    <div>© 2026 ALL RIGHTS RESERVED.</div>
</footer>

<script>
    function openAuth(type) {
        const content = document.getElementById('authContent');
        const modal = document.getElementById('authModal');

        modal.style.display = 'block';

        if(type === 'login') {
            content.innerHTML = `
    <h2>Login</h2>
    <form action="/member/login" method="post">
        <input type="text" name="userId" class="auth-input" placeholder="ID" required>
        <input type="password" name="userPw" class="auth-input" placeholder="PASSWORD" required>

        <button type="submit" class="auth-btn" style="border:none;">ENTER</button>
    </form>

    <div class="auth-btn" onclick="location.href='/member/join'"
         style="background:#fff; color:#111; border:1px solid #111; margin-top:10px;">
        CREATE ACCOUNT
    </div>
  `;
        }
    }

    function closeModal(id) {
        document.getElementById(id).style.display = 'none';
        document.body.style.overflow = 'auto';
    }

</script>
</body>
</html>