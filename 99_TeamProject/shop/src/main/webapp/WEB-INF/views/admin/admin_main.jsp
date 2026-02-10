<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
  <title>상품 목록</title>
  <style>
    /* 1. 기본 레이아웃 설정 */
    .product-grid {
      display: grid;
      grid-template-columns: repeat(auto-fill, minmax(250px, 1fr));
      gap: 30px;
      padding: 20px;
    }

    /* 2. 상품 카드 스타일 */
    .product-card {
      background-color: #fff;
      border-radius: 12px;
      overflow: hidden;
      border: 1px solid #eee;
      transition: transform 0.3s ease, box-shadow 0.3s ease;
      position: relative;
    }

    .product-card:hover {
      transform: translateY(-5px);
      box-shadow: 0 10px 20px rgba(0,0,0,0.1);
    }

    /* 3. 이미지 박스 */
    .img-box {
      width: 100%;
      height: 250px;
      background-color: #f5f5f5;
      display: flex;
      justify-content: center;
      align-items: center;
    }

    .img-box img {
      width: 100%;
      height: 100%;
      object-fit: cover;
    }

    /* 4. 정보 박스 */
    .info-box {
      padding: 15px;
    }

    .brand { font-size: 12px; color: #888; margin: 0; }
    .name { font-size: 16px; font-weight: bold; margin: 5px 0; height: 40px; }
    .price { font-size: 15px; color: #333; font-weight: 700; }

    /* 5. 수정/삭제 버튼 영역 */
    .admin-btns {
      display: flex;
      border-top: 1px solid #eee;
      background: #fafafa;
    }

    .admin-btns a {
      flex: 1;
      text-align: center;
      padding: 10px 0;
      text-decoration: none;
      font-size: 13px;
      font-weight: 600;
    }

    .edit-btn { color: #007bff; border-right: 1px solid #eee; }
    .delete-btn { color: #ff4d4f; }
    .edit-btn:hover { background-color: #f0f7ff; }
    .delete-btn:hover { background-color: #fff1f0; }

    /* 등록 버튼 */
    .btn-add-product {
      display: inline-block;
      margin: 20px;
      padding: 12px 24px;
      background-color: #000;
      color: #fff;
      text-decoration: none;
      border-radius: 8px;
      font-weight: bold;
    }
     .menu-item, .parent-link { font-weight: bold; text-decoration: none; color: #333; font-size: 1.1rem; }
    .child-links a { text-decoration: none; color: #999; margin: 0 10px; transition: 0.3s; }
    .child-links a:hover, .active { color: #000 !important; font-weight: bold; }
    .divider { margin: 0 20px; color: #ddd; }
    .category-group { vertical-align: top; }
  </style>
</head>
<body>

<div class="admin-header" style="text-align: center; padding: 40px 0;">
  <h1 style="font-size: 2.5rem; margin-bottom: 20px;">SHOP</h1>

  <div class="menu-wrapper">

    <div class="category-group" style="display: inline-block; margin-right: 20px; vertical-align: top;">
      <span class="parent-link">TOP</span>
      <div class="child-links" style="font-size: 0.9rem; color: #888; margin-top: 5px;">
        <a href="/admin/admin_main?categoryId=1" class="${param.categoryId == 1 ? 'active' : ''}">COAT</a><br>
        <a href="/admin/admin_main?categoryId=2" class="${param.categoryId == 2 ? 'active' : ''}">SHIRT</a><br>
        <a href="/admin/admin_main?categoryId=3" class="${param.categoryId == 3 ? 'active' : ''}">SWEATER</a>
      </div>
    </div>

    <div class="category-group" style="display: inline-block; margin-right: 20px; vertical-align: top;">
      <span class="parent-link">BOTTOM</span>
      <div class="child-links" style="font-size: 0.9rem; color: #888; margin-top: 5px;">
        <a href="/admin/admin_main?categoryId=4" class="${param.categoryId == 4 ? 'active' : ''}">PANTS</a><br>
        <a href="/admin/admin_main?categoryId=5" class="${param.categoryId == 5 ? 'active' : ''}">SKIRTS</a>
      </div>
    </div>

    <div class="category-group" style="display: inline-block; margin-right: 20px; vertical-align: top;">
      <span class="parent-link">SET</span> <div class="child-links" style="font-size: 0.9rem; color: #888; margin-top: 5px;">
      <a href="/admin/admin_main?categoryId=6" class="${param.categoryId == 6 ? 'active' : ''}">DRESS</a><br>
      <a href="/admin/admin_main?categoryId=7" class="${param.categoryId == 7 ? 'active' : ''}">SUIT</a>
    </div>
    </div>

    <div class="category-group" style="display: inline-block; margin-right: 20px; vertical-align: top;">
      <span class="parent-link">SHOES</span> <div class="child-links" style="font-size: 0.9rem; color: #888; margin-top: 5px;">
      <a href="/admin/admin_main?categoryId=8" class="${param.categoryId == 8 ? 'active' : ''}">SHOES</a><br>
      <a href="/admin/admin_main?categoryId=9" class="${param.categoryId == 9 ? 'active' : ''}">SANDALS</a>
    </div>
    </div>
    <div class="category-group" style="display: inline-block; vertical-align: top;">
      <span class="parent-link">ACC</span>
      <div class="child-links" style="font-size: 0.9rem; color: #888; margin-top: 5px;">
        <a href="/admin/admin_main?categoryId=10" class="${param.categoryId == 10 ? 'active' : ''}">BAG</a><br>
        <a href="/admin/admin_main?categoryId=11" class="${param.categoryId == 11 ? 'active' : ''}">HAT</a>
      </div>
    </div>
  </div>

  <a href="/admin/product/add" class="btn-add-product">+ 새 상품 등록</a>
</div>
<div class="product-grid">
  <c:forEach var="item" items="${productList}">
    <div class="product-card">
      <a href="/product/detail?productId=${item.productId}" style="text-decoration: none; color: inherit;">
        <div class="img-box">
          <c:choose>
            <c:when test="${not empty item.imageUrl}">
              <img src="${item.imageUrl}" alt="${item.name}">
            </c:when>
            <c:otherwise>
              <img src="/img/no-image.jpg" alt="이미지 없음">
            </c:otherwise>
          </c:choose>
        </div>

        <div class="info-box">
          <p class="brand">${item.brandName}</p>
          <p class="name">${item.name}</p>
          <p class="price">
            <fmt:formatNumber value="${item.price}" pattern="#,###"/>원
          </p>
        </div>
      </a>

      <div class="admin-btns">
        <a href="/admin/product/edit?productId=${item.productId}" class="edit-btn">수정</a>
        <a href="/admin/product/delete?productId=${item.productId}"
           class="delete-btn"
           onclick="return confirm('이 상품을 삭제하시겠습니까?');">삭제</a>
      </div>
    </div>
  </c:forEach>
</div>

</body>
</html>