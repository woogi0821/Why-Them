<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>로그인 - LALA BOUTIQUE</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300&family=Noto+Sans+KR:wght@100;300&display=swap" rel="stylesheet">
    <style>
        * { margin: 0; padding: 0; box-sizing: border-box; }
        body { height: 100vh; display: flex; flex-direction: column; justify-content: center; align-items: center; background: #fff; font-family: 'Noto Sans KR', sans-serif; }
        .logo { font-family: 'Cormorant Garamond', serif; font-size: 42px; letter-spacing: 20px; margin-bottom: 80px; cursor: pointer; }
        .login-box { width: 320px; text-align: center; }
        input { width: 100%; height: 45px; border: none; border-bottom: 1px solid #eee; margin-bottom: 25px; outline: none; font-size: 14px; transition: 0.3s; }
        input:focus { border-bottom: 1px solid #111; }
        .btn-login { width: 100%; height: 60px; background: #111; color: #fff; border: none; font-size: 13px; letter-spacing: 2px; cursor: pointer; margin-top: 30px; }
        .links { margin-top: 40px; display: flex; justify-content: center; gap: 40px; font-size: 12px; color: #bbb; }
        .links span { cursor: pointer; transition: 0.2s; }
        .links span:hover { color: #111; }
    </style>
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
<script>
    window.onload = function () {
        const urlParams = new URLSearchParams(window.location.search);
        const msg = urlParams.get('msg');

        if (msg === 'session_expired'){
            alert("개인정보 보호를 위해 세션이 만료되었습니다.\n다시 로그인 해주세요.")
        }
    }
</script>
</body>
</html>