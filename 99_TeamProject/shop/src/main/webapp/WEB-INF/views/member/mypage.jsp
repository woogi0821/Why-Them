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
    <link rel="stylesheet" href="/css/mypage.css">

</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="mypage-container">

    <div class="welcome-box">
        <div class="user-greeting">HELLO, <strong>${sessionScope.loginMember.memberName}</strong></div>
        <div class="welcome-desc">라라 부티크에 오신 것을 환영합니다. 나의 쇼핑 정보를 확인하세요.</div>
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
        <a href="javascript:void(0)" class="quick-item" onclick="showPasswordSection()">
            <span class="quick-icon"><i class="fa-solid fa-lock"></i></span>
            <span class="quick-text">Change Password</span>
        </a>
    </div>

    <div class="order-status-wrap">
        <div class="section-header" style="margin-top:0; border-bottom:none;">
            <span class="section-title" style="font-size:18px;">Order Status</span>
        </div>
        <div class="status-list">
            <div class="status-step"><span class="step-icon"><i class="fa-solid fa-file-invoice-dollar"></i></span><span class="step-text">입금대기</span><span class="step-count">0</span></div>
            <div class="status-step"><span class="step-icon"><i class="fa-solid fa-box-open"></i></span><span class="step-text">결제완료</span><span class="step-count">0</span></div>
            <div class="status-step"><span class="step-icon"><i class="fa-solid fa-gift"></i></span><span class="step-text">배송준비</span><span class="step-count">0</span></div>
            <div class="status-step"><span class="step-icon"><i class="fa-solid fa-truck-fast"></i></span><span class="step-text">배송중</span><span class="step-count">0</span></div>
            <div class="status-step"><span class="step-icon"><i class="fa-solid fa-circle-check"></i></span><span class="step-text">배송완료</span><span class="step-count">0</span></div>
        </div>
    </div>

    <section class="info-section">
        <div class="section-header">
            <span class="section-title">Account Info</span>
        </div>

        <form action="/member/update" method="post" onsubmit="return validateForm()">
            <input type="hidden" id="originalId" value="${sessionScope.loginMember.loginId}">
            <input type="hidden" id="idCheckStatus" value="1">

            <div class="info-row">
                <div class="info-label">User ID</div>
                <div class="info-value">
                    <input type="text" name="loginId" id="loginId"
                           value="${sessionScope.loginMember.loginId}"
                           class="clean-input" placeholder="아이디를 입력하세요"
                           oninput="resetIdCheck()">
                    <button type="button" class="btn-check-square" onclick="checkDuplicateId()">Check</button>
                </div>
                <span id="checkMsg" class="msg-area"></span>
            </div>

            <div class="info-row">
                <div class="info-label">Name</div>
                <div class="info-value">
                    <input type="text" name="memberName"
                           value="${sessionScope.loginMember.memberName}"
                           class="clean-input" readonly>
                </div>
            </div>

            <div class="info-row">
                <div class="info-label">Phone</div>
                <div class="info-value">
                    <input type="text" name="phoneNumber"
                           value="${sessionScope.loginMember.phoneNumber}"
                           class="clean-input" placeholder="전화번호를 입력하세요">
                </div>
            </div>

            <div class="info-row">
                <div class="info-label">Email</div>
                <div class="info-value">
                    <input type="text" name="email"
                           value="${sessionScope.loginMember.email}"
                           class="clean-input" placeholder="이메일을 입력하세요">
                </div>
            </div>

            <div style="text-align: right;">
                <button type="submit" class="btn-update">Save Changes</button>
            </div>
        </form>
    </section>
    <section class="info-section" id="password-section" style="display: none;">
        <div class="section-header">
            <span class="section-title">Security & Password</span>
        </div>

        <form action="/member/resetPw" method="post" onsubmit="return validateResetForm()">
            <div style="margin-bottom: 25px; padding: 15px; background: #f9f9f9; font-size: 12px; color: #666; line-height: 1.5;">
                <i class="fa-solid fa-shield-halved" style="margin-right: 5px;"></i>
                안전한 비밀번호 변경을 위해 <strong>아이디와 본인 확인 정보</strong>를 모두 입력해주세요.<br>
                입력하신 정보가 일치할 경우 새 비밀번호로 즉시 변경됩니다.
            </div>

            <div class="info-row">
                <div class="info-label">Check ID</div>
                <div class="info-value">
                    <input type="text" name="loginId" id="verifyId"
                           class="clean-input" placeholder="아이디를 입력하세요">
                </div>
            </div>

            <div class="info-row">
                <div class="info-label">Verify Name</div>
                <div class="info-value">
                    <input type="text" name="memberName" id="verifyName"
                           class="clean-input" placeholder="가입 시 등록한 이름을 입력하세요">
                </div>
            </div>

            <div class="info-row">
                <div class="info-label">Verify Phone</div>
                <div class="info-value">
                    <input type="text" name="phoneNumber" id="verifyPhone"
                           class="clean-input" placeholder="가입 시 등록한 전화번호를 입력하세요">
                </div>
            </div>

            <div class="info-row">
                <div class="info-label">New PW</div>
                <div class="info-value">
                    <input type="password" name="newPw" id="newPw"
                           class="clean-input" placeholder="새로운 비밀번호">
                </div>
            </div>

            <div class="info-row">
                <div class="info-label">Confirm PW</div>
                <div class="info-value">
                    <input type="password" id="confirmPw"
                           class="clean-input" placeholder="새로운 비밀번호 확인">
                </div>
                <span id="pwMsg" class="msg-area"></span>
            </div>

            <div style="text-align: right;">
                <button type="submit" class="btn-update" style="background: #1a1a1a; color: #fff;">Change Password</button>
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

<script src="/js/mypage.js"></script>

</body>
</html>