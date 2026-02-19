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

    /* [메뉴 그룹 스타일] */
    .menu-section { border-bottom: 1px solid #455a64; }
    .menu-title {
      padding: 18px 25px;
      font-size: 1rem;
      font-weight: bold;
      background-color: #2c3e50;
      color: #fff;
      display: flex;
      align-items: center;
    }

    /* [카테고리 리스트 - 고정 노출] */
    .category-list { background-color: #34495e; }
    .category-item {
      padding: 12px 45px;
      display: block;
      color: #bdc3c7;
      font-size: 0.9rem;
      transition: 0.2s;
      border-left: 4px solid transparent;
    }
    .category-item:hover { color: #fff; background-color: #3e4f5f; }
    /* 선택된 메뉴 강조 */
    .category-item.active {
      color: #fff;
      background-color: #1a252f;
      font-weight: bold;
      border-left: 4px solid #3498db;
    }

    /* [우측 콘텐츠 영역] */
    .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
    .top-nav { height: 60px; background: #fff; display: flex; align-items: center; padding: 0 30px; border-bottom: 1px solid #dee2e6; }
    .content-body { padding: 35px; }
    .list-container { background: #fff; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 25px; }
    .list-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }

    .btn-add { background: #3498db; color: #fff; padding: 8px 18px; border-radius: 4px; font-size: 0.85rem; font-weight: bold; }

    /* 테이블 스타일 */
    table { width: 100%; border-collapse: collapse; }
    th { background-color: #f8f9fa; text-align: left; padding: 15px; border-bottom: 2px solid #dee2e6; font-size: 0.85rem; color: #666; }
    td { padding: 12px 15px; border-bottom: 1px solid #eee; vertical-align: middle; font-size: 0.9rem; }
    .prod-img { width: 60px; height: 60px; border-radius: 4px; object-fit: cover; border: 1px solid #eee; }

    .edit-link { color: #3498db; font-weight: bold; margin-right: 12px; }
    .delete-link { color: #e74c3c; font-weight: bold; }
  </style>
</head>
<body>

<div class="sidebar">
  <div class="sidebar-header">
    <a href="/">HOME</a>
  </div>

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
      <a href="/admin/admin_main?categoryId=10" class="category-item ${selectedCategory ==10 ? 'active' : ''}">BAG</a>
      <a href="/admin/admin_main?categoryId=11" class="category-item ${selectedCategory == 11 ? 'active' : ''}">HAT</a>
    </div>
  </div>

  <div class="menu-section">
    <div class="menu-title">🔥 프로모션 관리</div>
    <div class="category-list">
      <a href="/promotion/promotion_list" class="category-item">전체 프로모션 관리</a>
    </div>
  </div>
</div>

<div class="main-content">
  <div class="top-nav">
    <div style="font-size: 0.85rem; color: #7f8c8d;">
      상품 관리 / <b>
      <c:choose>
        <c:when test="${empty selectedCategory}">전체 리스트</c:when>
        <c:otherwise>카테고리 ID: <c:out value="${selectedCategory}" /></c:otherwise>
      </c:choose>
    </b>
    </div>
  </div>

  <div class="content-body">
    <div class="list-container">
      <div class="list-header">
        <h2>상품 목록</h2>
        <a href="/admin/product/add" class="btn-add">+ 새 상품 등록</a>
      </div>

      <table>
        <thead>
        <tr>
          <th style="width: 80px;">번호</th>
          <th style="width: 100px;">이미지</th>
          <th>상품명</th>
          <th style="width: 150px;">가격</th>
          <th style="width: 120px;">관리</th>
        </tr>
        </thead>
        <tbody>
        <c:forEach var="item" items="${productList}">
          <tr>
              <%-- ID나 숫자는 비교적 안전하지만, 습관적으로 c:out을 쓰는 것이 좋습니다 --%>
            <td><c:out value="${item.productId}" /></td>

            <td>
                <%-- 이미지의 alt 속성(설명)에도 상품명이 들어가므로 c:out 적용 --%>
              <img src="${not empty item.imageUrl ? item.imageUrl : '/img/no-image.jpg'}"
                   class="prod-img"
                   alt="<c:out value='${item.name}' />">
            </td>

              <%-- ★ 가장 중요한 부분: 상품명 출력 (해킹 방지 핵심) --%>
            <td style="font-weight: 600;">
              <c:out value="${item.name}" default="이름 없음" />
            </td>

            <td><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</td>

            <td>
                <%-- 링크의 파라미터로 들어가는 ID값도 c:out 처리 가능합니다 --%>
              <a href="/admin/product/edit?productId=<c:out value='${item.productId}' />" class="edit-link">수정</a>
              <a href="/admin/product/delete?productId=<c:out value='${item.productId}' />"
                 class="delete-link"
                 onclick="return confirm('정말 삭제하시겠습니까?');">삭제</a>
            </td>
          </tr>
        </c:forEach>
        </tbody>
      </table>
    </div>
  </div>
</div>

</body>
</html>