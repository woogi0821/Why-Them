<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;500&family=Noto+Sans+KR:wght@100;300;400;500&display=swap" rel="stylesheet">
<link rel="stylesheet" href="/css/homepage.css">

<header class="top-bar">
    <h1 class="logo" onclick="location.href='/'">LALA BOUTIQUE</h1>

    <aside class="top-utils">
        <c:choose>
            <%-- 1. 비로그인 상태 --%>
            <c:when test="${empty sessionScope.loginMember}">
                <span id="auth-btn" class="util-link" onclick="openLoginModal()">LOGIN</span>
                <span class="util-link" onclick="location.href='/member/join'">JOIN</span>
            </c:when>

            <%-- 2. 로그인 상태 --%>
            <c:otherwise>
            <span class="user-txt" style="font-weight:bold; margin-right:10px;">
                ${sessionScope.loginMember.memberName}님
            </span>

                <c:if test="${sessionScope.loginMember.memberGrade == 'Y'}">
                    <span class="util-link" onclick="location.href='/admin/admin_main'" style="color:red;">ADMIN</span>
                </c:if>

                <span class="util-link" onclick="location.href='/member/logout'">LOGOUT</span>
                <span class="util-link" onclick="location.href='/member/mypage'">MYPAGE</span>
                <span class="util-link" onclick="location.href='/wishlist'">WISHLIST</span>
                <span class="util-link" onclick="location.href='/order/cart'">CART</span>
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
    </div>

    <div class="full-dropdown">
        <div class="drop-container">
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(1)" class="${selectedCategory == 1 ? 'active' : ''}">코트</li>
                    <li onclick="loadCategory(2)" class="${selectedCategory == 2 ? 'active' : ''}">셔츠</li>
                    <li onclick="loadCategory(3)" class="${selectedCategory == 3 ? 'active' : ''}">스웨터</li>
                </ul>
            </div>
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(4)" class="${selectedCategory == 4 ? 'active' : ''}">팬츠</li>
                    <li onclick="loadCategory(5)" class="${selectedCategory == 5 ? 'active' : ''}">스커트</li>
                </ul>
            </div>
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(6)" class="${selectedCategory == 6 ? 'active' : ''}">원피스</li>
                    <li onclick="loadCategory(7)" class="${selectedCategory == 7 ? 'active' : ''}">수트</li>
                </ul>
            </div>
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(8)" class="${selectedCategory == 8 ? 'active' : ''}">드레스슈즈</li>
                    <li onclick="loadCategory(9)" class="${selectedCategory == 9 ? 'active' : ''}">샌들</li>
                </ul>
            </div>
            <div class="drop-column">
                <ul class="sub-menu">
                    <li onclick="loadCategory(10)" class="${selectedCategory == 10 ? 'active' : ''}">백</li>
                    <li onclick="loadCategory(11)" class="${selectedCategory == 11 ? 'active' : ''}">모자</li>
                </ul>
            </div>
        </div>
    </div>
</nav>

<div id="login-modal" class="modal-overlay" style="display:none;">
    <div class="modal-content">
        <span class="close-btn" onclick="closeLoginModal()">&times;</span>
        <h2 style="font-family:'Cormorant Garamond'; margin-bottom:20px;">LOGIN</h2>
        <form action="/member/login" method="post">
            <input type="text" name="loginId" placeholder="ID" required style="width:100%; padding:10px; margin-bottom:10px; border:1px solid #ddd;">
            <input type="password" name="loginPw" placeholder="PASSWORD" required style="width:100%; padding:10px; margin-bottom:20px; border:1px solid #ddd;">
            <button type="submit" style="width:100%; background:#1a1a1a; color:#fff; padding:12px; border:none; cursor:pointer;">SIGN IN</button>
        </form>
    </div>
</div>

<script>
    // 간단한 모달 제어 스크립트 (homepage.js에 있다면 이거 지워도 됨)
    function openLoginModal() { document.getElementById('login-modal').style.display = 'flex'; }
    function closeLoginModal() { document.getElementById('login-modal').style.display = 'none'; }
    // URL을 변경하여 서버에 데이터를 요청함
    function loadCategory(categoryId) {location.href = "/?categoryId=" + categoryId;
    }
</script>

<style>
    /* 모달 스타일 (간단 적용) */
    .modal-overlay { position: fixed; top: 0; left: 0; width: 100%; height: 100%; background: rgba(0,0,0,0.5); z-index: 9999; justify-content: center; align-items: center; }
    .modal-content { background: #fff; padding: 40px; width: 300px; text-align: center; position: relative; }
    .close-btn { position: absolute; top: 10px; right: 15px; font-size: 24px; cursor: pointer; }
</style>