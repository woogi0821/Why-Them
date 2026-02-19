<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>상품 수정</title>
    <style>
        /* 기존 product_add.jsp의 스타일을 그대로 복사해서 사용하세요 */
        .form-container { max-width: 500px; margin: 50px auto; padding: 20px; border: 1px solid #ddd; }
        .form-group { margin-bottom: 15px; }
        label { display: block; margin-bottom: 5px; }
        input[type="text"], input[type="number"], textarea, select { width: 100%; padding: 8px; }
        .btn-submit { background-color: #000; color: #fff; padding: 10px; width: 100%; cursor: pointer; }
        .current-img { width: 100px; margin-top: 10px; display: block; }
    </style>
</head>
<body>
<div class="form-container">
    <h2>상품 수정</h2>
    <form action="/admin/product/edit" method="post" enctype="multipart/form-data">
        <input type="hidden" name="productId" value="${product.productId}">
        <input type="hidden" name="imageUrl" value="${product.imageUrl}">

        <div class="form-group">
            <label>카테고리</label>
            <select name="categoryId" required>
                <option value="1" ${product.categoryId == 1 ? 'selected' : ''}>코트</option>
                <option value="2" ${product.categoryId == 2 ? 'selected' : ''}>셔츠</option>
                <option value="3" ${product.categoryId == 3 ? 'selected' : ''}>스웨터</option>
                <option value="4" ${product.categoryId == 4 ? 'selected' : ''}>팬츠</option>
                <option value="5" ${product.categoryId == 5 ? 'selected' : ''}>스커트</option>
                <option value="6" ${product.categoryId == 6 ? 'selected' : ''}>원피스</option>
                <option value="7" ${product.categoryId == 7 ? 'selected' : ''}>수트</option>
                <option value="8" ${product.categoryId == 8 ? 'selected' : ''}>드레스슈즈</option>
                <option value="9" ${product.categoryId == 9 ? 'selected' : ''}>샌들</option>
                <option value="10" ${product.categoryId == 10 ? 'selected' : ''}>백</option>
                <option value="11" ${product.categoryId == 11 ? 'selected' : ''}>모자</option>
            </select>
        </div>

        <div class="form-group">
            <label>브랜드명</label>
            <input type="text" name="brandName" value="${product.brandName}" required>
        </div>

        <div class="form-group">
            <label>상품명</label>
            <input type="text" name="name" value="${product.name}" required>
        </div>

        <div class="form-group">
            <label>가격</label>
            <input type="number" name="price" value="${product.price}" required>
        </div>

        <div class="form-group">
            <label>재고량</label>
            <input type="number" name="stockQuantity" value="${product.stockQuantity}">
        </div>

        <div class="form-group">
            <label>상품 설명</label>
            <textarea name="description" rows="5">${product.description}</textarea>
        </div>

        <div class="form-group">
            <label>상품 이미지 (변경하려면 새로 선택)</label>
            <input type="file" name="productImage">
            <c:if test="${not empty product.imageUrl}">
                <p>현재 이미지:</p>
                <img src="${product.imageUrl}" class="current-img">
            </c:if>
        </div>

        <button type="submit" class="btn-submit">수정 완료</button>
        <button type="button" onclick="location.href='/admin/admin_main'" style="width: 100%; margin-top: 5px;">취소</button>
    </form>
</div>
</body>
</html>