<%--
  Created by IntelliJ IDEA.
  User: khuser
  Date: 26. 2. 2.
  Time: 오후 4:44
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>상품 등록 페이지</title>
    <style>
        /* 1. 기본 스타일 리셋 */
        body {
            font-family: 'Pretendard', -apple-system, BlinkMacSystemFont, system-ui, Roboto, sans-serif;
            background-color: #f9f9f9;
            margin: 0;
            padding: 0;
            display: flex;
            justify-content: center;
            align-items: center;
            min-height: 100vh;
        }

        /* 2. 폼 컨테이너 (상품 카드 느낌 계승) */
        .form-container {
            background-color: #fff;
            width: 100%;
            max-width: 450px;
            padding: 40px;
            border-radius: 12px;
            box-shadow: 0 10px 30px rgba(0,0,0,0.05);
        }

        .form-container h2 {
            font-size: 24px;
            font-weight: 800;
            margin-bottom: 30px;
            color: #333;
            text-align: center;
        }

        /* 3. 입력 그룹 스타일 */
        .form-group {
            margin-bottom: 20px;
        }

        .form-group label {
            display: block;
            font-size: 13px;
            font-weight: 700;
            color: #888;
            margin-bottom: 8px;
            text-transform: uppercase;
        }

        .form-group input {
            width: 100%;
            padding: 12px 15px;
            border: 1px solid #eee;
            border-radius: 8px;
            font-size: 15px;
            color: #333;
            background-color: #fdfdfd;
            transition: all 0.3s ease;
            box-sizing: border-box; /* 패딩 포함 크기 계산 */
        }

        .form-group input:focus {
            outline: none;
            border-color: #000;
            background-color: #fff;
        }

        /* 4. 등록 버튼 (기존 btn-add 스타일 계승) */
        .btn-submit {
            width: 100%;
            padding: 15px;
            background-color: #000;
            color: #fff;
            border: none;
            border-radius: 8px;
            font-size: 16px;
            font-weight: 700;
            cursor: pointer;
            margin-top: 20px;
            transition: background 0.3s ease, transform 0.2s ease;
        }

        .btn-submit:hover {
            background-color: #333;
            transform: translateY(-2px);
        }

        .btn-submit:active {
            transform: translateY(0);
        }

        /* 하단 돌아가기 링크 */
        .back-link {
            display: block;
            text-align: center;
            margin-top: 20px;
            font-size: 14px;
            color: #999;
            text-decoration: none;
        }

        .back-link:hover {
            text-decoration: underline;
        }
    </style>
</head>
<body>

<div class="form-container">
    <h2>새 상품 등록</h2>
    <form action="/product/add" method="post" enctype="multipart/form-data">
        <div class="form-group">
            <label>카테고리</label>
            <select name="categoryId" required style="width: 100%; padding: 12px; border: 1px solid #ddd; border-radius: 8px;">
                <option value="">카테고리 선택</option>

                <optgroup label="TOP (상의)">
                    <option value="7">COAT</option>
                    <option value="8">SHIRT</option>
                    <option value="9">SWEATER</option>
                </optgroup>

                <optgroup label="BOTTOM (하의)">
                    <option value="10">PANTS</option>
                    <option value="11">SKIRTS</option>
                </optgroup>

                <optgroup label="SET (세트)">
                    <option value="12">ONEPIECE</option>
                    <option value="13">SUIT</option>
                </optgroup>

                <optgroup label="SHOES (신발)">
                    <option value="14">DRESSSHOE</option>
                    <option value="15">SANDALS</option>
                </optgroup>

                <optgroup label="ACC (액세서리)">
                    <option value="16">BAG</option>
                    <option value="17">HAT</option>
                </optgroup>
            </select>
        </div>
        <div class="form-group">
            <label>브랜드명</label>
            <input type="text" name="brandName" placeholder="예: LEVIS" required>
        </div>
        <div class="form-group">
            <label>상품명</label>
            <input type="text" name="name" placeholder="상품 이름을 입력하세요" required>
        </div>
        <div class="form-group">
            <label>가격</label>
            <input type="number" name="price" placeholder="숫자만 입력" required>
        </div>
        <div class="form-group">
            <label>초기 재고량</label>
            <input type="number" name="stockQuantity" value="0">
        </div>
        <div class="form-group">
            <label>상품 이미지 (여러 장 선택 가능)</label>
            <input type="file" name="productImage" accept="image/*">
        </div>
        <button type="submit" class="btn-save">등록하기</button>

    </form>
</div>

</body>
</html>