<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%@ page contentType="text/html; charset=UTF-8" %>

<h2>프로모션 상세</h2>

<p>프로모션명: ${promotion.promotionTitle}</p>
<p>상태: ${promotion.status}</p>
<p>기간: ${promotion.startDate} ~ ${promotion.endDate}</p>

<!-- 프로모션 종료 버튼 -->
<c:if test="${promotion.status ne 'END'}">
<form action="/end" method="post">
  <input type="hidden" name="promotionId"
         value="${promotion.promotionId}" />

  <button type="submit">프로모션 종료</button>
</form>
</c:if>

<c:if test="${promotion.status eq 'END'}">
  <p style="color:red;">이미 종료된 프로모션입니다.</p>
</c:if>
