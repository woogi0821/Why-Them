<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록 페이지</title>
    <link rel="stylesheet" href="/css/admin_product_add.css">
</head>
<body>

<div class="form-container">
    <h2>새 상품 등록</h2>
    <form action="/admin/product/add" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>카테고리</label>
            <select name="categoryId" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px;">
                <option value="">카테고리 선택</option>
                <optgroup label="TOP (상의)">
                    <option value="1" ${param.categoryId == '1' ? 'selected' : ''}>COAT</option>
                    <option value="2" ${param.categoryId == '2' ? 'selected' : ''}>SHIRT</option>
                    <option value="3" ${param.categoryId == '3' ? 'selected' : ''}>SWEATER</option>
                </optgroup>
                <optgroup label="BOTTOM (하의)">
                    <option value="4" ${param.categoryId == '4' ? 'selected' : ''}>PANTS</option>
                    <option value="5" ${param.categoryId == '5' ? 'selected' : ''}>SKIRTS</option>
                </optgroup>
                <optgroup label="SET (세트)">
                    <option value="6" ${param.categoryId == '6' ? 'selected' : ''}>ONEPIECE</option>
                    <option value="7" ${param.categoryId == '7' ? 'selected' : ''}>SUIT</option>
                </optgroup>
                <optgroup label="SHOES (신발)">
                    <option value="8" ${param.categoryId == '8' ? 'selected' : ''}>DRESSSHOE</option>
                    <option value="9" ${param.categoryId == '9' ? 'selected' : ''}>SANDALS</option>
                </optgroup>
                <optgroup label="ACC (액세서리)">
                    <option value="10" ${param.categoryId == '10' ? 'selected' : ''}>BAG</option>
                    <option value="11" ${param.categoryId == '11' ? 'selected' : ''}>HAT</option>
                </optgroup>
            </select>
        </div>

        <div class="form-group">
            <label>브랜드명</label>
            <%-- value 속성 내부를 띄어쓰기 없이 바짝 붙였습니다 --%>
            <input type="text" name="brandName" value="<c:out value='${param.brandName}'/>" placeholder="예: LEVIS" required>
        </div>

        <div class="form-group">
            <label>상품명</label>
            <input type="text" name="name" value="<c:out value='${param.name}'/>" placeholder="상품 이름을 입력하세요" required>
        </div>

        <div class="form-group">
            <label>가격</label>
            <input type="number" name="price" value="<c:out value='${param.price}'/>" placeholder="숫자만 입력" required>
        </div>

        <div class="form-group">
            <label>초기 재고량</label>
            <input type="number" name="stockQuantity" value="<c:out value='${not empty param.stockQuantity ? param.stockQuantity : 0}'/>">
        </div>

        <div class="form-group">
            <label>상품 설명</label>
            <%-- textarea는 시작태그와 종료태그 사이 공백 없이 붙여야 합니다 --%>
            <textarea name="description" placeholder="상품의 상세한 특징이나 정보를 입력해주세요."><c:out value="${param.description}"/></textarea>
        </div>

        <div class="form-group">
            <label>상품 이미지</label>
            <input type="file" name="productImage" accept="image/*">
        </div>

        <button type="submit" class="btn-submit">등록하기</button>
        <a href="/admin/admin_main" class="back-link">목록으로 돌아가기</a>
    </form>
</div>

</body>
</html>