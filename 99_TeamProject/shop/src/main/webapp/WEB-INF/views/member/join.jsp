<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 - LALA BOUTIQUE</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400&family=Noto+Sans+KR:wght@200;300;400&display=swap" rel="stylesheet">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>
    <style>
        /* 기존 스타일 그대로 유지 */
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { background: #fff; font-family: 'Noto Sans KR', sans-serif; color: #111; }
        .simple-header { height: 180px; display: flex; flex-direction: column; justify-content: center; align-items: center; cursor: pointer; }
        .logo { font-family: 'Cormorant Garamond', serif; font-size: 42px; letter-spacing: 20px; text-transform: lowercase; color: #111; text-decoration: none; }
        .join-container { max-width: 420px; margin: 0 auto 120px; padding: 0 20px; }
        .input-group { margin-bottom: 40px; position: relative; }
        .input-label { font-size: 10px; color: #aaa; letter-spacing: 2px; text-transform: uppercase; margin-bottom: 12px; display: block; }
        .lala-input { width: 100%; height: 45px; border: none; border-bottom: 1px solid #eee; font-size: 14px; outline: none; transition: 0.3s; background: transparent; }
        .lala-input:focus { border-bottom: 1px solid #111; }
        .side-btn { position: absolute; right: 0; bottom: 10px; background: none; border: none; border-bottom: 1px solid #111; font-size: 11px; cursor: pointer; padding: 2px 0; color: #333; }
        .lala-btn { width: 100%; height: 60px; background: #111; color: #fff; border: none; font-size: 13px; letter-spacing: 2px; cursor: pointer; margin-top: 50px; }
        .lala-btn-sub { width: 100%; background: #fff; color: #bbb; border: none; font-size: 11px; letter-spacing: 1px; cursor: pointer; margin-top: 15px; }
    </style>
</head>
<body>
<div class="simple-header" onclick="location.href='${pageContext.request.contextPath}/'">
    <div class="logo">lala boutique</div>
</div>

<div class="join-container">
    <form action="${pageContext.request.contextPath}/member/join" method="post" id="joinForm">

        <div class="input-group">
            <label class="input-label">아이디</label>
            <input type="text" id="userId" name="userId" class="lala-input" autocomplete="off"
                   value="<c:out value='${param.userId}'/>">
            <button type="button" class="side-btn" onclick="idCheck()">중복 확인</button>
            <input type="hidden" id="idCheckFlag" value="N"> </div>

        <div class="input-group">
            <label class="input-label">비밀번호</label>
            <input type="password" id="userPw" name="userPw" class="lala-input" placeholder="8자리 이상 입력">
        </div>

        <div class="input-group">
            <label class="input-label">이름</label>
            <input type="text" id="memberName" name="name" class="lala-input"
                   value="<c:out value='${param.name}'/>">
        </div>

        <div class="input-group">
            <label class="input-label">주소</label>
            <input type="text" id="zipCode" name="zipCode" class="lala-input" readonly placeholder="우편번호"
                   value="<c:out value='${param.zipCode}'/>">
            <button type="button" class="side-btn" onclick="kakaoPostcode()">주소 찾기</button>
        </div>

        <div style="margin-top: -15px;">
            <input type="text" id="baseAddress" name="address1" class="lala-input" placeholder="기본 주소" readonly style="margin-bottom:20px;"
                   value="<c:out value='${param.address1}'/>">
            <input type="text" id="detailAddress" name="address2" class="lala-input" placeholder="상세 주소 입력"
                   value="<c:out value='${param.address2}'/>">
        </div>

        <button type="button" class="lala-btn" onclick="joinCheck()">계정 만들기</button>
        <button type="button" class="lala-btn-sub" onclick="history.back()">뒤로가기</button>
    </form>
</div>

<script>
    // 아이디 중복 확인 (AJAX로 변환 필요 - 여기서는 예시 구조만 잡음)
    function idCheck() {
        const id = document.getElementById("userId").value;
        if(id.length < 4) {
            alert("아이디를 4자 이상 입력해주세요.");
            return;
        }

        // [실제 개발 시] fetch()나 $.ajax()를 사용하여 서버(/member/idCheck)로 요청을 보내야 함
        // 현재는 프론트엔드 예시이므로 팝업으로 대체하거나 바로 성공 처리

        // window.open('${pageContext.request.contextPath}/member/idCheckPopup?id=' + id, 'chk', 'width=400,height=300');
        // 또는 비동기 통신 후:

        alert("사용 가능한 아이디입니다. (서버 연결 필요)");
        document.getElementById("idCheckFlag").value = "Y"; // 중복확인 완료 플래그
        document.getElementById("userId").readOnly = true; // 아이디 수정 불가 처리
    }

    // 회원가입 유효성 검사 및 전송
    function joinCheck() {
        const id = document.getElementById("userId").value;
        const pw = document.getElementById("userPw").value;
        const name = document.getElementById("memberName").value;
        const idCheckFlag = document.getElementById("idCheckFlag").value;

        if(!id || !pw || !name) {
            alert("필수 항목을 모두 입력해주세요.");
            return;
        }
        if(pw.length < 8) {
            alert("비밀번호를 8자 이상 입력해주세요.");
            return;
        }
        // 실제 서비스에선 중복확인을 강제해야 함
        /*
        if(idCheckFlag !== "Y") {
            alert("아이디 중복 확인을 진행해주세요.");
            return;
        }
        */

        // 모든 검사 통과 시 폼 전송 (Controller로 이동)
        document.getElementById("joinForm").submit();
    }

    // 카카오 주소 API (기존 유지)
    function kakaoPostcode() {
        new daum.Postcode({
            oncomplete: function(data) {
                document.getElementById('zipCode').value = data.zonecode;
                document.getElementById('baseAddress').value = data.roadAddress;
                document.getElementById('detailAddress').focus();
            }
        }).open();
    }

    // [추가] 서버에서 에러 메시지를 보냈을 경우 처리 (예: 중복된 아이디 등)
    <c:if test="${not empty errorMsg}">
    alert("<c:out value='${errorMsg}'/>");
    </c:if>
</script>
</body>
</html>