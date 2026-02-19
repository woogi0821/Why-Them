<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8"%>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!DOCTYPE html>
<html>
<head>
    <title>LALA BOUTIQUE | ERROR</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
    <link rel="stylesheet" href="/css/style.css">
    <link rel="icon" type="image/png" href="/images/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="/images/favicon.svg" />
    <link rel="shortcut icon" href="/images/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/images/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="LALA BOUTIQUE" />
    <link rel="manifest" href="/images/site.webmanifest" />

    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@400;600&family=Noto+Sans+KR:wght@300;400&display=swap" rel="stylesheet">
</head>
<body class="flex flex-col min-h-screen">

<jsp:include page="/common/header.jsp" />

<div class="flex-grow flex items-center justify-center px-4 py-20">
    <div class="max-w-2xl w-full text-center">

        <p class="font-serif text-6xl text-gray-200 font-bold mb-4 select-none">OOPS!</p>

        <h1 class="font-serif text-3xl md:text-4xl text-gray-900 mb-6 tracking-widest uppercase">
            Temporarily Unavailable
        </h1>

        <p class="text-gray-500 mb-10 font-light">
            죄송합니다. 요청하신 작업을 처리하는 중 오류가 발생했습니다.<br>
            잠시 후 다시 시도해 주세요.
        </p>

        <c:if test="${not empty errors}">
            <div class="bg-gray-50 border border-gray-200 p-6 mb-10 text-left mx-auto shadow-sm">
                <p class="text-xs text-gray-400 font-bold mb-2 uppercase tracking-wide">Error Details:</p>
                <p class="font-mono text-sm text-red-800 break-all leading-relaxed">
                        ${errors}
                </p>
            </div>
        </c:if>

        <a href="/" class="inline-block bg-gray-900 text-white px-8 py-3 text-xs uppercase tracking-[0.2em] hover:bg-gray-700 transition-colors duration-300">
            Back to Home
        </a>
    </div>
</div>

<jsp:include page="/common/footer.jsp" />

</body>
</html>