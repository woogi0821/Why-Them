<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html>
<head>
  <meta charset="UTF-8">
  <title>PROMOTIONS</title>
  <style>
    .event-title {
      text-align: center;
      font-family: 'Cormorant Garamond', serif; /* 가라몬드 폰트 적용 */
      letter-spacing: 12px;   /* 글자 간격을 넓게 벌림 */
      margin: 80px 0 60px;
      font-size: 1.8rem;
      font-weight: 300;
      text-transform: uppercase; /* 영문일 경우 대문자 변환 */
      color: #1a1a1a;
    }
    .promotion-container {
      max-width: 1200px;
      margin: 50px auto;
      display: grid;
      grid-template-columns: repeat(2, 1fr);
      gap: 30px;
      padding: 0 20px;
    }
    .promotion-item {
      position: relative;
      overflow: hidden;
      border-radius: 12px;
      transition: transform 0.3s ease;
    }
    .promotion-item img {
      width: 100%;
      height: auto;
      display: block;
    }
    /* 종료된 프로모션용 흑백 필터 */
    .ended {
      filter: grayscale(80%) brightness(0.6);
    }
    .status-badge {
      position: absolute;
      top: 20px; right: 20px;
      padding: 8px 15px;
      color: white;
      font-weight: bold;
      border-radius: 5px;
      z-index: 10;
    }
    .badge-ongoing { background-color: #e74c3c; } /* 진행중: 빨강 */
    .badge-ended { background-color: #7f8c8d; }   /* 종료: 회색 */

    h2 { text-align: center; margin-top: 50px; font-family: 'Arial', sans-serif; }
  </style>
</head>
<body>

<jsp:include page="/common/header.jsp" />

<div class="container mx-auto"> <c:set var="status" value="${param.status}" />

<h2 class="event-title">
  <c:choose>
    <c:when test="${status == 'ongoing'}">Active Sales</c:when>
    <c:when test="${status == 'ended'}">Ended Sales</c:when>
    <c:otherwise>ALL PROMOTIONS</c:otherwise>
  </c:choose>
</h2>

<div class="promotion-container">

  <%-- 1. 진행 중인 프로모션 (status=ongoing) --%>
  <c:if test="${status == 'ongoing'}">
    <div class="promotion-item">
      <span class="status-badge badge-ongoing">진행중</span>
      <a href="/product/detail?productId=118"> <img src="/upload/event_ootd.png" alt="OOTD 이벤트"></a>
    </div>
    <div class="promotion-item">
      <span class="status-badge badge-ongoing">진행중</span>
      <a href="/product/detail?productId=47"> <img src="/upload/daily_basic.png" alt="데일리 베이직"></a>
    </div>
    <div class="promotion-item">
      <span class="status-badge badge-ongoing">진행중</span>
      <a href="/product/detail?productId=102"><img src="/upload/weekly_dress.png" alt="개강 코디"></a>
    </div>
    <div class="promotion-item">
      <span class="status-badge badge-ongoing">진행중</span>
      <a href="/product/detail?productId=34"><img src="/upload/outer_preview.png" alt="아우터 프리뷰"></a>
    </div>
  </c:if>

  <%-- 2. 종료된 프로모션 (status=ended) --%>
  <c:if test="${status == 'ended'}">
    <div class="promotion-item ended">
      <span class="status-badge badge-ended">종료됨</span>
      <img src="/upload/banner_01.jpg" alt="Winter Clearance">
    </div>
    <div class="promotion-item ended">
      <span class="status-badge badge-ended">종료됨</span>
      <img src="/upload/banner_02.jpg" alt="로맨틱 여친룩">
    </div>
    <div class="promotion-item ended">
      <span class="status-badge badge-ended">종료됨</span>
      <img src="/upload/banner_03.jpg" alt="단아한 며느리룩">
    </div>
    <div class="promotion-item ended">
      <span class="status-badge badge-ended">종료됨</span>
      <img src="/upload/banner_04.jpg" alt="니트 가디건">
    </div>
  </c:if>

</div>

</body>
</html>