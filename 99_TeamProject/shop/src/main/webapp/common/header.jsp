<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<link rel="stylesheet" href="${pageContext.request.contextPath}/css/homepage.css">

<div class="top-utils">
    <c:choose>
        <c:when test="${empty sessionScope.loginMember}">
            <span onclick="location.href='${pageContext.request.contextPath}/member/login'">로그인</span>
            <span onclick="location.href='${pageContext.request.contextPath}/member/join'">회원가입</span>
        </c:when>
        <c:otherwise>
            <span style="color:#000; font-weight:bold;">
                <c:out value="${sessionScope.loginMember.memberName}" />님
            </span>
            <span onclick="location.href='${pageContext.request.contextPath}/member/logout'">로그아웃</span>
        </c:otherwise>
    </c:choose>

    <span onclick="location.href='${pageContext.request.contextPath}/wish/list'">위시리스트</span>
    <span onclick="location.href='${pageContext.request.contextPath}/cart/list'">
        장바구니
        <span id="cart-count" class="cart-count">
            <c:out value="${empty sessionScope.cartCount ? 0 : sessionScope.cartCount}" />
        </span>
    </span>
    <c:if test="${sessionScope.loginMember.memberGrade == 'Y'}">
        <span onclick="location.href='${pageContext.request.contextPath}/admin/admin_main'">관리자 페이지</span>
    </c:if>
</div>

<header onclick="location.href='${pageContext.request.contextPath}/'">
    <div class="logo">lala boutique</div>
</header>

<%--<nav class="nav-wrapper">--%>
<%--    <div class="menu-bar">--%>
<%--        <span class="menu-link" onclick="location.href='${pageContext.request.contextPath}/product/list?category=top'">Tops</span>--%>
<%--        <span class="menu-link" onclick="location.href='${pageContext.request.contextPath}/product/list?category=bottom'">Bottoms</span>--%>
<%--        <span class="menu-link" onclick="location.href='${pageContext.request.contextPath}/product/list?category=shirts'">Shirts</span>--%>
<%--        <span class="menu-link" onclick="location.href='${pageContext.request.contextPath}/product/list?category=shoes'">Shoes</span>--%>
<%--        <span class="menu-link" onclick="location.href='${pageContext.request.contextPath}/product/list?category=acc'">Acc</span>--%>
<%--    </div>--%>

<%--    <div class="full-dropdown">--%>
<%--        <div class="drop-container">--%>
<%--            <div class="drop-column">--%>
<%--                <span class="drop-link" onclick="location.href='${pageContext.request.contextPath}/product/list?category=coat'">COAT</span>--%>
<%--                <span class="drop-link" onclick="location.href='${pageContext.request.contextPath}/product/list?category=shirts'">SHIRTS</span>--%>
<%--                <span class="drop-link" onclick="location.href='${pageContext.request.contextPath}/product/list?category=sweater'">SWEATER</span>--%>
<%--            </div>--%>
<%--        </div>--%>
<%--    </div>--%>
<%--</nav>--%>