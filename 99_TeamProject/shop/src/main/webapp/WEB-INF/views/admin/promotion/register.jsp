<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>프로모션 ${promotion == null ? '추가' : '수정'}</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
  <link rel="stylesheet" href="/css/style.css">
</head>
<body>
<jsp:include page="/common/header.jsp"/>

<div class="container mx-auto mt-8 px-3">
  <h1 class="text-2xl font-bold mb-6">프로모션 ${promotion == null ? '추가' : '상세조회'}</h1>

  <form id="addForm" name="addForm" method="post">
    <c:if test="${promotion != null}">
      <input type="hidden" id="promotionId" name="promotionId" value="<c:out value="${promotion.promotionId}"/>" />
    </c:if>

    <div class="mb-4">
      <label class="block mb-1 font-bold">프로모션 제목</label>
      <input type="text" name="promotionTitle"
             class="w-full border border-gray-300 rounded p-2 focus:outline-none focus:ring focus:ring-blue-500"
             value="<c:out value="${promotion.promotionTitle}"/>" placeholder="제목을 입력하세요">
    </div>

    <div class="mb-4">
      <label class="block mb-1 font-bold">할인 설정</label>
      <div class="flex gap-2">
        <select name="discountType" class="border border-gray-300 rounded p-2">
          <option value="PERCENT" ${promotion.discountType == 'PERCENT' ? 'selected' : ''}>%</option>
          <option value="AMOUNT" ${promotion.discountType == 'AMOUNT' ? 'selected' : ''}>원</option>
        </select>
        <input type="number" name="discountValue" class="flex-1 border border-gray-300 rounded p-2"
               value="${promotion.discountValue}" placeholder="할인 수치">
      </div>
    </div>

    <div class="mb-4 flex gap-4">
      <div class="flex-1">
        <label class="block mb-1 font-bold">시작일</label>
        <input type="date" name="startDate" class="w-full border border-gray-300 rounded p-2"
               value="${promotion.startDate}">
      </div>
      <div class="flex-1">
        <label class="block mb-1 font-bold">종료일</label>
        <input type="date" name="endDate" class="w-full border border-gray-300 rounded p-2"
               value="${promotion.endDate}">
      </div>
    </div>

    <c:if test="${promotion != null}">
      <div class="mb-4">
        <label class="block mb-1 font-bold">상태 설정</label>
        <select name="isActive" class="w-full border border-gray-300 rounded p-2">
          <option value="Y" ${promotion.isActive == 'Y' ? 'selected' : ''}>활성화 (진행중)</option>
          <option value="N" ${promotion.isActive == 'N' ? 'selected' : ''}>비활성화 (중단됨)</option>
        </select>
      </div>
    </c:if>

    <div class="mb-4 flex gap-2">
      <c:choose>
        <c:when test="${promotion == null}">
          <button type="button" class="w-full bg-blue-700 text-white p-2 rounded hover:bg-blue-800"
                  onclick="fn_save('add')">저장</button>
        </c:when>
        <c:otherwise>
          <button type="button" class="flex-1 bg-green-700 text-white p-2 rounded hover:bg-green-800"
                  onclick="fn_save('edit')">수정</button>
          <button type="button" class="flex-1 bg-gray-500 text-white p-2 rounded hover:bg-gray-600"
                  onclick="location.href='/admin/promotion/list'">취소</button>
        </c:otherwise>
      </c:choose>
    </div>
  </form>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script type="text/javascript">
  function fn_save(mode) {
    if(mode === 'add') {
      $("#addForm").attr("action", "/admin/promotion/add").submit();
    } else {
      $("#addForm").attr("action", "/admin/promotion/update").submit();
    }
  }
</script>
</body>
</html>