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
    <link rel="icon" type="image/png" href="/images/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="/images/favicon.svg" />
    <link rel="shortcut icon" href="/images/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/images/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="LALA BOUTIQUE" />
    <link rel="manifest" href="/images/site.webmanifest" />

</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="mypage-container">

    <div class="welcome-box">
        <div class="user-greeting">HELLO, <strong>${sessionScope.loginMember.memberName}</strong></div>
        <div class="welcome-desc">라라 부티크에 오신 것을 환영합니다. 나의 쇼핑 정보를 확인하세요.</div>
    </div>

    <%-- ★ [수정] 2x2 퀵 메뉴 그리드 (회원탈퇴 추가) --%>
    <div class="quick-menu-grid" style="display: grid; grid-template-columns: repeat(2, 1fr); gap: 15px; margin-bottom: 40px;">
        <a href="<c:url value='/wishlist/list'/>" class="quick-item">
            <span class="quick-icon"><i class="fa-regular fa-heart"></i></span>
            <span class="quick-text"><c:out value="Wishlist"/></span>
        </a>

        <a href="<c:url value='/order/list'/>" class="quick-item">
            <span class="quick-icon"><i class="fa-solid fa-bag-shopping"></i></span>
            <span class="quick-text"><c:out value="Order History"/></span>
        </a>

        <a href="javascript:void(0)" class="quick-item" onclick="showPasswordSection()">
            <span class="quick-icon"><i class="fa-solid fa-lock"></i></span>
            <span class="quick-text"><c:out value="Change Password"/></span>
        </a>

        <a href="javascript:void(0)" class="quick-item" onclick="withdrawMember()">
            <span class="quick-icon"><i class="fa-solid fa-user-slash"></i></span>
            <span class="quick-text"><c:out value="Delete Account"/></span>
        </a>
    </div>

    <%-- (주문 상태 및 개인정보 수정 섹션은 기존 코드 유지...) --%>

    <%-- ★ [수정] 안전한 비밀번호 변경 섹션 --%>
    <section class="info-section" id="password-section" style="display: none;">
        <div class="section-header">
            <span class="section-title">Security & Password</span>
        </div>

        <form action="/member/resetPw" method="post" id="pwChangeForm" onsubmit="return validateMyPageResetForm()">
            <%-- 기존 컨트롤러에 필요한 정보를 세션에서 뽑아 몰래(Hidden) 보냅니다 --%>
            <input type="hidden" name="loginId" value="${sessionScope.loginMember.loginId}">
            <input type="hidden" name="memberName" value="${sessionScope.loginMember.memberName}">
            <input type="hidden" name="phoneNumber" value="${sessionScope.loginMember.phoneNumber}">
            <input type="hidden" name="from" value="mypage">

            <div style="margin-bottom: 25px; padding: 15px; background: #f9f9f9; font-size: 12px; color: #666; line-height: 1.5;">
                <i class="fa-solid fa-shield-halved" style="margin-right: 5px;"></i>
                안전한 정보 보호를 위해 <strong>현재 비밀번호</strong>를 먼저 확인합니다.
            </div>

            <div class="info-row">
                <div class="info-label">Current PW</div>
                <div class="info-value">
                    <input type="password" id="currentPw" class="clean-input" placeholder="현재 비밀번호를 입력하세요">
                    <button type="button" class="btn-check-square" onclick="verifyCurrentPw()">Check</button>
                </div>
                <span id="currentPwMsg" class="msg-area"></span>
            </div>

            <%-- 현재 비밀번호가 맞아야만 아래 새 비밀번호 창이 나타납니다 --%>
            <div id="newPwArea" style="display: none;">
                <div class="info-row">
                    <div class="info-label">New PW</div>
                    <div class="info-value">
                        <input type="password" name="newPw" id="newPw" class="clean-input" placeholder="새로운 비밀번호" oninput="checkNewPwMatch()">
                    </div>
                </div>

                <div class="info-row">
                    <div class="info-label">Confirm PW</div>
                    <div class="info-value">
                        <input type="password" id="confirmPw" class="clean-input" placeholder="새로운 비밀번호 확인" oninput="checkNewPwMatch()">
                    </div>
                    <span id="pwMsg" class="msg-area"></span>
                </div>

                <div style="text-align: right;">
                    <button type="submit" class="btn-update" style="background: #1a1a1a; color: #fff;">Change Password</button>
                </div>
            </div>
        </form>
    </section>

    <%-- (배송지 섹션 기존 코드 유지...) --%>
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
                           class="clean-input" placeholder="가입 시 등록한 번호를 입력하세요"
                           oninput="autoHyphen(this)" maxlength="13">
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