<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>프로모션 관리 - 관리자</title>
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <style>
        body { margin: 0; font-family: 'Pretendard', sans-serif; background-color: #f4f7f9; display: flex; height: 100vh; overflow: hidden; }
        a { text-decoration: none; color: inherit; }
        /* 사이드바 스타일 일치 */
        .sidebar { width: 240px; background-color: #34495e; color: #ecf0f1; display: flex; flex-direction: column; flex-shrink: 0; }
        .sidebar-header { padding: 30px 20px; font-size: 1.4rem; font-weight: bold; background-color: #2c3e50; text-align: center; cursor: pointer; }
        .sidebar-header a { color: #fff; letter-spacing: 2px; }
        .menu-section { border-bottom: 1px solid #455a64; }
        .menu-title { padding: 18px 25px; font-size: 0.9rem; font-weight: bold; background-color: #2c3e50; display: flex; align-items: center; gap: 8px; }
        .category-list { background-color: #34495e; }
        .category-item { padding: 12px 45px; display: block; color: #bdc3c7; font-size: 0.85rem; transition: 0.2s; border-left: 4px solid transparent; }
        .category-item:hover { color: #fff; background-color: #3e4f5f; }
        .category-item.active { color: #fff; background-color: #1a252f; font-weight: bold; border-left: 4px solid #3498db; }
        .main-content { flex: 1; display: flex; flex-direction: column; overflow-y: auto; }
        .content-body { padding: 35px; }
        .dashboard-summary { display: flex; gap: 20px; margin-bottom: 30px; }
        .card { background: #fff; border-radius: 8px; padding: 20px; flex: 1; text-align: center; box-shadow: 0 2px 10px rgba(0,0,0,0.05); }
        .card h4 { margin: 0 0 10px; color: #7f8c8d; font-size: 0.9rem; }
        .card p { margin: 0; font-size: 1.5rem; font-weight: bold; }
        .list-container { background: #fff; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 25px; }
        .list-header { display: flex; justify-content: space-between; align-items: center; margin-bottom: 25px; }
        .btn-add { background: #3498db; color: #fff; padding: 8px 18px; border-radius: 4px; font-size: 0.85rem; font-weight: bold; border: none; cursor: pointer; }
        table { width: 100%; border-collapse: collapse; }
        th { background-color: #f8f9fa; text-align: left; padding: 15px; border-bottom: 2px solid #dee2e6; font-size: 0.85rem; color: #666; }
        td { padding: 12px 15px; border-bottom: 1px solid #eee; vertical-align: middle; font-size: 0.9rem; }
        .status-badge { padding: 4px 8px; border-radius: 4px; font-size: 0.75rem; font-weight: bold; display: inline-block; }
        .status-y { background: #e8f5e9; color: #2e7d32; }
        .status-n { background: #fff3e0; color: #ef6c00; }
        .status-d { background: #ffebee; color: #c62828; }
        .pagination { display: flex; list-style: none; padding: 20px 0; justify-content: center; margin: 0; }
        .pagination li { margin: 0 5px; }
        .pagination a { padding: 8px 14px; background: #fff; border: 1px solid #ddd; border-radius: 4px; color: #333; text-decoration: none; font-size: 0.9rem; }
        .pagination a.active { background: #3498db; color: #fff; border-color: #3498db; font-weight: bold; }
        .search-input { padding: 8px; border: 1px solid #ddd; border-radius: 4px; width: 200px; }
        .btn-search { padding: 8px 15px; background: #95a5a6; color:#fff; border:none; border-radius:4px; cursor:pointer; font-weight: bold; }
    </style>
</head>
<body>

<div class="sidebar">
    <div class="sidebar-header"><a href="/">HOME</a></div>

    <div class="menu-section">
        <div class="menu-title">📦 상품 관리</div>
        <div class="category-list">
            <a href="/admin/admin_main" class="category-item ${empty selectedCategory ? 'active' : ''}">DASHBOARD</a>
            <a href="/admin/admin_main?categoryId=1" class="category-item ${selectedCategory == 1 ? 'active' : ''}">COAT</a>
            <a href="/admin/admin_main?categoryId=2" class="category-item ${selectedCategory == 2 ? 'active' : ''}">SHIRT</a>
            <a href="/admin/admin_main?categoryId=3" class="category-item ${selectedCategory == 3 ? 'active' : ''}">SWEATER</a>
            <a href="/admin/admin_main?categoryId=4" class="category-item ${selectedCategory == 4 ? 'active' : ''}">PANTS</a>
            <a href="/admin/admin_main?categoryId=5" class="category-item ${selectedCategory == 5 ? 'active' : ''}">SKIRTS</a>
            <a href="/admin/admin_main?categoryId=6" class="category-item ${selectedCategory == 6 ? 'active' : ''}">DRESS</a>
            <a href="/admin/admin_main?categoryId=7" class="category-item ${selectedCategory == 7 ? 'active' : ''}">SUIT</a>
            <a href="/admin/admin_main?categoryId=8" class="category-item ${selectedCategory == 8 ? 'active' : ''}">SHOSE</a>
            <a href="/admin/admin_main?categoryId=9" class="category-item ${selectedCategory == 9 ? 'active' : ''}">SANDALS</a>
            <a href="/admin/admin_main?categoryId=10" class="category-item ${selectedCategory == 10 ? 'active' : ''}">BAG</a>
            <a href="/admin/admin_main?categoryId=11" class="category-item ${selectedCategory == 11 ? 'active' : ''}">HAT</a>
            <a href="/admin/stopped_list" class="category-item">🚫 판매 중지 목록</a>
        </div>
    </div>

    <div class="menu-section">
        <div class="menu-title">🔥 프로모션 관리</div>
        <div class="category-list">
            <a href="/admin/promotion_list" class="category-item active">전체 프로모션 관리</a>
        </div>
    </div>
</div>

<div class="main-content">
    <div class="content-body">

        <div class="dashboard-summary">
            <div class="card">
                <h4>진행 중 이벤트</h4>
                <p><span id="activeCount" style="color: #3498db;">0</span>개</p>
            </div>
            <div class="card">
                <h4>할인 적용 상품</h4>
                <p><span id="productCount" style="color: #27ae60;">0</span>개</p>
            </div>
            <div class="card">
                <h4>오늘의 프로모션 매출</h4>
                <p><span id="salesAmount" style="color: #e74c3c;">0</span>원</p>
            </div>
        </div>

        <div class="list-container">
            <div class="list-header">
                <h2 style="margin:0; font-size: 1.4rem;">프로모션 관리 대시보드</h2>
                <div style="display: flex; gap: 10px;">
                    <form action="/admin/promotion_list" method="get" style="display: flex; gap: 5px;">
                        <input type="text" name="searchKeyword" class="search-input" value="${criteria.searchKeyword}" placeholder="제목 검색">
                        <button type="submit" class="btn-search">검색</button>
                    </form>
                    <a href="/admin/promotion_register" class="btn-add">+ 신규 프로모션 등록</a>
                </div>
            </div>

            <table>
                <thead>
                <tr>
                    <th style="width: 60px;">ID</th>
                    <th>프로모션 제목</th>
                    <th>기간</th>
                    <th style="text-align: center;">상태</th>
                    <th>관리</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="promotion" items="${list}">
                    <tr <c:if test="${promotion.isActive eq 'D'}">style="background-color: #fcfcfc; color: #999;"</c:if>>
                        <td>${promotion.promotionId}</td>
                        <td>
                            <a href="/admin/${promotion.promotionId}?page=${criteria.page}&searchKeyword=${criteria.searchKeyword}"
                               style="font-weight: bold; color: #2c3e50; ${promotion.isActive eq 'D' ? 'text-decoration: line-through;' : ''}">
                                <c:out value="${promotion.promotionTitle}"/>
                            </a>
                        </td>
                        <td style="color: #7f8c8d; font-size: 0.85rem;">
                                ${promotion.startDate} ~ ${promotion.endDate}
                        </td>
                        <td style="text-align: center;">
                            <c:choose>
                                <c:when test="${promotion.isActive eq 'D'}">
                                    <span class="status-badge status-d">삭제됨</span>
                                </c:when>
                                <c:otherwise>
                                    <%-- 진행중/중단됨 표시 --%>
                                    <span class="status-badge ${promotion.isActive eq 'Y' ? 'status-y' : 'status-n'}">
                                            ${promotion.isActive eq 'Y' ? '진행중' : '중단됨'}
                                    </span>
                                </c:otherwise>
                            </c:choose>
                        </td>
                        <td>
                                <%-- 관리 버튼: 진행중(Y)일 때만 중지 버튼 노출 --%>
                            <c:if test="${promotion.isActive eq 'Y'}">

                            </c:if>
                        </td>
                    </tr>
                </c:forEach>
                </tbody>
            </table>

            <ul class="pagination">
                <c:if test="${criteria.prev}">
                    <li><a href="?page=${criteria.startPage - 1}&searchKeyword=${param.searchKeyword}">이전</a></li>
                </c:if>
                <c:forEach var="num" begin="${criteria.startPage}" end="${criteria.endPage}">
                    <li>
                        <a href="?page=${num}&searchKeyword=${param.searchKeyword}"
                           class="${criteria.page == num ? 'active' : ''}">${num}</a>
                    </li>
                </c:forEach>
                <c:if test="${criteria.next}">
                    <li><a href="?page=${criteria.endPage + 1}&searchKeyword=${param.searchKeyword}">다음</a></li>
                </c:if>
            </ul>
        </div>
    </div>
</div>

<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    document.addEventListener('DOMContentLoaded', function () {
        // 우리가 만든 API 경로 호출
        fetch('/api/promotions/dashboard-stats')
            .then(res => {
                if (!res.ok) throw new Error('데이터를 가져오는데 실패했습니다');
                return res.json();
            })
            .then(data => {
                // [중요] 컨트롤러에서 보낸 Key값과 매칭
                // data.activePromotionCount (O) / data.activeCount (X)
                document.getElementById('activeCount').innerText = (data.activePromotionCount || 0);

                // data.discountedProductCount (O) / data.productCount (X)
                document.getElementById('productCount').innerText = (data.discountedProductCount || 0);

                // data.todaySales
                document.getElementById('salesAmount').innerText = (data.todaySales || 0).toLocaleString();

                console.log("대시보드 업데이트 완료:", data);
            })
            .catch(err => {
                console.error('Fetch error:', err);
            });

        const msg = "${msg}";
        if (msg === "INSERT_SUCCESS") alert("등록되었습니다.");
        else if (msg === "SEARCH_EMPTY") alert("해당 이름의 프로모션이 존재하지 않습니다.");
        else if (msg === "DELETE_SUCCESS") alert("프로모션이 삭제되었습니다.");
        else if (msg === "UPDATE_SUCCESS") alert("수정되었습니다.");
    });
</script>
</body>
</html>
