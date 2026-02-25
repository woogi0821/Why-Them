<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<!DOCTYPE html>
<html lang="ko">
<head>
  <title>프로모션 ${promotion == null ? '등록' : '수정'}</title>
  <script src="https://cdn.jsdelivr.net/npm/@tailwindcss/browser@4"></script>
  <style>
    body { background-color: #f4f7f9; }
    .form-container { background: white; border-radius: 12px; box-shadow: 0 10px 25px rgba(0,0,0,0.05); }
  </style>
</head>
<body class="p-6">

<div class="max-w-2xl mx-auto form-container p-8 mt-10">
  <h1 class="text-3xl font-extrabold text-gray-800 mb-8 border-b pb-4">
    프로모션 ${promotion == null ? '신규 등록' : '정보 수정'}
  </h1>

  <form id="addForm" method="post">
    <c:if test="${promotion != null}">
      <input type="hidden" id="promotionId" name="promotionId" value="${promotion.promotionId}" />
    </c:if>

    <div class="space-y-6">
      <div>
        <label class="block text-sm font-semibold text-gray-700 mb-2">프로모션 제목</label>
        <input type="text" name="promotionTitle" required
               class="w-full border border-gray-300 rounded-lg p-3 focus:ring-2 focus:ring-blue-500 outline-none transition"
               value="<c:out value="${promotion.promotionTitle}"/>" placeholder="예: 여름 정기 세일">
      </div>

      <div>
        <label class="block text-sm font-semibold text-gray-700 mb-2">할인 설정</label>
        <div class="flex gap-3">
          <select name="discountType" class="border border-gray-300 rounded-lg p-3 bg-gray-50">
            <option value="PERCENT" ${promotion.discountType == 'PERCENT' ? 'selected' : ''}>정률 (%)</option>
            <option value="AMOUNT" ${promotion.discountType == 'AMOUNT' ? 'selected' : ''}>정액 (원)</option>
          </select>
          <input type="number" name="discountValue" required
                 class="flex-1 border border-gray-300 rounded-lg p-3 focus:ring-2 focus:ring-blue-500 outline-none"
                 value="${promotion.discountValue}" placeholder="숫자만 입력">
        </div>
      </div>

      <div class="grid grid-cols-2 gap-4">
        <div>
          <label class="block text-sm font-semibold text-gray-700 mb-2">시작일</label>
          <input type="date" name="startDate" required
                 class="w-full border border-gray-300 rounded-lg p-3 focus:ring-2 focus:ring-blue-500"
                 value="${promotion.startDate}">
        </div>
        <div>
          <label class="block text-sm font-semibold text-gray-700 mb-2">종료일</label>
          <input type="date" name="endDate" required
                 class="w-full border border-gray-300 rounded-lg p-3 focus:ring-2 focus:ring-blue-500"
                 value="${promotion.endDate}">
        </div>
      </div>

      <c:if test="${promotion != null}">
        <div>
          <label class="block text-sm font-semibold text-gray-700 mb-2">활성화 상태</label>
          <select name="isActive" class="w-full border border-gray-300 rounded-lg p-3 bg-gray-50">
            <option value="Y" ${promotion.isActive == 'Y' ? 'selected' : ''}>진행 가능 (Y)</option>
            <option value="N" ${promotion.isActive == 'N' ? 'selected' : ''}>일시 중단 (N)</option>
          </select>
        </div>
      </c:if>

      <div class="flex gap-4 pt-4">
        <button type="button"
                onclick="fn_save('${promotion == null ? 'add' : 'edit'}')"
                class="flex-1 bg-blue-600 text-white font-bold py-3 rounded-lg hover:bg-blue-700 transition shadow-lg">
          ${promotion == null ? '등록하기' : '수정완료'}
        </button>
        <button type="button"
                onclick="history.back()"
                class="flex-1 bg-gray-200 text-gray-700 font-bold py-3 rounded-lg hover:bg-gray-300 transition">
          취소
        </button>
      </div>
    </div>
  </form>
</div>

<script src="https://code.jquery.com/jquery-3.3.1.min.js"></script>
<script>
  function fn_save(mode) {
    // 간단한 유효성 검사
    if(!$("input[name='promotionTitle']").val()) { alert("제목을 입력해주세요."); return; }

    const actionPath = (mode === 'add') ? "/admin/promotion/add" : "/admin/promotion/update";
    $("#addForm").attr("action", actionPath).submit();
  }
</script>
</body>
</html>