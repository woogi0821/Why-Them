<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>회원가입 - LALA BOUTIQUE</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400&family=Noto+Sans+KR:wght@200;300;400&display=swap" rel="stylesheet">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
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

        /* [추가] 주소찾기 레이어 스타일 */
        #postcode-layer {
            display: none;
            border: 1px solid #111;
            width: 100%;
            height: 300px;
            margin: 10px 0 30px;
            position: relative;
        }
        #btn-close-layer {
            position: absolute;
            right: 0;
            top: -25px;
            cursor: pointer;
            font-size: 12px;
            color: #111;
            background: none;
            border: none;
        }
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
            <input type="text" id="loginId" name="loginId" class="lala-input" autocomplete="off"
                   value="<c:out value='${param.userId}'/>">
            <button type="button" class="side-btn" onclick="idCheck()">중복 확인</button>
            <input type="hidden" id="idCheckFlag" value="N">
        </div>

        <div class="input-group">
            <label class="input-label">비밀번호</label>
            <input type="password" id="loginPw" name="loginPw" class="lala-input" placeholder="8자리 이상 입력">
        </div>

        <div class="input-group">
            <label class="input-label">이름</label>
            <input type="text" id="memberName" name="name" class="lala-input"
                   value="<c:out value='${param.name}'/>">
        </div>

        <div class="input-group">
            <label class="input-label">휴대폰 번호</label>
            <input type="text" id="memberPhone" name="phoneNumber" class="lala-input"
                   placeholder="010-0000-0000" maxlength="13"
                   oninput="autoHyphen(this)"
                   value="<c:out value='${param.phoneNumber}'/>">
        </div>

        <c:set var="emailParts" value="${fn:split(param.email, '@')}" />

        <div class="input-group">
            <label class="input-label">이메일</label>

            <div style="display: flex; align-items: center; gap: 5px;">
                <input type="text" id="emailId" class="lala-input" style="width: 35%;"
                       placeholder="이메일"
                       value="<c:out value='${emailParts[0]}'/>">

                <span>@</span>

                <input type="text" id="emailDomain" class="lala-input" style="width: 30%;"
                       placeholder="직접 입력"
                       value="<c:out value='${emailParts[1]}'/>">

                <select id="domainSelect" class="lala-input" style="width: 30%; border: none; border-bottom: 1px solid #eee; height: 45px; color:#555;" onchange="handleEmailSelect()">
                    <option value="">직접 입력</option>
                    <option value="naver.com">naver.com</option>
                    <option value="gmail.com">gmail.com</option>
                    <option value="daum.net">daum.net</option>
                </select>
            </div>

            <input type="hidden" id="fullEmail" name="email" value="<c:out value='${param.email}'/>">
        </div>

        <div class="input-group">
            <label class="input-label">주소</label>
            <input type="text" id="zipCode" name="zipCode" class="lala-input" readonly placeholder="우편번호"
                   value="<c:out value='${param.zipCode}'/>">
            <button type="button" class="side-btn" onclick="togglePostcode()">주소 찾기</button>
        </div>

        <div id="postcode-layer">
            <button type="button" id="btn-close-layer" onclick="closePostcode()">[닫기 X]</button>
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
    const autoHyphen = (target) => {
        target.value = target.value
            .replace(/[^0-9]/g, '')
            .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
    }

    var element_layer = document.getElementById('postcode-layer');

    function closePostcode() {
        element_layer.style.display = 'none';
    }
    function handleEmailSelect() {
        const select = document.getElementById("domainSelect");
        const domainInput = document.getElementById("emailDomain");

        if (select.value !== ""){
            domainInput.value = select.value;
            domainInput.readOnly = true;
            domainInput.style.backgroundColor = "#f9f9f9";
        }else {
            domainInput.value = "";
            domainInput.readOnly = false;
            domainInput.style.backgroundColor = "transparent";
            domainInput.focus();
        }

    }

    function togglePostcode() {

        if(element_layer.style.display === 'block') {
            closePostcode();
            return;
        }

        new daum.Postcode({
            oncomplete: function(data) {
                var addr = '';
                var extraAddr = '';

                if (data.userSelectedType === 'R') {
                    addr = data.roadAddress;
                } else {
                    addr = data.jibunAddress;
                }

                document.getElementById('zipCode').value = data.zonecode;
                document.getElementById("baseAddress").value = addr;
                document.getElementById("detailAddress").focus();


                element_layer.style.display = 'none';
            },
            width : '100%',
            height : '100%',
            maxSuggestItems : 5
        }).embed(element_layer);

        // 레이어 보여주기
        element_layer.style.display = 'block';
    }

    // 3. 아이디 중복체크 (기존 로직 유지 + AJAX 필요 주석)
    function idCheck() {
        const id = document.getElementById("loginId").value;
        if(id.length < 4) {
            alert("아이디를 4자 이상 입력해주세요.");
            return;
        }
        alert("사용 가능한 아이디입니다.");
        document.getElementById("idCheckFlag").value = "Y";
    }

    // 4. 유효성 검사
    function joinCheck() {
        const id = document.getElementById("loginId").value;
        const pw = document.getElementById("loginPw").value;
        const name = document.getElementById("memberName").value;
        const phone = document.getElementById("memberPhone").value; // 폰번호 체크 추가
        const emailId = document.getElementById("emailId").value;
        const emailDomain = document.getElementById("emailDomain").value;

        if (emailId && emailDomain) {
            document.getElementById("fullEmail").value = emailId + "@" + emailDomain
        } else {
            alert("이메일을 정확히 입력해주세요.")
            return;
        }

        if(!id || !pw || !name || !phone) {
            alert("필수 항목을 모두 입력해주세요.");
            return;
        }
        if(pw.length < 8) {
            alert("비밀번호를 8자 이상 입력해주세요.");
            return;
        }
        document.getElementById("joinForm").submit();
    }

    // 서버 에러 메시지 처리
    <c:if test="${not empty errorMsg}">
    alert("<c:out value='${errorMsg}'/>");
    </c:if>
</script>
</body>
</html>