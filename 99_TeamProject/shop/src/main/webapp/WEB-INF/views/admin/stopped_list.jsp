<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 페이지 - 판매 중지 목록</title>
    <style>
        /* 기존 스타일 유지 */
        body { margin: 0; font-family: 'Pretendard', sans-serif; background-color: #f4f7f9; display: flex; height: 100vh; overflow: hidden; }
        a { text-decoration: none; color: inherit; }

        .sidebar { width: 240px; background-color: #34495e; color: #ecf0f1; display: flex; flex-direction: column; flex-shrink: 0; }
        .sidebar-header { padding: 30px 20px; font-size: 1.4rem; font-weight: bold; background-color: #2c3e50; text-align: center; }

        .menu-section { border-bottom: 1px solid #455a64; }
        .menu-title { padding: 18px 25px; font-size: 1rem; font-weight: bold; background-color: #2c3e50; color: #fff; display: flex; align-items: center; }

        .category-list { background-color: #34495e; }
        .category-item { padding: 12px 45px; display: block; color: #bdc3c7; font-size: 0.9rem; transition: 0.2s; border-left: 4px solid transparent; }
        .category-item:hover { color: #fff; background-color: #3e4f5f; }
        .category-item.active { color: #fff; background-color: #1a252f; font-weight: bold; border-left: 4px solid #3498db; }

        .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
        .top-nav { height: 60px; background: #fff; display: flex; align-items: center; padding: 0 30px; border-bottom: 1px solid #dee2e6; }
        .content-body { padding: 35px; }
        .list-container { background: #fff; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 25px; }
        .list-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }

        table { width: 100%; border-collapse: collapse; }
        th { background-color: #f8f9fa; text-align: left; padding: 15px; border-bottom: 2px solid #dee2e6; font-size: 0.85rem; color: #666; }
        td { padding: 12px 15px; border-bottom: 1px solid #eee; vertical-align: middle; font-size: 0.9rem; }
        .prod-img { width: 60px; height: 60px; border-radius: 4px; object-fit: cover; border: 1px solid #eee; }

        /* [판매 재개 버튼 전용 스타일] */
        .btn-restore {
            background: none;
            border: none;
            padding: 0;
            font: inherit;
            cursor: pointer;
            color: #27ae60; /* 초록색 */
            font-weight: bold;
        }
        .btn-restore:hover { text-decoration: underline; }
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
            <a href="/admin/admin_main"
               class="category-item ${empty selectedCategory and not showStopped ? 'active' : ''}">
                전체보기</a>
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
            <a href="/admin/stopped_list" class="category-item ${showStopped ? 'active' : ''}" >🚫 판매 중지 목록</a>
        </div>
    </div>

    <div class="menu-section">
        <div class="menu-title">🔥 프로모션 관리</div>
        <div class="category-list">
            <a href="/admin/promotion_list" class="category-item">전체 프로모션 관리</a>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="top-nav">
        <div style="font-size: 0.85rem; color: #7f8c8d;">상품 관리 / <b>판매 중지 목록</b></div>
    </div>

    <div class="content-body">
        <div class="list-container">
            <div class="list-header">
                <h2 style="color: #e74c3c;">🚫 판매 중지된 상품</h2>
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
                        <td><c:out value="${item.productId}" /></td>
                        <td>
                            <img src="${not empty item.imageUrl ? item.imageUrl : '/img/no-image.jpg'}" class="prod-img">
                        </td>
                        <td style="font-weight: 600; color: #95a5a6;">
                            <c:out value="${item.name}" /> <span style="font-size: 0.8rem;">(판매중지)</span>
                        </td>
                        <td><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</td>
                        <td>
                            <form action="/admin/product/restore" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="${item.productId}">
                                <button type="submit" class="btn-restore" onclick="return confirm('판매를 재개하시겠습니까?');">
                                    판매 재개
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty productList}">
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 50px; color: #999;">판매 중지된 상품이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>