<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%-- 오늘 날짜를 비교하기 위해 자바 클래스를 불러옵니다. --%>
<%@ page import="java.time.LocalDate" %>
<html>
<head>
    <title>프로모션 관리 목록</title>
    <style>
        .pagination { display: flex; list-style: none; padding: 0; }
        .pagination li { margin: 0 5px; }
        .pagination a { text-decoration: none; color: black; padding: 5px 10px; border: 1px solid #ccc; }
        .pagination a.active { background-color: #007bff; color: white; border-color: #007bff; }
    </style>
</head>
<body>
<div class="container mx-auto mt-8 px-3">
    <%-- 등록 페이지로 이동하는 버튼 추가 --%>
    <div class="flex justify-end mb-4">
        <a href="/admin/promotion/register"
           class="bg-green-600 text-white px-4 py-2 rounded hover:bg-green-700 font-bold">
            신규 프로모션 등록
        </a>
    </div>

    <form id="listForm" name="listForm" action="/admin/promotion/list" method="get">
        <%-- 검색 및 테이블 로직... --%>
    </form>
</div>

<script>
    // 컨트롤러에서 등록 성공 후 전달한 메시지가 있다면 알림창 띄우기
    const msg = "${msg}";
    if(msg === "INSERT_SUCCESS") {
        alert("신규 프로모션이 성공적으로 등록되었습니다!");
    }
</script>

<%-- 1. 오늘 날짜를 변수에 저장 (실시간 비교용) --%>
<c:set var="today" value="<%= LocalDate.now() %>" />

<h2>프로모션 관리 목록</h2>

<table>
    <thead>
    <tr>
        <th>ID</th>
        <th>제목</th>
        <th>기간</th>
        <th>실시간 상태</th>
        <th>관리</th>
    </tr>
    </thead>
    <tbody>
    <c:forEach var="promotion" items="${list}">
        <tr>
            <td>${promotion.promotionId}</td>
            <td>
                <a href="/admin/promotion/${promotion.promotionId}">${promotion.promotionTitle}</a>
            </td>
            <td>${promotion.startDate} ~ ${promotion.endDate}</td>

                <%-- 2. 실시간 상태 판단 로직 --%>
            <td>
                <c:choose>
                    <%-- 관리자가 수동으로 종료(N)한 경우 --%>
                    <c:when test="${promotion.isActive eq 'N'}">
                        <span style="color:red;">중단됨</span>
                    </c:when>
                    <%-- 시작일 이전인 경우 --%>
                    <c:when test="${today.isBefore(promotion.startDate)}">
                        대기
                    </c:when>
                    <%-- 종료일이 지난 경우 --%>
                    <c:when test="${today.isAfter(promotion.endDate)}">
                        <span style="color:gray;">기간만료</span>
                    </c:when>
                    <%-- 그 외: 활성 상태이면서 기간 내에 있는 경우 --%>
                    <c:otherwise>
                        <span style="color:green; font-weight:bold;">진행중</span>
                    </c:otherwise>
                </c:choose>
            </td>

            <td>
                    <%-- 3. 종료 버튼 활성화 조건: 진행중(ACTIVE)인 경우에만 노출 --%>
                <c:if test="${promotion.isActive eq 'Y' && !today.isBefore(promotion.startDate) && !today.isAfter(promotion.endDate)}">
                    <form action="/admin/promotion/end" method="post" style="display:inline;" onsubmit="return confirm('정말 종료하시겠습니까?');">
                        <input type="hidden" name="promotionId" value="${promotion.promotionId}" />
                        <button type="submit">종료</button>
                    </form>
                </c:if>
                    <%-- 진행중이 아니면 버튼 비활성화 --%>
                <c:if test="${!(promotion.isActive eq 'Y' && !today.isBefore(promotion.startDate) && !today.isAfter(promotion.endDate))}">
                    <button disabled>종료</button>
                </c:if>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>

<%-- 페이징 영역 --%>
<ul class="pagination">
    <c:if test="${criteria.prev}">
        <li><a href="?page=${criteria.startPage - 1}">이전</a></li>
    </c:if>
    <c:forEach var="num" begin="${criteria.startPage}" end="${criteria.endPage}">
        <li><a href="?page=${num}" class="${criteria.page == num ? 'active' : ''}">${num}</a></li>
    </c:forEach>
    <c:if test="${criteria.next}">
        <li><a href="?page=${criteria.endPage + 1}">다음</a></li>
    </c:if>
</ul>

</body>
</html>