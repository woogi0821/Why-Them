<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
<head>
    <meta charset="UTF-8">
    <title>로그인</title>

    <style>
        /* 임시 스타일 (보기 좋게 가운데 정렬) */
        body { text-align: center; margin-top: 100px; }
        .login-box { display: inline-block; border: 1px solid #ccc; padding: 30px; border-radius: 10px; }
        input { margin: 5px; padding: 10px; width: 200px; }
        button { padding: 10px 20px; background-color: #333; color: white; border: none; cursor: pointer; }
    </style>
</head>
<body>

<div class="login-box">
    <h2>로그인</h2>

    <form action="/member/login" method="post">
        <div>
            <input type="text" name="userId" placeholder="아이디" required autofocus>
        </div>
        <div>
            <input type="password" name="userPw" placeholder="비밀번호" required>
        </div>
        <br>
        <div>
            <button type="submit">로그인</button>
        </div>
    </form>

    <br>
    <a href="/member/join">아직 회원이 아니신가요? (회원가입)</a>
    <br><br>
    <a href="/">메인으로 돌아가기</a>
</div>

<script>
    // 만약 주소창에 ?error=true 같은 게 있다면? (나중을 위한 대비)
    // 현재 컨트롤러 코드에는 쿼리스트링이 없어서 작동 안 할 수 있음 (추후 고도화 예정)
    /*
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.has('error')) {
        alert("아이디 또는 비밀번호가 일치하지 않습니다.");
    }
    */
</script>

</body>
</html>