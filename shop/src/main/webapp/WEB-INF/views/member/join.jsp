<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>라라 부티크 | JOIN</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;600&family=Noto+Sans+KR:wght@300;400;700&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/css/join.css">
    <script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

    <style>
        .email-row { display: flex; gap: 5px; align-items: center; }
        .email-row input { width: 35%; }
        .email-row select { width: 30%; height: 42px; border: 1px solid #eee; padding: 0 10px; color: #333; outline: none; }
        #postcode-layer { display:none; position:fixed; overflow:hidden; z-index:9999; -webkit-overflow-scrolling:touch; border:1px solid #000; background:#fff; }
        #btn-close-layer { position:absolute; right:0px; top:0px; z-index:1; cursor:pointer; background:#333; color:#fff; border:none; padding:5px 10px; }
    </style>
</head>
<body>
<div id="join-wrapper">
    <header onclick="location.href='${pageContext.request.contextPath}/main'">
        <div class="logo">lala boutique</div>
    </header>

    <section class="join-container">
        <h2>CREATE ACCOUNT</h2>

        <form action="${pageContext.request.contextPath}/member/join" method="post" id="joinForm">

            <div class="form-group">
                <label>ID</label>
                <div class="input-row">
                    <input type="text" id="loginId" name="loginId" placeholder="아이디 입력" autocomplete="off"
                           value="<c:out value='${param.loginId}'/>">
                    <button type="button" class="btn-sub" onclick="idCheck()">중복확인</button>
                    <input type="hidden" id="idCheckFlag" value="N">
                </div>
            </div>

            <div class="form-group">
                <label>PASSWORD</label>
                <input type="password" id="loginPw" name="loginPw" placeholder="8자리 이상 입력">
            </div>

            <div class="form-group">
                <label>NAME</label>
                <input type="text" id="memberName" name="memberName"
                       value="<c:out value='${param.memberName}'/>">
            </div>

            <div class="form-group">
                <label>PHONE</label>
                <input type="text" id="memberPhone" name="phoneNumber" placeholder="010-0000-0000" maxlength="13" oninput="autoHyphen(this)"
                       value="<c:out value='${param.phoneNumber}'/>">
            </div>

            <c:set var="emailParts" value="${fn:split(param.email, '@')}" />
            <div class="form-group">
                <label>EMAIL</label>
                <div class="email-row">
                    <input type="text" id="emailId" placeholder="이메일" value="<c:out value='${emailParts[0]}'/>">
                    <span>@</span>
                    <input type="text" id="emailDomain" placeholder="직접 입력" value="<c:out value='${emailParts[1]}'/>">
                    <select id="domainSelect" onchange="handleEmailSelect()">
                        <option value="">직접 입력</option>
                        <option value="naver.com">naver.com</option>
                        <option value="gmail.com">gmail.com</option>
                        <option value="daum.net">daum.net</option>
                    </select>
                </div>
                <input type="hidden" id="fullEmail" name="email" value="<c:out value='${param.email}'/>">
            </div>

            <div class="form-group">
                <label>ADDRESS</label>
                <div class="input-row">
                    <input type="text" id="zipCode" name="zipCode" placeholder="우편번호" readonly
                           value="<c:out value='${param.zipCode}'/>">
                    <button type="button" class="btn-sub" onclick="togglePostcode()">검색</button>
                </div>

                <div id="postcode-layer" style="width:100%; height:300px; margin-top:10px; position:relative; display:none;">
                    <button type="button" id="btn-close-layer" onclick="closePostcode()">닫기 X</button>
                </div>

                <input type="text" id="baseAddress" name="address1" placeholder="기본주소" readonly style="margin-top:5px;"
                       value="<c:out value='${param.address1}'/>">
                <input type="text" id="detailAddress" name="address2" placeholder="상세주소 입력" style="margin-top:5px;"
                       value="<c:out value='${param.address2}'/>">
            </div>

            <button type="button" class="btn-submit" onclick="joinCheck()">JOIN NOW</button>
            <button type="button" class="btn-submit" style="background:#fff; color:#000; border:1px solid #ddd; margin-top:10px;" onclick="history.back()">CANCEL</button>
        </form>
    </section>
</div>
<script src="${pageContext.request.contextPath}/js/join.js"></script>
<script>
    <c:if test="${not empty errorMsg}">
    alert("<c:out value='${errorMsg}'/>");
    </c:if>
</script>
</body>
</html>