<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LARA BOUTIQUE | LOGIN</title>

    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400;600&family=Noto+Sans+KR:wght@300;400;500&display=swap" rel="stylesheet">

    <style>
        /* [Lara Boutique 공통 스타일] */
        * { box-sizing: border-box; margin: 0; padding: 0; }

        body {
            font-family: 'Noto Sans KR', sans-serif;
            background-color: #fff; /* 배경은 깔끔한 화이트 */
        }

        /* 컨테이너 (회원가입 페이지와 동일한 규격) */
        .login-container {
            max-width: 500px;
            margin: 120px auto; /* 상단 여백을 넉넉하게 줘서 여유를 줌 */
            padding: 0 20px;
        }

        /* 타이틀 (명조체, 우아한 느낌) */
        .page-title {
            font-family: 'Cormorant Garamond', serif;
            font-size: 45px; /* 조금 더 키움 */
            font-weight: 400;
            text-align: center;
            margin-bottom: 70px;
            text-transform: uppercase;
            letter-spacing: 3px;
            color: #111;
        }

        /* 입력 그룹 */
        .input-group { margin-bottom: 25px; }

        /* 라벨 (작은 영문 표기) */
        .input-label {
            display: block;
            font-size: 11px;
            color: #888;
            margin-bottom: 8px;
            text-transform: uppercase;
            letter-spacing: 1px;
            font-weight: 500;
        }

        /* 밑줄 스타일 입력창 (핵심 디자인) */
        .lala-input {
            width: 100%;
            height: 40px;
            border: none;
            border-bottom: 1px solid #ddd;
            font-size: 15px;
            font-family: 'Noto Sans KR', sans-serif;
            outline: none;
            transition: border-bottom 0.3s;
            padding: 0 5px; /* 텍스트 살짝 띄움 */
            border-radius: 0;
            background: transparent;
        }
        .lala-input:focus {
            border-bottom: 1px solid #111; /* 포커스 시 진한 블랙 라인 */
        }
        .lala-input::placeholder { color: #ccc; }

        /* 메인 버튼 (블랙) */
        .lala-btn {
            width: 100%;
            height: 55px;
            background: #111;
            color: #fff;
            border: none;
            font-size: 14px;
            letter-spacing: 2px;
            cursor: pointer;
            transition: background 0.3s;
            margin-top: 30px;
            text-transform: uppercase; /* 영문 대문자 */
        }
        .lala-btn:hover { background: #333; }

        /* 서브 버튼 (화이트 - 회원가입용) */
        .lala-btn-sub {
            background: #fff;
            color: #111;
            border: 1px solid #ddd; /* 은은한 테두리 */
            margin-top: 10px;
        }
        .lala-btn-sub:hover {
            border-color: #111;
            background: #fafafa;
        }

        /* 하단 링크 (메인으로) */
        .back-link {
            display: block;
            text-align: center;
            margin-top: 40px;
            font-size: 12px;
            color: #999;
            text-decoration: none;
            letter-spacing: 0.5px;
        }
        .back-link:hover { color: #111; text-decoration: underline; }

    </style>
</head>
<body>

<div class="login-container">
    <h2 class="page-title">Login</h2>

    <form action="/member/login" method="post">

        <div class="input-group">
            <label class="input-label">Id</label>
            <input type="text" name="loginId" class="lala-input" required autofocus autocomplete="off">
        </div>

        <div class="input-group">
            <label class="input-label">Password</label>
            <input type="password" name="loginPw" class="lala-input" required>
        </div>

        <button type="submit" class="lala-btn">Log In</button>

        <button type="button" class="lala-btn lala-btn-sub" onclick="location.href='/member/join'">Join Us</button>

    </form>

    <a href="/" class="back-link">Back to Main</a>
</div>


<script>
    const msg = "${msg}";
    if (msg) {
        alert(msg);
    }
</script>

</body>
</html>