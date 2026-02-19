<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<html>
<head>
    <link rel="icon" href="data:;base64,iVBORw0KGgo=">
    <title>프로모션 관리 목록 (뼈대)</title>
    <style>
        /* 최소한의 가독성을 위한 기본 선 긋기 - 나중에 팀 CSS로 대체 */
        table {
            width: 100%;
            border-collapse: collapse;
            margin-top: 20px;
        }

        th, td {
            border: 1px solid #ddd;
            padding: 10px;
            text-align: left;
        }

        th {
            background-color: #f4f4f4;
        }

        .pagination {
            display: flex;
            list-style: none;
            padding: 0;
            justify-content: center;
        }

        .pagination li {
            margin: 5px;
        }

        .active {
            font-weight: bold;
            text-decoration: underline;
        }
    </style>
</head>
<body>

<h1>프로모션 관리 목록</h1>

<div style="display: flex; justify-content: space-between;">
    <a href="/admin/promotion_register">[신규 프로모션 등록]</a>

    <form action="/admin/promotion_list" method="get">
        <input type="text" name="searchKeyword" value="${criteria.searchKeyword}" placeholder="제목 검색">
        <button type="submit">검색</button>
    </form>
</div>

<c:set var="today" value="<%= LocalDate.now() %>"/>
<div class="container">
    <h2>프로모션 관리 대시보드</h2>

    <div class="dashboard-summary" style="display: flex; gap: 20px; margin-bottom: 30px;">
        <div class="card" style="border: 1px solid #ddd; padding: 20px; flex: 1; text-align: center;">
            <h4>진행 중 이벤트</h4>
            <p><span id="activeCount" style="font-size: 24px; font-weight: bold; color: #007bff;">0</span>개</p>
        </div>
        <div class="card" style="border: 1px solid #ddd; padding: 20px; flex: 1; text-align: center;">
            <h4>할인 적용 상품</h4>
            <p><span id="productCount" style="font-size: 24px; font-weight: bold; color: #28a745;">0</span>개</p>
        </div>
        <div class="card" style="border: 1px solid #ddd; padding: 20px; flex: 1; text-align: center;">
            <h4>오늘의 프로모션 매출</h4>
            <p><span id="salesAmount" style="font-size: 24px; font-weight: bold; color: #dc3545;">0</span>원</p>
        </div>
    </div>

    <table class="table">
    </table>
</div>

<script>
    document.addEventListener('DOMContentLoaded', function () {
        fetch('/api/promotion/dashboard-stats')
            .then(res => res.json())
            .then(data => {
                document.getElementById('activeCount').innerText = (data.activePromotions || 0);
                document.getElementById('productCount').innerText = (data.discountedProducts || 0);
                document.getElementById('salesAmount').innerText = (data.todaySales || 0).toLocaleString();
            })
            .catch(err => console.error("데이터 로드 실패:", err));
    });
</script>
<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>제목</th>
        <th>기간</th>
        <th>상태</th>
        <th>관리</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="promotion" items="${list}">
        <%-- 삭제된 데이터(D)라면 행 배경색을 회색(#f9f9f9)으로 변경 --%>
        <tr <c:if test="${promotion.isActive eq 'D'}">style="background-color: #f2f2f2; color: #999;"</c:if>>
            <td>${promotion.promotionId}</td>
            <td class="px-4 py-2 border-b">
                    <%-- 삭제된 데이터는 제목에 취소선 추가 --%>
                <a href="/admin/${promotion.promotionId}?page=${criteria.page}&searchKeyword=${criteria.searchKeyword}"
                   class="text-blue-600 hover:underline font-medium">
                    <c:choose>
                        <c:when test="${promotion.isActive eq 'D'}">
                            <del><c:out value="${promotion.promotionTitle}"/></del>
                        </c:when>
                        <c:otherwise>
                            <c:out value="${promotion.promotionTitle}"/>
                        </c:otherwise>
                    </c:choose>
                </a>
            </td>
            <td>${promotion.startDate} ~ ${promotion.endDate}</td>
            <td class="px-4 py-2 text-center">
                <c:choose>
                    <c:when test="${promotion.isActive eq 'D'}">
                        <%-- 삭제된 경우: 빨간 배경에 흰색 글자로 '삭제됨' 박스 표시 --%>
                        <span style="background-color: #e3342f; color: white; padding: 3px 8px; border-radius: 4px; font-weight: bold; font-size: 0.85rem;">
                삭제됨
            </span>
                    </c:when>
                    <c:otherwise>
                        <%-- 기존 로직 유지 --%>
                        ${promotion.isActive eq 'Y' ? '진행중' : '일시중단'}
                    </c:otherwise>
                </c:choose>
            </td>
            <td>
                    <%-- 삭제된 데이터는 종료 버튼을 아예 숨김 --%>
                <c:if test="${promotion.isActive eq 'Y' && !today.isBefore(promotion.startDate) && !today.isAfter(promotion.endDate)}">
                    <form action="/admin/promotion/end" method="post" style="display:inline;">
                        <input type="hidden" name="promotionId" value="${promotion.promotionId}"/>
                        <button type="submit">종료</button>
                    </form>
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
<script src="https://code.jquery.com/jquery-3.6.0.min.js"></script>
<script>
    const msg = "${msg}";
    if (msg === "INSERT_SUCCESS") alert("등록되었습니다.");
</script>
<script>
    $(document).ready(function () {
        // 컨트롤러에서 보낸 msg 값을 읽어옴
        const msg = "${msg}";

        if (msg === "INSERT_SUCCESS") {
            alert("등록되었습니다.");
        } else if (msg === "SEARCH_EMPTY") {
            alert("해당 이름의 프로모션이 존재하지 않습니다.");
        } else if (msg === "DELETE_SUCCESS") {
            alert("프로모션이 안전하게 삭제되었습니다.");
        } else if (msg === "UPDATE_SUCCESS") {
            alert("프로모션 정보가 수정되었습니다.");
        } else if (msg === "DELETE_FAIL") {
            alert("삭제 처리에 실패했습니다. 다시 시도해주세요.");
        }
    });
</script>

</body>
</html>