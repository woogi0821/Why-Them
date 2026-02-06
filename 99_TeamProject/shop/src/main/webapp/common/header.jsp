<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<aside class="top-utils">
    <c:if test="${empty sessionScope.loginMember}">
        <span onclick="location.href='/member/login'">LOGIN</span>
        <span onclick="location.href='/member/join'">JOIN</span>
    </c:if>

    <c:if test="${not empty sessionScope.loginMember}">
        <span style="color: #333; cursor: default;">
            <b>${sessionScope.loginMember.memberName}</b>님
        </span>
        <span onclick="location.href='/member/logout'">LOGOUT</span>
        <span onclick="location.href='/cart/list'">CART</span>
        <span onclick="location.href='/member/mypage'">MY PAGE</span>
    </c:if>
</aside>

<header onclick="location.href='/main'">
    <h1 class="logo">lala boutique</h1>
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
                <span onclick="location.href='/main?categoryId=7'">COAT</span>
                <span onclick="location.href='/main?categoryId=8'">SHIRTS</span>
                <span onclick="location.href='/main?categoryId=9'">SWEATER</span>
            </div>
            <div class="drop-column">
                <span onclick="location.href='/main?categoryId=10'">PANTS</span>
                <span onclick="location.href='/main?categoryId=11'">SKIRTS</span>
            </div>
            <div class="drop-column">
                <span onclick="location.href='/main?categoryId=12'">ONEPIECE</span>
                <span onclick="location.href='/main?categoryId=13'">SUIT</span>
            </div>
            <div class="drop-column">
                <span onclick="location.href='/main?categoryId=14'">DRESS SHOE</span>
                <span onclick="location.href='/main?categoryId=15'">SANDALS</span>
            </div>
            <div class="drop-column">
                <span onclick="location.href='/main?categoryId=16'">BAG</span>
                <span onclick="location.href='/main?categoryId=17'">HAT</span>
            </div>
        </div>
    </div>
</nav>