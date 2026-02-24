<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500;600&family=Noto+Sans+KR:wght@100;300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/homepage.css">
<meta name="viewport" content="width=device-width, initial-scale=1.0">
<style>
    /* [스타일 유지] 프리미엄 로그인 모달 */
    .modal-overlay {
        position: fixed; top: 0; left: 0; width: 100%; height: 100%;
        background: rgba(0, 0, 0, 0.6); backdrop-filter: blur(5px);
        z-index: 9999; display: none;
        justify-content: center; align-items: center;
        opacity: 0; transition: opacity 0.3s ease;
    }
    .modal-overlay.show { opacity: 1; }

    .modal-content {
        background: #fff; width: 380px; padding: 50px 40px;
        position: relative; box-shadow: 0 10px 30px rgba(0,0,0,0.3);
        text-align: center;
    }

    .modal-title {
        font-family: 'Cormorant Garamond', serif;
        font-size: 32px; font-weight: 500; letter-spacing: 2px;
        margin-bottom: 40px; color: #1a1a1a;
    }

    /* 입력창 (밑줄 스타일) */
    .login-input {
        width: 100%; padding: 12px 5px; margin-bottom: 20px;
        border: none; border-bottom: 1px solid #ddd;
        font-family: 'Noto Sans KR', sans-serif; font-size: 15px;
        outline: none; transition: border-color 0.3s;
    }
    .login-input:focus { border-bottom: 1px solid #1a1a1a; }
    .login-input::placeholder { color: #aaa; font-size: 14px; }

    /* 버튼 그룹 */
    .btn-group { margin-top: 30px; }

    .btn-login {
        width: 100%; padding: 15px; background: #1a1a1a; color: #fff;
        border: 1px solid #1a1a1a; font-size: 13px; font-weight: 500; letter-spacing: 1px;
        cursor: pointer; transition: all 0.3s;
    }
    .btn-login:hover { background: #333; border-color: #333; }

    .btn-cancel {
        width: 100%; padding: 15px; background: #fff; color: #666;
        border: 1px solid #ddd; font-size: 13px; margin-top: 10px;
        cursor: pointer; transition: all 0.3s;
    }
    .btn-cancel:hover { background: #f9f9f9; color: #1a1a1a; border-color: #bbb; }

    /* 링크 및 유틸 */
    .modal-footer { margin-top: 30px; font-size: 12px; color: #999; font-family: 'Noto Sans KR'; }
    .modal-footer a { color: #888; text-decoration: none; transition: color 0.3s; margin: 0 10px; }
    .modal-footer a:hover { color: #1a1a1a; text-decoration: underline; }
    .divider { color: #ddd; font-size: 10px; vertical-align: middle; }
    .close-icon { position: absolute; top: 20px; right: 20px; font-size: 24px; color: #ccc; cursor: pointer; transition: color 0.3s; }
    .close-icon:hover { color: #1a1a1a; }

    /* 에러 메시지 (모달용) */
    .modal-msg { font-size: 12px; color: #e74c3c; display: block; margin-bottom: 15px; text-align: left; }
    /* [추가] 뱃지 위치를 잡기 위한 부모 클래스 */
    .badge-wrapper { position: relative; display: inline-block; }

    /* 장바구니 숫자 뱃지 (빨간색 동그라미) */
    /* 장바구니 숫자 뱃지 (완벽 중앙 정렬 & 2자리수 알약 대응) */
    .cart-badge {
        position: absolute; top: -8px; right: -14px;
        background: #e74c3c; color: #fff; font-size: 9px; font-weight: 700;

        /* 1자리일 땐 동그라미, 2자리일 땐 알약 모양으로 자연스럽게 늘어납니다 */
        min-width: 16px; height: 16px;
        padding: 0 5px;
        border-radius: 10px;

        display: flex; justify-content: center; align-items: center;

        /* ★ 핵심: 부모에게서 물려받은 글자 간격을 0으로 없애서 완벽한 중앙에 위치시킴 */
        letter-spacing: 0;
        box-sizing: border-box;
    }

    /* 위시리스트 N 뱃지 (검정색 네모) */
    .wish-badge {
        position: absolute; top: -6px; right: -12px;
        background: #111; color: #fff; font-size: 8px; font-weight: bold;
        padding: 2px 4px; border-radius: 3px; letter-spacing: 0;
        display: none; /* 평소엔 숨겨둠 */
    }
    /* 햄버거 버튼 기본 숨김 */
    .mobile-toggle {
        display: none;
        font-size: 26px;
        cursor: pointer;
    }

    /* 반응형 */
    @media (max-width: 1024px) {

        .mobile-toggle {
            display: block;
        }

        .top-utils {
            position: absolute;
            top: 70px;
            right: 0;
            width: 240px;
            background: #ffffff;
            border: 1px solid #ddd;
            display: none;
            flex-direction: column;
            padding: 20px;
            gap: 15px;
            z-index: 999;
        }

        .top-utils.active {
            display: flex;
        }

        .top-utils .util-link,
        .top-utils .user-txt {
            display: block;
            margin: 5px 0;
        }
    }
</style>

<header class="top-bar">
    <h1 class="logo" onclick="location.href='/'">LALA BOUTIQUE</h1>

    <!-- ✅ 햄버거 버튼 (모바일 전용) -->
    <div class="mobile-toggle" onclick="toggleMenu()">☰</div>

    <!-- ✅ 기존 top-utils 에 id 추가 -->
    <aside class="top-utils" id="headerRight">
        <c:choose>

            <c:when test="${empty sessionScope.loginMember}">
                <span id="auth-btn" class="util-link" onclick="openLoginModal()">LOGIN</span>
                <span class="util-link" onclick="location.href='/member/join'">JOIN</span>
            </c:when>

            <c:otherwise>
                <span class="user-txt" style="font-weight:bold; margin-right:10px;">
                    ${sessionScope.loginMember.memberName}님
                </span>

                <c:if test="${sessionScope.loginMember.memberGrade == 'Y'}">
                    <span class="util-link" onclick="location.href='/admin/admin_main'" style="color:red;">ADMIN</span>
                </c:if>

                <span class="util-link" onclick="location.href='/member/logout'">LOGOUT</span>
                <span class="util-link" onclick="location.href='/member/mypage'">MYPAGE</span>

                <span class="util-link badge-wrapper" onclick="location.href='/wishlist/list'">
                    WISHLIST
                    <span id="header-wish-badge" class="wish-badge">N</span>
                </span>

                <span class="util-link badge-wrapper" onclick="location.href='/cart/list'">
                    CART
                    <span id="header-cart-badge" class="cart-badge"
                          style="display: ${empty sessionScope.cartCount || sessionScope.cartCount == 0 ? 'none' : 'flex'}">
                            ${empty sessionScope.cartCount ? 0 : sessionScope.cartCount}
                    </span>
                </span>
            </c:otherwise>

        </c:choose>
    </aside>
</header>

<nav class="nav-wrapper">
    <div class="menu-bar">
        <div class="menu-item">TOPS</div>
        <div class="menu-item">BOTTOMS</div>
        <div class="menu-item">SETS</div>
        <div class="menu-item">SHOES</div>
        <div class="menu-item">ACC</div>
        <div class="menu-item">EVENT</div>
    </div>

    <div class="full-dropdown">
        <div class="drop-container">
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(1)">코트</li>
                    <li onclick="loadCategory(2)">셔츠</li>
                    <li onclick="loadCategory(3)">스웨터</li>
                </ul>
            </div>
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(4)">팬츠</li>
                    <li onclick="loadCategory(5)">스커트</li>
                </ul>
            </div>
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(6)">원피스</li>
                    <li onclick="loadCategory(7)">수트</li>
                </ul>
            </div>
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(8)">드레스슈즈</li>
                    <li onclick="loadCategory(9)">샌들</li>
                </ul>
            </div>
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(10)">백</li>
                    <li onclick="loadCategory(11)">모자</li>
                </ul>
            </div>

            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="location.href='/event/list?status=ongoing'">진행중인 이벤트</li>
                    <li onclick="location.href='/event/list?status=ended'">종료된 이벤트</li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div id="login-modal" class="modal-overlay">
    <div class="modal-content">
        <span class="close-icon" onclick="closeLoginModal()">&times;</span>

        <div id="login-form-view">
            <h2 class="modal-title">SIGN IN</h2>
            <form action="/member/login" method="post">
                <input type="text" name="loginId" class="login-input" placeholder="User ID" required autocomplete="off">
                <input type="password" name="loginPw" class="login-input" placeholder="Password" required autocomplete="off">

                <div class="btn-group">
                    <button type="submit" class="btn-login">LOGIN</button>
                    <button type="button" class="btn-cancel" onclick="closeLoginModal()">CANCEL</button>
                </div>
            </form>

            <div class="modal-footer">
                <a href="/member/join">JOIN US</a>
                <span class="divider">|</span>
                <a href="javascript:void(0)" onclick="toggleFindPwMode()">FIND PASSWORD</a>
            </div>
        </div>

        <div id="find-pw-view" style="display: none;">
            <h2 class="modal-title" style="font-size:26px;">RESET PW</h2>
            <p style="font-size:12px; color:#999; margin-bottom:20px; font-family:'Noto Sans KR';">
                가입 시 등록한 정보를 입력해주세요.
            </p>

            <form action="/member/resetPw" method="post" onsubmit="return validateModalResetForm()">
                <input type="hidden" name="from" value="login">

                <input type="text" name="loginId" id="modal_id" class="login-input" placeholder="User ID" autocomplete="off">
                <input type="text" name="memberName" id="modal_name" class="login-input" placeholder="Name" autocomplete="off">
                <%-- ★ [수정] 자동 하이픈 기능 추가 --%>
                <input type="text" name="phoneNumber" id="modal_phone" class="login-input" placeholder="Phone (010-0000-0000)" autocomplete="off" oninput="autoHyphen(this)" maxlength="13">
                <input type="password" name="newPw" id="modal_newPw" class="login-input" placeholder="New Password">
                <input type="password" id="modal_confirmPw" class="login-input" placeholder="Confirm Password">

                <span id="modalPwMsg" class="modal-msg"></span>

                <div class="btn-group">
                    <button type="submit" class="btn-login">RESET PASSWORD</button>
                    <button type="button" class="btn-cancel" onclick="toggleFindPwMode()">BACK TO LOGIN</button>
                </div>
            </form>
        </div>

    </div>
</div>

<script>
    // [완벽 수정] 100% 안전한 하이픈 자동 생성기 (글자 자르기 방식)
    function autoHyphen(target) {
        // 1. 사용자가 입력한 값에서 숫자만 싹 다 발라냅니다.
        let val = target.value.replace(/[^0-9]/g, '');
        let res = '';

        // 2. 글자 수에 맞춰서 하이픈(-)을 안전하게 조립합니다.
        if (val.length < 4) {
            res = val; // 010
        } else if (val.length < 8) {
            res = val.substring(0, 3) + '-' + val.substring(3); // 010-1234
        } else {
            // 010-1234-5678 (11자리까지만 자름)
            res = val.substring(0, 3) + '-' + val.substring(3, 7) + '-' + val.substring(7, 11);
        }

        // 3. 조립된 결과를 다시 입력창에 꽂아줍니다.
        target.value = res;
    }
    // 카테고리 이동
    function loadCategory(categoryId) { location.href = "/product/category?categoryId=" + categoryId; }

    // 모달 열기/닫기
    function openLoginModal() {
        const modal = document.getElementById('login-modal');
        modal.style.display = 'flex';
        setTimeout(() => { modal.classList.add('show'); }, 10);

        // 항상 로그인 화면부터 보여주기
        document.getElementById('login-form-view').style.display = 'block';
        document.getElementById('find-pw-view').style.display = 'none';
    }

    function closeLoginModal() {
        const modal = document.getElementById('login-modal');
        modal.classList.remove('show');
        setTimeout(() => { modal.style.display = 'none'; }, 300);
    }

    // 화면 전환 (로그인 <-> 비번찾기)
    function toggleFindPwMode() {
        const loginView = document.getElementById('login-form-view');
        const findView = document.getElementById('find-pw-view');

        if(loginView.style.display === 'none') {
            loginView.style.display = 'block';
            findView.style.display = 'none';
        } else {
            loginView.style.display = 'none';
            findView.style.display = 'block';
        }
    }

    // 모달 내부 비밀번호 찾기 폼 검증
    function validateModalResetForm() {
        const id = document.getElementById("modal_id").value;
        const name = document.getElementById("modal_name").value;
        const phone = document.getElementById("modal_phone").value;
        const newPw = document.getElementById("modal_newPw").value;
        const confirmPw = document.getElementById("modal_confirmPw").value;
        const msg = document.getElementById("modalPwMsg");

        msg.textContent = "";

        if(!id || !name || !phone) {
            alert("모든 정보를 입력해주세요.");
            return false;
        }
        if(!newPw) {
            alert("새 비밀번호를 입력해주세요.");
            return false;
        }
        if(newPw !== confirmPw) {
            msg.textContent = "* 비밀번호가 일치하지 않습니다.";
            return false;
        }

        return confirm("비밀번호를 재설정하시겠습니까?");
    }

    // 배경 클릭 닫기
    window.onclick = function(event) {
        const modal = document.getElementById('login-modal');
        if (event.target == modal) closeLoginModal();
    }

    // [유지] 장바구니 뱃지 숫자 업데이트
    function updateCartBadgeCount(newCount) {
        const badge = document.getElementById('header-cart-badge');
        if (badge) {
            badge.innerText = newCount;
            badge.style.display = newCount > 0 ? 'flex' : 'none';
        }
    }

    /* =========================================
       ★ [수정/추가] 위시리스트 N 뱃지 로컬스토리지 연동
       ========================================= */

    // 1. 페이지가 로드될 때마다 브라우저 창고(localStorage) 검사
    document.addEventListener('DOMContentLoaded', function() {
        if (localStorage.getItem('hasNewWish') === 'Y') {
            const badge = document.getElementById('header-wish-badge');
            if (badge) badge.style.display = 'block';
        }
    });

    // 2. 하트를 눌렀을 때 호출 (N 뱃지 켜기 + 창고에 메모)
    function showWishNewBadge() {
        const badge = document.getElementById('header-wish-badge');
        if (badge) {
            badge.style.display = 'block';
        }
        localStorage.setItem('hasNewWish', 'Y'); // "새 위시리스트 있음" 메모 저장
    }

    // 3. 위시리스트 페이지에 들어갔을 때 호출 (N 뱃지 끄기 + 창고 메모 찢기)
    function hideWishNewBadge() {
        const badge = document.getElementById('header-wish-badge');
        if (badge) {
            badge.style.display = 'none';
        }
        localStorage.removeItem('hasNewWish'); // 메모 삭제
    }

    document.addEventListener('DOMContentLoaded', function() {

        if (typeof hideWishNewBadge === 'function') {
            hideWishNewBadge();
        }
    });

</script>
<%-- ★ [추가] 컨트롤러에서 보낸 성공/실패 메시지 띄우기 --%>
<c:if test="${not empty msg}">
    <script>
        // 브라우저에 알림창 띄우기
        alert('<c:out value="${msg}"/>');
    </script>
</c:if>
<script>
    function toggleMenu(event) {
        event.stopPropagation(); // 버튼 클릭이 바깥 클릭으로 인식되지 않게
        document.getElementById("headerRight").classList.toggle("active");
    }

    // 햄버거 버튼에 이벤트 연결
    document.querySelector(".mobile-toggle").addEventListener("click", toggleMenu);

    // 화면 아무 곳이나 클릭하면 메뉴 닫기
    document.addEventListener("click", function (event) {
        const menu = document.getElementById("headerRight");
        const toggle = document.querySelector(".mobile-toggle");

        // 메뉴 영역이나 햄버거 버튼이 아닌 곳 클릭 시 닫기
        if (!menu.contains(event.target) && !toggle.contains(event.target)) {
            menu.classList.remove("active");
        }
    });
</script>