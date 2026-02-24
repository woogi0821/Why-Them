<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>관리자 페이지</title>
  <link rel="stylesheet" href="/css/admin_main.css">
  <link rel="stylesheet" href="/css/admin_sidebar.css">
</head>
<body>
<jsp:include page="/common/sidebar.jsp" />
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