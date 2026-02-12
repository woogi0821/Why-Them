<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>관리자 페이지</title>
  <style>
    body { margin: 0; font-family: 'Pretendard', sans-serif; background-color: #f4f7f9; display: flex; height: 100vh; overflow: hidden; }
    a { text-decoration: none; color: inherit; }

    /* [좌측 사이드바] */
    .sidebar { width: 240px; background-color: #34495e; color: #ecf0f1; display: flex; flex-direction: column; flex-shrink: 0; }
    .sidebar-header { padding: 30px 20px; font-size: 1.4rem; font-weight: bold; background-color: #2c3e50; text-align: center; }

    /* [메뉴 공통 스타일] */
    .menu-wrapper { position: relative; border-bottom: 1px solid #2c3e50; }
    .menu-main { padding: 18px 25px; display: block; font-size: 1rem; font-weight: bold; background-color: #2980b9; color: #fff; cursor: pointer; }
    .menu-main.promotion { background-color: #27ae60; } /* 프로모션은 다른 색상 강조 */

    /* [Hover 펼치기 설정] */
    .sub-menu-list { max-height: 0; overflow: hidden; background-color: #2c3e50; transition: max-height 0.4s ease-in-out; }
    .menu-wrapper:hover .sub-menu-list { max-height: 500px; }

    .sub-item { padding: 12px 45px; display: block; color: #bdc3c7; font-size: 0.9rem; transition: 0.2s; }
    .sub-item:hover { color: #fff; background-color: #3e4f5f; }
    .sub-item.active { color: #fff; background-color: #1a252f; font-weight: bold; border-left: 4px solid #3498db; }

    /* [우측 콘텐츠 영역] */
    .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
    .top-nav { height: 60px; background: #fff; display: flex; align-items: center; padding: 0 30px; border-bottom: 1px solid #dee2e6; }
    .content-body { padding: 35px; }
    .list-container { background: #fff; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 25px; margin-bottom: 30px; }
    .list-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }

    .btn-add { background: #3498db; color: #fff; padding: 8px 18px; border-radius: 4px; font-size: 0.85rem; font-weight: bold; }

    /* 테이블 공통 스타일 */
    table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    th { background-color: #f8f9fa; text-align: left; padding: 15px; border-bottom: 2px solid #dee2e6; font-size: 0.85rem; color: #666; }
    td { padding: 12px 15px; border-bottom: 1px solid #eee; vertical-align: middle; font-size: 0.9rem; }

    .prod-img { width: 60px; height: 60px; border-radius: 4px; object-fit: cover; border: 1px solid #eee; }
    .status-badge { padding: 4px 8px; border-radius: 20px; font-size: 0.75rem; color: #fff; font-weight: bold; }
    .status-on { background-color: #2ecc71; }
    .status-off { background-color: #95a5a6; }

    .edit-link { color: #3498db; font-weight: bold; margin-right: 12px; }
    .delete-link { color: #e74c3c; font-weight: bold; }
  </style>
</head>
<body>

<div class="sidebar">
  <div class="sidebar-header">ADMIN</div>

  <div class="menu-wrapper">
    <a href="/admin/admin_main" class="menu-main">📦 상품 관리</a>
    <div class="sub-menu-list">
      <a href="/admin/admin_main" class="sub-item ${empty selectedCategory ? 'active' : ''}">전체보기</a>
      <a href="/admin/admin_main?categoryId=1" class="sub-item ${selectedCategory == 1 ? 'active' : ''}">COAT</a>
      <a href="/admin/admin_main?categoryId=2" class="sub-item ${selectedCategory == 2 ? 'active' : ''}">SHIRT</a>
      <a href="/admin/admin_main?categoryId=3" class="sub-item ${selectedCategory == 3 ? 'active' : ''}">SWEATER</a>
      <a href="/admin/admin_main?categoryId=11" class="sub-item ${selectedCategory == 11 ? 'active' : ''}">HAT</a>
    </div>
  </div>

  <div class="menu-wrapper">
    <a href="#" class="menu-main promotion">🔥 프로모션 관리</a>
    <div class="sub-menu-list">
      <a href="/admin/promotion_list" class="sub-item">진행중인 이벤트</a>
      <a href="/admin/coupon_list" class="sub-item">쿠폰 관리</a>
      <a href="/admin/banner_list" class="sub-item">메인 배너 설정</a>
    </div>
  </div>
</div>

<div class="main-content">
  <div class="top-nav">
    <div style="font-size: 0.85rem; color: #7f8c8d;">
      ADMIN / <b>${not empty promotionList ? '프로모션 관리' : '상품 관리'}</b>
    </div>
  </div>

  <div class="content-body">

    <c:if test="${empty promotionList}">
      <div class="list-container">
        <div class="list-header">
          <h2>상품 목록</h2>
          <a href="/admin/product/add" class="btn-add">+ 새 상품 등록</a>
        </div>
        <table>
          <thead>
          <tr>
            <th>번호</th>
            <th>이미지</th>
            <th>상품명</th>
            <th>가격</th>
            <th>관리</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="item" items="${productList}">
            <tr>
              <td>${item.productId}</td>
              <td><img src="${not empty item.imageUrl ? item.imageUrl : '/img/no-image.jpg'}" class="prod-img"></td>
              <td style="font-weight: 600;">${item.name}</td>
              <td><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</td>
              <td>
                <a href="/admin/product/edit?productId=${item.productId}" class="edit-link">수정</a>
                <a href="/admin/product/delete?productId=${item.productId}" class="delete-link" onclick="return confirm('삭제할까요?');">삭제</a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:if>

    <c:if test="${not empty promotionList}">
      <div class="list-container">
        <div class="list-header">
          <h2>진행중인 프로모션</h2>
          <a href="/admin/promotion/add" class="btn-add" style="background-color: #27ae60;">+ 프로모션 등록</a>
        </div>
        <table>
          <thead>
          <tr>
            <th>번호</th>
            <th>프로모션 명</th>
            <th>기간</th>
            <th>상태</th>
            <th>관리</th>
          </tr>
          </thead>
          <tbody>
          <c:forEach var="promo" items="${promotionList}">
            <tr>
              <td>${promo.id}</td>
              <td style="font-weight: bold;">${promo.title}</td>
              <td>${promo.startDate} ~ ${promo.endDate}</td>
              <td>
                                        <span class="status-badge ${promo.active ? 'status-on' : 'status-off'}">
                                            ${promo.active ? '진행중' : '종료'}
                                        </span>
              </td>
              <td>
                <a href="#" class="edit-link">설정</a>
                <a href="#" class="delete-link">중단</a>
              </td>
            </tr>
          </c:forEach>
          </tbody>
        </table>
      </div>
    </c:if>

  </div>
</div>
</body>
</html>