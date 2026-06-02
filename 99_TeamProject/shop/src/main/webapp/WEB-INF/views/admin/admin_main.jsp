<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>관리자 페이지</title>
  <link rel="stylesheet" href="/css/admin_main.css">
  <link rel="stylesheet" href="/css/admin_sidebar.css">
  <style>
    /* 상태별 배지 스타일 추가 */
    .status-badge { padding: 4px 8px; border-radius: 4px; font-size: 0.85rem; font-weight: bold; }
    .status-sale { background-color: #e3f2fd; color: #1976d2; }    /* 판매중: 파랑 */
    .status-soldout { background-color: #ffebee; color: #c62828; } /* 품절: 빨강 */
    .status-stop { background-color: #f5f5f5; color: #616161; }    /* 중지: 회색 */
    .stock-zero { color: #e74c3c; font-weight: bold; }
  </style>
</head>
<body>
<jsp:include page="/common/sidebar.jsp" />
<main class="main-content">
  <div class="top-breadcrumb">
    상품 관리 / <c:out value="${empty selectedCategory ? '전체 상품 관리' : '카테고리 ID: '.concat(selectedCategory)}"/>
  </div>

  <div class="content-body">
    <div class="list-container">

      <div class="content-header">
        <h2><c:out value="${empty selectedCategory ? '전체 상품 목록 (품절 포함)' : '카테고리 상품 목록'}"/></h2>
        <a href="/admin/product/add" class="btn-add">+ 새 상품 등록</a>
      </div>

      <%-- 관리자 페이지는 대시보드 대신 항상 리스트가 보이도록 구성하거나,
           아래처럼 테이블을 수정하여 상태를 확인하게 합니다. --%>
      <table class="list-table">
        <thead>
        <tr>
          <th>번호</th>
          <th>이미지</th>
          <th>상품명</th>
          <th style="text-align: center;">상태</th>
          <th style="text-align: right;">재고</th>
          <th style="text-align: right;">가격</th>
          <th style="text-align: center;">관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${productList}">
          <tr>
            <td>${item.productId}</td>
            <td><img src="${item.imageUrl}" class="prod-img" style="width:50px; height:50px; object-fit:cover;"></td>
            <td style="font-weight: bold;">${item.name}</td>
            <td style="text-align: center;">
                <%-- 상태값에 따른 배지 표시 --%>
              <c:choose>
                <c:when test="${item.status == 'SALE'}"><span class="status-badge status-sale">판매중</span></c:when>
                <c:when test="${item.status == 'SOLD_OUT'}"><span class="status-badge status-soldout">품절</span></c:when>
                <c:when test="${item.status == 'STOP'}"><span class="status-badge status-stop">판매중지</span></c:when>
                <c:otherwise><span class="status-badge">${item.status}</span></c:otherwise>
              </c:choose>
            </td>
            <td style="text-align: right;" class="${item.stockQuantity == 0 ? 'stock-zero' : ''}">
                ${item.stockQuantity}개
            </td>
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

    </div>
  </div>
</main>
</body>
</html>