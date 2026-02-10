<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | MY PAGE</title>
    <link href="https://cdnjs.cloudflare.com/ajax/libs/font-awesome/6.0.0/css/all.min.css" rel="stylesheet">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;600&family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/homepage.css">

    <style>
        /* 기본 설정 */
        body { font-family: 'Noto Sans KR', sans-serif; color: #1a1a1a; margin: 0; padding: 0; }
        a { text-decoration: none; color: inherit; }

        .mypage-container {
            max-width: 1000px;
            margin: 80px auto 150px;
            padding: 0 20px;
        }

        /* 1. 상단 인사말 (등급 삭제, 심플하게) */
        .welcome-box {
            text-align: center; /* 가운데 정렬 */
            padding-bottom: 40px;
            margin-bottom: 50px;
            border-bottom: 1px solid #1a1a1a;
        }
        .user-greeting {
            font-family: 'Cormorant Garamond', serif;
            font-size: 32px;
            font-weight: 300;
            letter-spacing: 1px;
        }
        .user-greeting strong { font-weight: 600; }
        .welcome-desc {
            margin-top: 10px;
            font-size: 13px;
            color: #888;
            font-family: 'Noto Sans KR', sans-serif;
        }

        /* 2. 퀵 메뉴 (위시리스트, 비번변경 등) - 기존 통계판 대체 */
        .quick-menu-grid {
            display: grid;
            grid-template-columns: repeat(3, 1fr); /* 3등분 */
            gap: 15px;
            margin-bottom: 60px;
        }
        .quick-item {
            background: #fff;
            border: 1px solid #eee;
            padding: 30px 20px;
            text-align: center;
            cursor: pointer;
            transition: all 0.3s;
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            height: 120px;
        }
        .quick-item:hover {
            border-color: #1a1a1a;
            background: #fafafa;
            transform: translateY(-3px); /* 살짝 떠오르는 효과 */
        }
        .quick-icon {
            font-size: 24px;
            color: #1a1a1a;
            margin-bottom: 15px;
        }
        .quick-text {
            font-family: 'Cormorant Garamond', serif;
            font-size: 14px;
            letter-spacing: 2px;
            text-transform: uppercase;
            font-weight: 600;
        }

        /* 3. 주문 진행 상태 (트래커) - 유지 */
        .order-status-wrap { margin-bottom: 80px; }
        .status-list {
            display: flex; justify-content: space-between; align-items: center;
            padding: 40px 0; border-top: 1px solid #eee; border-bottom: 1px solid #eee;
        }
        .status-step { text-align: center; flex: 1; position: relative; }
        .status-step:not(:last-child)::after {
            content: '\f054'; font-family: 'Font Awesome 6 Free'; font-weight: 900;
            position: absolute; right: 0; top: 50%; transform: translateY(-50%);
            color: #ddd; font-size: 14px;
        }
        .step-icon {
            display: inline-block; width: 50px; height: 50px; background: #f5f5f5;
            border-radius: 50%; line-height: 50px; margin-bottom: 15px;
            font-size: 20px; color: #bbb;
        }
        .step-text { font-size: 13px; color: #555; display: block; }
        .step-count {
            display: block; font-size: 18px; font-weight: 600; color: #1a1a1a;
            margin-top: 5px; font-family: 'Cormorant Garamond', serif;
        }
        /* 활성화 상태 */
        .active .step-icon { background: #1a1a1a; color: #fff; }
        .active .step-text { color: #1a1a1a; font-weight: 600; }

        /* 섹션 헤더 & 폼 스타일 */
        .section-header {
            display: flex; justify-content: space-between; align-items: flex-end;
            border-bottom: 2px solid #1a1a1a; padding-bottom: 15px;
            margin-bottom: 25px; margin-top: 60px;
        }
        .section-title {
            font-family: 'Cormorant Garamond', serif; font-size: 22px;
            font-weight: 600; text-transform: uppercase;
        }
        .info-table { width: 100%; border-collapse: collapse; }
        .info-table th { text-align: left; padding: 15px 0; width: 120px; font-size: 12px; color: #888; }
        .info-table td { padding: 15px 0; border-bottom: 1px solid #eee; }
        .editable-input { border: none; border-bottom: 1px solid #ddd; width: 100%; padding: 5px; outline: none; font-family: 'Noto Sans KR'; }
        .btn-update {
            background: #fff; border: 1px solid #1a1a1a; color: #1a1a1a;
            padding: 10px 30px; font-size: 11px; cursor: pointer; margin-top: 20px;
            text-transform: uppercase; letter-spacing: 1px; transition: all 0.3s;
        }
        .btn-update:hover { background: #1a1a1a; color: #fff; }

    </style>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="mypage-container">

    <div class="welcome-box">
        <div class="user-greeting">
            HELLO, <strong>${sessionScope.loginMember.memberName}</strong>
        </div>
        <div class="welcome-desc">
            라라 부티크에 오신 것을 환영합니다. 나의 쇼핑 정보를 확인하세요.
        </div>
    </div>

    <div class="quick-menu-grid">
        <a href="/wishlist" class="quick-item">
            <span class="quick-icon"><i class="fa-regular fa-heart"></i></span>
            <span class="quick-text">Wishlist</span>
        </a>

        <a href="/order/list" class="quick-item">
            <span class="quick-icon"><i class="fa-solid fa-bag-shopping"></i></span>
            <span class="quick-text">Order History</span>
        </a>

        <a href="#" class="quick-item" onclick="alert('준비 중인 기능입니다.'); return false;">
            <span class="quick-icon"><i class="fa-solid fa-lock"></i></span>
            <span class="quick-text">Change Password</span>
        </a>
    </div>

    <div class="order-status-wrap">
        <div class="section-header" style="margin-top:0; border-bottom:none;">
            <span class="section-title" style="font-size:18px;">Order Status</span>
        </div>
        <div class="status-list">
            <div class="status-step">
                <span class="step-icon"><i class="fa-solid fa-file-invoice-dollar"></i></span>
                <span class="step-text">입금대기</span>
                <span class="step-count">0</span>
            </div>
            <div class="status-step">
                <span class="step-icon"><i class="fa-solid fa-box-open"></i></span>
                <span class="step-text">결제완료</span>
                <span class="step-count">0</span>
            </div>
            <div class="status-step">
                <span class="step-icon"><i class="fa-solid fa-gift"></i></span>
                <span class="step-text">배송준비</span>
                <span class="step-count">0</span>
            </div>
            <div class="status-step">
                <span class="step-icon"><i class="fa-solid fa-truck-fast"></i></span>
                <span class="step-text">배송중</span>
                <span class="step-count">0</span>
            </div>
            <div class="status-step">
                <span class="step-icon"><i class="fa-solid fa-circle-check"></i></span>
                <span class="step-text">배송완료</span>
                <span class="step-count">0</span>
            </div>
        </div>
    </div>

    <section class="info-section">
        <div class="section-header">
            <span class="section-title">Account Info</span>
        </div>
        <form action="/member/update" method="post">
            <table class="info-table">
                <tr><th>ID</th><td>${sessionScope.loginMember.loginId}</td></tr>
                <tr><th>NAME</th><td><input type="text" name="memberName" value="${sessionScope.loginMember.memberName}" class="editable-input"></td></tr>
                <tr><th>PHONE</th><td><input type="text" name="phoneNumber" value="${sessionScope.loginMember.phoneNumber}" class="editable-input"></td></tr>
                <tr><th>EMAIL</th><td><input type="text" name="email" value="${sessionScope.loginMember.email}" class="editable-input"></td></tr>
            </table>
            <div style="text-align: right;">
                <button type="submit" class="btn-update">Update Info</button>
            </div>
        </form>
    </section>

    <section class="info-section">
        <div class="section-header">
            <span class="section-title">Shipping Address</span>
        </div>
        <jsp:include page="/WEB-INF/views/member/defaultAddress.jsp">
            <jsp:param name="from" value="mypage" />
        </jsp:include>
    </section>

</div>

<jsp:include page="/common/footer.jsp" />

</body>
</html>