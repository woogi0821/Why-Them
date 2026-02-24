<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
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
               class="category-item ${empty selectedCategory and not showStopped ? 'active' : ''}">DASHBOARD</a>
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
</body>
</html>
