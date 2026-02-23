<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>관리자 페이지</title>
  <style>
    /* 스크린샷 디자인 기반 스타일 복구 */
    * { margin: 0; padding: 0; box-sizing: border-box; }
    body { font-family: 'Pretendard', sans-serif; background-color: #f4f7f9; display: flex; height: 100vh; overflow: hidden; }
    a { text-decoration: none; color: inherit; }

    /* 사이드바 스타일 (스크린샷 일치) */
    .sidebar { width: 240px; background-color: #34495e; color: #ecf0f1; display: flex; flex-direction: column; flex-shrink: 0; }
    .sidebar-header { padding: 30px 20px; font-size: 1.4rem; font-weight: bold; background-color: #2c3e50; text-align: center; cursor: pointer; }
    .sidebar-header a { color: #fff; letter-spacing: 2px; }
    .menu-section { border-bottom: 1px solid #455a64; }
    .menu-title { padding: 18px 25px; font-size: 0.9rem; font-weight: bold; background-color: #2c3e50; display: flex; align-items: center; gap: 8px; }
    .category-list { background-color: #34495e; }
    .category-item { padding: 12px 45px; display: block; color: #bdc3c7; font-size: 0.85rem; transition: 0.2s; border-left: 4px solid transparent; }
    .category-item:hover { color: #fff; background-color: #3e4f5f; }
    .category-item.active { color: #fff; background-color: #1a252f; font-weight: bold; border-left: 4px solid #3498db; }

    /* 메인 영역 스타일 */
    .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
    .top-breadcrumb { padding: 15px 30px; font-size: 0.8rem; color: #888; background: #fff; border-bottom: 1px solid #eee; }
    .content-body { padding: 30px 40px; width: 100%; max-width: 1400px; margin: 0 auto; }

    /* 상품 목록 & 대시보드 공통 컨테이너 */
    .list-container { background: #fff; border-radius: 4px; box-shadow: 0 2px 10px rgba(0,0,0,0.05); padding: 30px; position: relative; }
    .content-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 30px; }
    .content-header h2 { font-size: 1.4rem; color: #333; }

    /* 상품 등록 버튼 (스크린샷 위치) */
    .btn-add { background-color: #3498db; color: #fff; padding: 8px 16px; border-radius: 4px; font-size: 0.85rem; font-weight: bold; }

    /* 테이블 스타일 (스크린샷 일치) */
    .list-table { width: 100%; border-collapse: collapse; margin-top: 10px; }
    .list-table th { border-bottom: 1px solid #eee; padding: 15px; text-align: left; font-size: 0.85rem; color: #888; font-weight: normal; }
    .list-table td { padding: 15px; border-bottom: 1px solid #f9f9f9; font-size: 0.9rem; color: #333; vertical-align: middle; }
    .prod-img { width: 50px; height: 60px; object-fit: cover; border-radius: 2px; }
    .btn-edit { color: #3498db; margin-right: 10px; }
    .btn-del { color: #e74c3c; background: none; border: none; cursor: pointer; font-size: 0.9rem; }

    /* 대시보드 카드 스타일 */
    .dashboard-grid { display: grid; grid-template-columns: 1fr 1fr; gap: 20px; margin-top: 20px; }
    .card { background: #f8f9fa; border-radius: 8px; padding: 20px; border: 1px solid #eee; }
    .card-title { font-size: 0.85rem; color: #7f8c8d; margin-bottom: 15px; font-weight: bold; display: flex; align-items: center; gap: 5px; }
    .card-value { font-size: 1.5rem; font-weight: bold; color: #2c3e50; }
  </style>
</head>
<body>

<aside class="sidebar">
  <div class="sidebar-header">
    <a href="/">HOME</a> </div>

  <div class="menu-section">
    <div class="menu-title">📦 상품 관리</div>
    <div class="category-list">
      <a href="/admin/admin_main" class="category-item ${empty selectedCategory ? 'active' : ''}">전체보기</a>
      <a href="/admin/admin_main?categoryId=1" class="category-item ${selectedCategory == 1 ? 'active' : ''}">COAT</a>
      <a href="/admin/admin_main?categoryId=2" class="category-item ${selectedCategory == 2 ? 'active' : ''}">SHIRT</a>
      <a href="/admin/admin_main?categoryId=3" class="category-item ${selectedCategory == 3 ? 'active' : ''}">SWEATER</a>
      <a href="/admin/admin_main?categoryId=4" class="category-item ${selectedCategory == 4 ? 'active' : ''}">PANTS</a>
      <a href="/admin/admin_main?categoryId=5" class="category-item ${selectedCategory == 5 ? 'active' : ''}">SKIRTS</a>
      <a href="/admin/admin_main?categoryId=6" class="category-item ${selectedCategory == 6 ? 'active' : ''}">DRESS</a>
      <a href="/admin/admin_main?categoryId=7" class="category-item ${selectedCategory == 7 ? 'active' : ''}">SUIT</a>
      <a href="/admin/admin_main?categoryId=8" class="category-item ${selectedCategory == 8 ? 'active' : ''}">SHOSE</a>
      <a href="/admin/admin_main?categoryId=9" class="category-item ${selectedCategory == 9 ? 'active' : ''}">SANDALS</a>
      <a href="/admin/admin_main?categoryId=10" class="category-item ${selectedCategory == 10 ? 'active' : ''}">BAG</a>
      <a href="/admin/admin_main?categoryId=11" class="category-item ${selectedCategory == 11 ? 'active' : ''}">HAT</a>
      <a href="/admin/stopped_list" class="category-item">🚫 판매 중지 목록</a>
    </div>
  </div>

  <div class="menu-section">
    <div class="menu-title">🔥 프로모션 관리</div>
    <div class="category-list">
      <a href="/admin/promotion_list" class="category-item">전체 프로모션 관리</a>
    </div>
  </div>
</aside>

<main class="main-content">
  <div class="top-breadcrumb">
    상품 관리 / <c:out value="${empty selectedCategory ? '대시보드' : '카테고리 ID: '.concat(selectedCategory)}"/>
  </div>

  <div class="content-body">
    <div class="list-container">

      <div class="content-header">
        <h2><c:out value="${empty selectedCategory ? '관리 현황 요약' : '상품 목록'}"/></h2>
        <a href="/admin/product/add" class="btn-add">+ 새 상품 등록</a>
      </div>

      <c:choose>
        <%-- [1] 대시보드 화면 (전체보기 시) [cite: 68] --%>
        <c:when test="${empty selectedCategory}">
          <div class="card" style="margin-bottom: 20px; border-left: 5px solid #e74c3c;">
            <div class="card-title">🚫 판매 중지된 상품</div>
            <div class="card-value">${stoppedCount} <span style="font-size: 1rem; font-weight: normal;">건</span></div>
          </div>

          <div class="dashboard-grid">
            <div class="card">
              <div class="card-title">📦 최근 등록 상품 (TOP 5)</div>
              <table class="list-table">
                <c:forEach var="item" items="${recentProducts}">
                  <tr><td>${item.name}</td><td style="text-align:right;"><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</td></tr>
                </c:forEach>
              </table>
            </div>
            <div class="card">
              <div class="card-title">⚠ 재고 부족 상품</div>
              <table class="list-table">
                <c:forEach var="item" items="${lowStockProducts}">
                  <tr><td>${item.name}</td><td style="text-align:right; color:#e74c3c; font-weight:bold;">${item.stockQuantity}개</td></tr>
                </c:forEach>
              </table>
            </div>
          </div>
        </c:when>

        <%-- [2] 상품 목록 화면 (카테고리 선택 시) [cite: 82] --%>
        <c:otherwise>
          <table class="list-table">
            <thead>
            <tr>
              <th>번호</th>
              <th>이미지</th>
              <th>상품명</th>
              <th style="text-align: right;">가격</th>
              <th style="text-align: center;">관리</th>
            </tr>
            </thead>
            <tbody>
            <c:forEach var="item" items="${productList}">
              <tr>
                <td>${item.productId}</td>
                <td><img src="${item.imageUrl}" class="prod-img"></td>
                <td style="font-weight: bold;">${item.name}</td>
                <td style="text-align: right;"><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</td>
                <td style="text-align: center;">
                  <a href="/admin/product/edit?productId=${item.productId}" class="btn-edit">수정</a>
                  <form action="/admin/product/delete" method="post" style="display:inline;">
                    <input type="hidden" name="productId" value="${item.productId}">
                    <button type="submit" class="btn-del" onclick="return confirm('판매 중지하시겠습니까?');">삭제</button>
                  </form>
                </td>
              </tr>
            </c:forEach>
            </tbody>
          </table>
        </c:otherwise>
      </c:choose>

    </div>
  </div>
</main>

</body>
</html>