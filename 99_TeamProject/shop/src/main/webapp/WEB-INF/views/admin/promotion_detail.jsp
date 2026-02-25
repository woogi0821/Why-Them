<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page import="java.time.LocalDate" %>
<!DOCTYPE html>
<html>
<head>
  <title>프로모션 상세 정보</title>
  <style>
    body { margin: 0; font-family: 'Pretendard', sans-serif; background-color: #f4f7f9; display: flex; height: 100vh; }
    .sidebar { width: 240px; background-color: #34495e; color: #ecf0f1; flex-shrink: 0; }
    .main-content { flex: 1; padding: 35px; overflow-y: auto; }
    .detail-card { background: #fff; border-radius: 8px; box-shadow: 0 4px 15px rgba(0,0,0,0.05); padding: 30px; max-width: 800px; margin: 0 auto; }
    h2 { margin-top: 0; color: #2c3e50; border-bottom: 2px solid #3498db; padding-bottom: 15px; }
    .info-group { display: flex; padding: 15px 0; border-bottom: 1px solid #eee; }
    .info-label { width: 150px; font-weight: bold; color: #7f8c8d; }
    .info-value { flex: 1; color: #2c3e50; }
    .status-badge { padding: 4px 10px; border-radius: 4px; font-weight: bold; font-size: 0.9rem; }
    .btn-group { margin-top: 30px; display: flex; gap: 10px; }
    .btn { padding: 10px 20px; border-radius: 4px; border: none; cursor: pointer; font-weight: bold; text-decoration: none; text-align: center; color: #fff; }
    .btn-edit { background-color: #3498db; flex: 1; }
    .btn-delete { background-color: #e74c3c; flex: 1; }
    .btn-list { background-color: #95a5a6; flex: 1; }
    .btn-end { background-color: #f39c12; width: 100%; margin-top: 10px; }
  </style>
</head>
<body>

<div class="main-content">
  <div class="detail-card">
    <h2>프로모션 상세 정보</h2>

    <c:set var="today" value="<%= LocalDate.now() %>" />

    <div class="info-group">
      <div class="info-label">프로모션명</div>
      <div class="info-value"><strong>${promotion.promotionTitle}</strong></div>
    </div>

    <div class="info-group">
      <div class="info-label">현재 상태</div>
      <div class="info-value">
        <c:choose>
          <c:when test="${promotion.isActive eq 'N'}"><span class="status-badge" style="background:#ffebee; color:#c62828;">중단됨</span></c:when>
          <%-- [해결] empty 체크를 추가하여 null 에러 방지 --%>
          <c:when test="${not empty promotion.startDate && today.isBefore(promotion.startDate)}">
            <span class="status-badge" style="background:#e3f2fd; color:#1976d2;">대기 중</span>
          </c:when>
          <c:when test="${not empty promotion.endDate && today.isAfter(promotion.endDate)}">
            <span class="status-badge" style="background:#f5f5f5; color:#757575;">기간 만료</span>
          </c:when>
          <c:otherwise><span class="status-badge" style="background:#e8f5e9; color:#2e7d32;">진행 중</span></c:otherwise>
        </c:choose>
      </div>
    </div>

    <div class="info-group">
      <div class="info-label">이벤트 기간</div>
      <div class="info-value">${promotion.startDate} ~ ${promotion.endDate}</div>
    </div>

    <div class="info-group">
      <div class="info-label">할인 혜택</div>
      <div class="info-value">${promotion.discountValue} ${promotion.discountType eq 'PERCENT' ? '%' : '원'} 할인</div>
    </div>

    <c:if test="${promotion.isActive eq 'Y' && not empty promotion.startDate && not empty promotion.endDate}">
      <c:if test="${!today.isBefore(promotion.startDate) && !today.isAfter(promotion.endDate)}">
        <form action="/admin/promotion/end" method="post" onsubmit="return confirm('이 이벤트를 지금 종료할까요?');">
          <input type="hidden" name="promotionId" value="${promotion.promotionId}" />
          <button type="submit" class="btn btn-end">프로모션 즉시 종료</button>
        </form>
      </c:if>
    </c:if>

    <div class="btn-group">
      <a href="/admin/promotion/edit/${promotion.promotionId}" class="btn btn-edit">정보 수정</a>
      <button type="button" class="btn btn-delete" onclick="fn_delete()">삭제하기</button>
      <a href="/admin/promotion_list?page=${criteria.page}&searchKeyword=${criteria.searchKeyword}" class="btn btn-list">목록으로</a>
    </div>
  </div>
</div>

<form id="deleteForm" method="post">
  <input type="hidden" name="promotionId" value="${promotion.promotionId}">
</form>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
  function fn_delete() {
    if(confirm("정말로 이 프로모션을 삭제하시겠습니까?")) {
      const form = $("#deleteForm");
      form.attr("action", "/admin/promotion/delete");
      form.submit();
    }
  }
</script>
</body>
</html>