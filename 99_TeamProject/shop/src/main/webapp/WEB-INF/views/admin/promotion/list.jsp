<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page import="java.time.LocalDate" %>
<html>
<head>
    <title>프로모션 관리 목록 (뼈대)</title>
    <style>
        /* 최소한의 가독성을 위한 기본 선 긋기 - 나중에 팀 CSS로 대체 */
        table { width: 100%; border-collapse: collapse; margin-top: 20px; }
        th, td { border: 1px solid #ddd; padding: 10px; text-align: left; }
        th { background-color: #f4f4f4; }
        .pagination { display: flex; list-style: none; padding: 0; justify-content: center; }
        .pagination li { margin: 5px; }
        .active { font-weight: bold; text-decoration: underline; }
    </style>
</head>
<body>

<h1>프로모션 관리 목록</h1>

<div style="display: flex; justify-content: space-between;">
    <a href="/admin/promotion/register">[신규 프로모션 등록]</a>

    <form action="/admin/promotion/list" method="get">
        <input type="text" name="searchKeyword" value="${param.searchKeyword}" placeholder="제목 검색">
        <button type="submit">검색</button>
    </form>
</div>

<c:set var="today" value="<%= LocalDate.now() %>" />

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
                <a href="/admin/promotion/${promotion.promotionId}?page=${criteria.page}&searchKeyword=${criteria.searchKeyword}"
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
                        <input type="hidden" name="promotionId" value="${promotion.promotionId}" />
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

<script>
    const msg = "${msg}";
    if(msg === "INSERT_SUCCESS") alert("등록되었습니다.");
</script>
<script>
    $(document).ready(function() {
        // 컨트롤러에서 보낸 msg 값을 읽어옴
        const msg = "${msg}";

        if (msg === "DELETE_SUCCESS") {
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