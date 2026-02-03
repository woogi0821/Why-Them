<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<jsp:include page="/common/header.jsp" />

<div class="container">

    <section class="section-wrap">
        <h2 class="sttl">01 / curated suits</h2>

        <div class="grid" id="box-rec">
<%--    상품테이블 연동      --%>
        </div>
    </section>

    <section class="section-wrap">
        <h2 class="sttl">02 / daily archives</h2>
<%--    상품테이블 연동    --%>
        <div class="grid grid-6" id="box-daily">
        </div>
    </section>

    <section class="section-wrap">
        <h2 class="sttl">03 / editorial pieces</h2>
<%--    상품테이블 연동    --%>
        <div class="grid" id="box-best">
        </div>
    </section>

</div>

<jsp:include page="/common/footer.jsp" />