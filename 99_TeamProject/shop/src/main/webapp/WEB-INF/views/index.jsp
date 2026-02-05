<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>라라 부티크 | LALA BOUTIQUE</title>
    <link href="https://fonts.googleapis.com/css2?family=Cormorant+Garamond:wght@300;400&family=Noto+Sans+KR:wght@100;300;400;500&display=swap" rel="stylesheet">
    <link rel="stylesheet" href="${pageContext.request.contextPath}/resources/css/homepage.css">
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="search-filter-section">
    <form action="${pageContext.request.contextPath}/product/search" method="get" class="search-box">
        <input type="text" name="keyword" placeholder="SEARCH" value="<c:out value='${param.keyword}'/>">
        <button type="submit" style="background:none; border:none; cursor:pointer;">🔍</button>
    </form>

    <div class="filter-btns">
        <button onclick="location.href='?sort=new'" class="${param.sort == 'new' or empty param.sort ? 'active' : ''}">신상품순</button>
        <button onclick="location.href='?sort=low'" class="${param.sort == 'low' ? 'active' : ''}">가격 낮은 순</button>
        <button onclick="location.href='?sort=high'" class="${param.sort == 'high' ? 'active' : ''}">가격 높은 순</button>
    </div>
</div>

<main id="main-content">
    <c:if test="${not empty param.keyword}">
        <h2 class="section-title">RESULTS: <c:out value="${param.keyword}" /></h2>
    </c:if>

    <c:if test="${empty param.keyword}">
        <h2 class="section-title">NEW ARRIVALS</h2>
    </c:if>

    <div class="grid grid-4">
        <c:choose>
            <c:when test="${empty productList}">
                <p style="text-align:center; width:100%; padding:50px;">등록된 상품이 없습니다.</p>
            </c:when>
            <c:otherwise>
                <c:forEach var="p" items="${productList}">
                    <div class="card" onclick="location.href='${pageContext.request.contextPath}/product/detail?id=${p.productId}'">
                        <div class="img-box">
                            <img src="${pageContext.request.contextPath}/resources/img/${p.category}/${p.productId}.jpg"
                                 alt="<c:out value='${p.name}' />">
                        </div>
                        <div class="info-text">
                            <p class="p-name"><c:out value="${p.name}" /></p>
                            <p class="p-price">
                                ₩ <fmt:formatNumber value="${p.price}" pattern="#,###" />
                            </p>
                        </div>
                    </div>
                </c:forEach>
            </c:otherwise>
        </c:choose>
    </div>
</main>

<jsp:include page="/common/footer.jsp" />

</body>
</html>