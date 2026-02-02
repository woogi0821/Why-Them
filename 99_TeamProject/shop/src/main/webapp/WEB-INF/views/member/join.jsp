<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/common/header_join_only.jsp" />

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
    /* [Lala Boutique 전용 스타일] - 나중에 css 파일로 분리 가능 */
    .join-container { max-width: 500px; margin: 100px auto; padding: 0 20px; }

    .page-title {
        font-family: 'Cormorant Garamond', serif;
        font-size: 40px;
        font-weight: 300;
        text-align: center;
        margin-bottom: 60px;
        text-transform: uppercase;
        letter-spacing: 2px;
    }

    /* 입력 그룹 */
    .input-group { margin-bottom: 30px; position: relative; }
    .input-label {
        display: block;
        font-size: 11px;
        color: #888;
        margin-bottom: 5px;
        text-transform: uppercase;
        letter-spacing: 1px;
    }

    /* 밑줄 스타일 입력창 (프론트 팀원 스타일 적용) */
    .lala-input {
        width: 100%;
        height: 40px;
        border: none;
        border-bottom: 1px solid #ddd;
        font-size: 14px;
        font-family: 'Noto Sans KR', sans-serif;
        outline: none;
        transition: 0.3s;
        border-radius: 0; /* 모바일 둥글게 됨 방지 */
    }
    .lala-input:focus { border-bottom: 1px solid #111; }
    .lala-input::placeholder { color: #ccc; }

    /* 검은색 버튼 스타일 */
    .lala-btn {
        width: 100%;
        height: 55px;
        background: #111;
        color: #fff;
        border: none;
        font-size: 13px;
        letter-spacing: 2px;
        cursor: pointer;
        transition: 0.3s;
        display: flex;
        justify-content: center;
        align-items: center;
        margin-top: 20px;
    }
    .lala-btn:hover { background: #333; }
    .lala-btn-sub {
        background: #fff;
        color: #111;
        border: 1px solid #111;
        margin-top: 10px;
    }

    /* 주소 검색 버튼 (작게) */
    .addr-btn {
        position: absolute;
        right: 0;
        bottom: 10px;
        background: #111;
        color: #fff;
        border: none;
        font-size: 10px;
        padding: 5px 10px;
        cursor: pointer;
    }

    /* 유효성 검사 에러 메시지 (필요 시 사용) */
    .error-msg { color: #d9534f; font-size: 11px; margin-top: 5px; display: none; }
</style>

<div class="join-container">
    <h2 class="page-title">Create Account</h2>

    <form action="/member/join" method="post" onsubmit="return joinCheck()">

        <div class="input-group">
            <label class="input-label">ID</label>
            <input type="text" id="userId" name="userId" class="lala-input" placeholder="아이디를 입력하세요" required>
        </div>

        <div class="input-group">
            <label class="input-label">Password</label>
            <input type="password" id="userPw" name="userPw" class="lala-input" placeholder="8자리 이상 입력하세요" required>
        </div>

        <div class="input-group">
            <label class="input-label">Name</label>
            <input type="text" id="memberName" name="memberName" class="lala-input" placeholder="이름" required>
        </div>

        <div class="input-group">
            <label class="input-label">Email</label>
            <input type="email" id="email" name="email" class="lala-input" placeholder="example@lala.com">
        </div>

        <div class="input-group">
            <label class="input-label">Phone</label>
            <input type="text" id="phoneNumber" name="phoneNumber" class="lala-input" placeholder="010-0000-0000">
        </div>

        <hr style="margin: 40px 0; border: none; border-top: 1px solid #eee;">

        <div class="input-group">
            <label class="input-label">Address</label>
            <div style="position: relative;">
                <input type="text" id="zipCode" name="zipCode" class="lala-input" placeholder="우편번호" readonly style="width: 100%;">
                <button type="button" class="addr-btn" onclick="kakaoPostcode()">SEARCH</button>
            </div>
        </div>

        <div id="wrap" style="display:none; border:1px solid #111; width:100%; height:300px; margin:5px 0; position:relative">
            <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
        </div>

        <div class="input-group">
            <input type="text" id="baseAddress" name="baseAddress" class="lala-input" placeholder="기본 주소" readonly>
        </div>

        <div class="input-group">
            <input type="text" id="detailAddress" name="detailAddress" class="lala-input" placeholder="상세 주소를 입력하세요">
        </div>

        <button type="submit" class="lala-btn">JOIN MEMBER</button>
        <button type="button" class="lala-btn lala-btn-sub" onclick="location.href='/'">CANCEL</button>

    </form>
</div>

<jsp:include page="/common/footer.jsp" />

<script src="/js/join.js"></script>

<script>
    // join.js가 로드된 후에 실행되도록 설정
    // 기존 kakaoPostcode 함수 내부의 theme 설정을 이걸로 참고하세요.
    /*
    theme: {
        bgColor: "#FFFFFF",
        searchBgColor: "#FFFFFF",
        contentBgColor: "#FFFFFF",
        pageBgColor: "#FFFFFF",
        textColor: "#111111",
        queryTextColor: "#111111",
        postcodeTextColor: "#111111",
        emphTextColor: "#111111",
        outlineColor: "#DDDDDD"
    }
    */
</script>