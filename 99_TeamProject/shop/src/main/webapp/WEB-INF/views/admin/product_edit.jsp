<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<html>
<head>
    <title>상품 수정</title>
    <link rel="stylesheet" href="/css/admin_product_edit.css">
</head>
<body>
<div class="form-container">
    <h2>상품 수정</h2>
    <form action="/admin/product/edit" method="post" enctype="multipart/form-data">
        <%-- 2. hidden 필드의 ID값도 안전하게 보호 --%>
        <input type="hidden" name="productId" value="<c:out value='${product.productId}'/>">
        <input type="hidden" name="imageUrl" value="<c:out value='${product.imageUrl}'/>">

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
            <%-- 3. 브랜드명 데이터 보호 --%>
            <input type="text" name="brandName" value="<c:out value='${product.brandName}'/>" required>
        </div>

        <div class="form-group">
            <label>상품명</label>
            <%-- 4. 상품명 데이터 보호 --%>
            <input type="text" name="name" value="<c:out value='${product.name}'/>" required>
        </div>

        <div class="form-group">
            <label>가격</label>
            <input type="number" name="price" value="<c:out value='${product.price}'/>" required>
        </div>

        <div class="form-group">
            <label>재고량</label>
            <input type="number" name="stockQuantity" value="<c:out value='${product.stockQuantity}'/>">
        </div>

        <div class="form-group">
            <label>상품 설명</label>
            <%-- 5. textarea는 태그 사이에 공백 없이 c:out 삽입 --%>
            <textarea name="description" rows="5"><c:out value="${product.description}"/></textarea>
        </div>

        <div class="form-group">
            <label>상품 이미지 (변경하려면 새로 선택)</label>
            <input type="file" name="productImage">
            <c:if test="${not empty product.imageUrl}">
                <p>현재 이미지:</p>
                <%-- 이미지 alt 속성도 보안 처리 --%>
                <img src="${product.imageUrl}" alt="<c:out value='${product.name}'/>" class="current-img">
            </c:if>
        </div>

        <button type="submit" class="btn-submit">수정 완료</button>
        <button type="button" onclick="location.href='/admin/admin_main'" style="width: 100%; margin-top: 5px;">취소</button>
    </form>
</div>
</body>
</html>