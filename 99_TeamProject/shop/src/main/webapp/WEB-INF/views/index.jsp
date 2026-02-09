<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | OFFICIAL STORE</title>
</head>
<body>
<div id="main-wrapper">

    <jsp:include page="/common/header.jsp" />

    <main id="content-body">
        <section class="special-section">
            <h2 id="main-title" class="stitle">COLLECTION</h2>
            <div id="grid-root" class="grid-container"></div>
        </section>
    </main>


    <jsp:include page="/common/footer.jsp" />

</div>

<script src="/js/data.js"></script>
<script src="/js/homepage.js"></script>
</body>
</html>