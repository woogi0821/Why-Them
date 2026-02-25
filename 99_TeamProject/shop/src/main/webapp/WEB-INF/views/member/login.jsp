<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 - LALA BOUTIQUE</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300&family=Noto+Sans+KR:wght@100;300&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="/css/member_login.css">
</head>
<body>
<div class="logo" onclick="location.href='${pageContext.request.contextPath}/'">lala boutique</div>

<div class="login-box">
    <form action="${pageContext.request.contextPath}/member/login" method="post">
        <input type="text" name="loginId" placeholder="아이디" required>
        <input type="password" name="loginPw" placeholder="비밀번호" required>

        <c:if test="${param.error == 'true'}">
            <p style="color:red; font-size:12px; margin-bottom:15px; letter-spacing: -0.5px;">
                아이디 또는 비밀번호가 일치하지 않습니다.
            </p>
        </c:if>

        <button type="submit" class="btn-login">로그인</button>
    </form>

    <div class="links">
        <span onclick="location.href='${pageContext.request.contextPath}/member/join'">회원가입</span>
        <span onclick="location.href='${pageContext.request.contextPath}/'">홈으로</span>
    </div>
</div>
<script src="${pageContext.request.contextPath}/js/member_login.js"></script>
</body>
</html>