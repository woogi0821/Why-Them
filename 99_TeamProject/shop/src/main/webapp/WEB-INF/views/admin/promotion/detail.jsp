<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>
<%@ page import="java.time.LocalDate" %>
<html>
<head>
  <title>프로모션 상세</title>
</head>
<body>

<%-- 오늘 날짜 가져오기 --%>
<c:set var="today" value="<%= LocalDate.now() %>" />

<h2>프로모션 상세 정보</h2>

<p><strong>프로모션명:</strong> ${promotion.promotionTitle}</p>

<p><strong>현재 상태:</strong>
  <c:choose>
    <c:when test="${promotion.isActive eq 'N'}"><span style="color:red;">중단됨</span></c:when>
    <c:when test="${today.isBefore(promotion.startDate)}">대기 중</c:when>
    <c:when test="${today.isAfter(promotion.endDate)}"><span style="color:gray;">기간 만료</span></c:when>
    <c:otherwise><span style="color:green; font-weight:bold;">진행 중</span></c:otherwise>
  </c:choose>
</p>

<p><strong>이벤트 기간:</strong> ${promotion.startDate} ~ ${promotion.endDate}</p>
<p><strong>할인 수치:</strong> ${promotion.discountValue} (${promotion.discountType})</p>

<hr>

<%--
    [종료 버튼 노출 조건]
    실제로 '진행 중'일 때만 종료 버튼을 보여줍니다.
--%>
<c:if test="${promotion.isActive eq 'Y' && !today.isBefore(promotion.startDate) && !today.isAfter(promotion.endDate)}">
  <form action="/admin/promotion/end" method="post" onsubmit="return confirm('이 이벤트를 지금 종료할까요?');">
    <input type="hidden" name="promotionId" value="${promotion.promotionId}" />
    <button type="submit" style="color:white; background-color:red;">프로모션 강제 종료</button>
  </form>
</c:if>

<c:if test="${promotion.isActive eq 'N' || today.isAfter(promotion.endDate)}">
  <p style="color:blue;">이미 종료되었거나 기간이 지난 프로모션은 상태를 변경할 수 없습니다.</p>
</c:if>

<br>
<div class="mb-4 flex gap-2">
  <button type="button"
          class="flex-1 bg-blue-700 text-white p-2 rounded hover:bg-blue-800"
          onclick="location.href='/admin/promotion/edit/${promotion.promotionId}'">
    정보 수정
  </button>

  <button type="button"
          class="flex-1 bg-red-600 text-white p-2 rounded hover:bg-red-700"
          onclick="fn_delete()">
    삭제하기
  </button>

  <button type="button"
          class="flex-1 bg-gray-500 text-white p-2 rounded hover:bg-gray-600"
          onclick="location.href='/admin/promotion/list?page=${criteria.page}&searchKeyword=${criteria.searchKeyword}'">
    목록으로
    </button>
</div>

<form id="deleteForm" method="post">
  <input type="hidden" name="promotionId" value="${promotion.promotionId}">
</form>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>

<script>
  function fn_delete() {
    if(confirm("정말로 이 프로모션을 삭제하시겠습니까?")) {
      // 2. jQuery가 정상 로드되어야 아래 코드가 작동합니다.
      const form = $("#deleteForm");
      console.log("폼 전송 시도 중..."); // 브라우저 콘솔에서 확인용
      form.attr("action", "/admin/promotion/delete");
      form.submit();
    }
  }
</script>

</body>
</html>