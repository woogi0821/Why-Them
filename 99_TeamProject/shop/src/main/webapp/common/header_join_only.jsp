<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:ital,wght@0,300;0,400;1,300&family=Noto+Sans+KR:wght@200;300;400&display=swap" rel="stylesheet">

    <style>
        /* 공통 초기화 */
        body { margin: 0; background: #fff; font-family: 'Noto Sans KR', sans-serif; color: #111; }

        /* 심플 헤더 스타일 (높이를 조금 줄여서 컴팩트하게) */
        .simple-header {
            height: 120px; /* 기존 180px보다 좀 더 슬림하게 */
            display: flex;
            flex-direction: column;
            justify-content: center;
            align-items: center;
            margin-bottom: 40px;
        }

        /* 로고 스타일 (기존과 동일하게 유지해서 브랜드 통일감) */
        .logo {
            font-family: 'Cormorant Garamond', serif;
            font-size: 45px;
            font-weight: 300;
            letter-spacing: 15px;
            cursor: pointer;
            text-transform: lowercase; /* 소문자 유지 */
            color: #111;
            text-decoration: none;
        }

        /* 서브 로고 */
        .sub-logo {
            font-size: 9px;
            letter-spacing: 5px;
            color: #999;
            margin-top: 10px;
            text-transform: uppercase;
        }
    </style>
</head>
<body>

<div class="simple-header">
    <div class="logo" onclick="location.href='/'">lala boutique</div>
    <div class="sub-logo">secure membership join</div> </div>

</body>
</html>