<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>lala boutique / editorial</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;1,300&family=Noto+Sans+KR:wght@200;300;400&display=swap" rel="stylesheet">

    <style>
        /* 팀원이 작성한 CSS 원본 그대로 유지 [cite: 2026-01-29] */
        body { margin: 0; background: #fff; font-family: 'Noto Sans KR', sans-serif; color: #111; overflow-x: hidden; }
        .container { max-width: 1400px; margin: auto; padding-bottom: 100px; }

        header { height: 180px; display: flex; flex-direction: column; justify-content: center; align-items: center; border-bottom: 1px solid #111; margin: 0 20px; position: relative; }
        .util-menu { position: absolute; right: 20px; top: 40px; display: flex; gap: 20px; align-items: center; font-size: 11px; letter-spacing: 1px; }
        .util-link { cursor: pointer; text-transform: uppercase; }
        .icon-group { display: flex; gap: 20px; font-size: 20px; margin-left: 20px; }
        .icon-wish, .icon-cart { cursor: pointer; transition: 0.3s; }
        .icon-wish:hover { transform: scale(1.3); color: #000; }

        .logo { font-family: 'Cormorant Garamond', serif; font-size: 45px; font-weight: 300; letter-spacing: 15px; cursor: pointer; }
        .sub-logo { font-size: 9px; letter-spacing: 5px; color: #999; margin-top: 10px; }

        /* 네비게이션 스타일 [cite: 2026-01-30] */
        .nav-wrapper { position: sticky; top: 0; z-index: 1000; background: #fff; border-bottom: 1px solid #eee; }
        .menu-bar { height: 60px; display: flex; justify-content: center; align-items: center; gap: 100px; max-width: 1000px; margin: auto; }
        .menu-link { font-size: 11px; font-weight: 300; letter-spacing: 2px; cursor: pointer; width: 80px; text-align: center; text-transform: uppercase; }
        .full-dropout { display: none; position: absolute; top: 61px; left: 50%; transform: translateX(-50%); width: 100vw; background: #fff; border-bottom: 1px solid #eee; padding: 30px 0; }
        .nav-wrapper:hover .full-dropout { display: block; }
        .dropout-inner { max-width: 1000px; margin: auto; display: flex; justify-content: center; gap: 100px; }
        .drop-col { width: 80px; text-align: center; }
        .drop-link { display: block; padding: 10px 0; font-size: 10px; color: #888; cursor: pointer; }

        /* 나머지 스타일들은 index.jsp나 footer에 영향이 가므로 여기 둠 */
        .section-wrap { padding: 0 20px; margin-top: 100px; }
        .sttl { font-family: 'Cormorant Garamond', serif; font-size: 32px; font-style: italic; font-weight: 300; margin-bottom: 40px; }
        .grid { display: grid; grid-template-columns: repeat(4, 1fr); gap: 50px 25px; }
        .grid-6 { grid-template-columns: repeat(6, 1fr); gap: 15px; }
        .card { cursor: pointer; }
        .img-box { position: relative; width: 100%; aspect-ratio: 3/4; overflow: hidden; background: #f9f9f9; border: 1px solid #eee; }
        .img-box img { width: 100%; height: 100%; object-fit: cover; transition: 0.8s; }
        .info { padding: 20px 0; border-top: 1px solid #f0f0f0; margin-top: 10px; }
        .name { display: block; font-size: 10px; letter-spacing: 1px; text-transform: uppercase; color: #111; margin-bottom: 5px; }
        .price { font-family: 'Cormorant Garamond'; font-size: 15px; font-style: italic; color: #888; }

        /* 모달 및 인증 스타일 (생략 없이 원본 유지) */
        .modal { display: none; position: fixed; inset: 0; background: rgba(255,255,255,0.98); z-index: 2000; overflow-y: auto; }
        .modal-close { position: absolute; top: 40px; right: 40px; font-size: 30px; cursor: pointer; font-weight: 200; }
        .auth-box { max-width: 400px; margin: 150px auto; text-align: center; }
        .auth-box h2 { font-family: 'Cormorant Garamond'; font-size: 35px; font-weight: 300; margin-bottom: 40px; text-transform: uppercase; }
        .auth-input { width: 100%; height: 50px; border: none; border-bottom: 1px solid #111; margin-bottom: 20px; outline: none; font-size: 13px; letter-spacing: 1px; }
        .auth-btn { width: 100%; height: 55px; background: #111; color: #fff; display: flex; justify-content: center; align-items: center; cursor: pointer; font-size: 12px; letter-spacing: 2px; margin-top: 20px; }
        .detail-cont { max-width: 1200px; margin: 100px auto; display: flex; gap: 80px; padding: 0 40px; }
        .detail-img { flex: 1; aspect-ratio: 3/4; }
        .detail-img img { width: 100%; height: 100%; object-fit: cover; }
        .detail-info { flex: 1; padding-top: 50px; }
        .d-name { font-family: 'Cormorant Garamond'; font-size: 40px; font-weight: 300; margin-bottom: 30px; text-transform: uppercase; }
        .d-price { font-size: 22px; color: #111; margin-bottom: 40px; border-bottom: 1px solid #eee; padding-bottom: 20px; }
        .d-desc { font-size: 13px; line-height: 2.2; color: #666; }
        footer { margin-top: 150px; padding: 80px 20px 40px; border-top: 1px solid #eee; display: flex; justify-content: space-between; align-items: flex-end; background: #fafafa; font-size: 10px; color: #999; }
    </style>
</head>
<body>

<header>
    <div class="util-menu" id="util-box">
        <c:choose>
            <%-- 로그인 했을 때 --%>
            <c:when test="${not empty sessionScope.loginMember}">
            <span style="margin-right:15px; color:#bbb;">
                <c:out value="${sessionScope.loginMember.memberName}"/>님
            </span>
                <span class="util-link" onclick="location.href='/member/logout'">LOGOUT</span>
            </c:when>

            <%-- 로그인 안 했을 때 (모달 띄우기 유지) --%>
            <c:otherwise>
                <span class="util-link" onclick="openAuth('login')">LOGIN</span>
                <span class="util-link" onclick="location.href='/member/join'">JOIN</span>
            </c:otherwise>
        </c:choose>

        <div class="icon-group"><span class="icon-wish">♡</span><span class="icon-cart">🛒</span></div>
    </div>

    <div class="logo" onclick="location.href='/'">lala boutique</div>
    <div class="sub-logo">2026 timeless collection</div>
</header>

<div class="nav-wrapper">
    <div class="menu-bar">
        <div class="menu-link">top</div><div class="menu-link">bottom</div><div class="menu-link">shoes</div><div class="menu-link">acc</div>
    </div>
    <div class="full-dropout"><div class="dropout-inner">
        <div class="drop-col"><div class="drop-link">Shirts</div><div class="drop-link">Sweater</div><div class="drop-col">Suit</div><div class="drop-col">Coat</div></div>
        <div class="drop-col"><div class="drop-link">Pants</div><div class="drop-link">Skirts</div></div>
        <div class="drop-col"><div class="drop-link">Dress Shoe</div><div class="drop-link">Sandals</div></div>
        <div class="drop-col"><div class="drop-link">Hat</div><div class="drop-link">Bag</div></div>
    </div></div>
</div>