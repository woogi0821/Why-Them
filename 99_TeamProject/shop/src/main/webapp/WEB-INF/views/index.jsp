<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/common/header.jsp" />

<div class="container">

    <section class="section-wrap">
        <h2 class="sttl">01 / curated suits</h2>

        <div class="grid" id="box-rec">

            <%--
            [미래] 나중에 상품 테이블 연동하면 이렇게 바뀝니다!
            <c:forEach items="${suitList}" var="product">
                <div class="card" onclick="openDetail(...)">
                    <div class="img-box">
                        <img src="${product.imageUrl}">
                    </div>
                    <div class="info">
                        <span class="name">${product.productName}</span>
                        <span class="price">KRW <fmt:formatNumber value="${product.productPrice}"/></span>
                    </div>
                </div>
            </c:forEach>
            --%>

        </div>
    </section>

    <section class="section-wrap">
        <h2 class="sttl">02 / daily archives</h2>
        <div class="grid grid-6" id="box-daily">
        </div>
    </section>

    <section class="section-wrap">
        <h2 class="sttl">03 / editorial pieces</h2>
        <div class="grid" id="box-best">
        </div>
    </section>

</div>

<jsp:include page="/common/footer.jsp" />