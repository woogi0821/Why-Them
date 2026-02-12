<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
  <title>프로모션 등록</title>
  <style>
    .form-group { margin-bottom: 15px; }
    label { display: inline-block; width: 100px; font-weight: bold; }
  </style>
</head>
<body>
<h2>신규 프로모션 등록</h2>

<form action="/admin/promotion/register" method="post">
  <div class="form-group">
    <label>제목:</label>
    <input type="text" name="promotionTitle" required placeholder="프로모션 제목을 입력하세요">
  </div>

  <div class="form-group">
    <label>할인 구분:</label>
    <select name="discountType">
      <option value="PERCENT">정률 할인 (%)</option>
      <option value="AMOUNT">정액 할인 (원)</option>
    </select>
  </div>

  <div class="form-group">
    <label>할인 값:</label>
    <input type="number" name="discountValue" required min="0">
  </div>

  <div class="form-group">
    <label>시작일:</label>
    <input type="date" name="startDate" id="startDate" required>
  </div>

  <div class="form-group">
    <label>종료일:</label>
    <input type="date" name="endDate" id="endDate" required>
  </div>
  <div class="mt-6 flex gap-2">
    <button type="submit"
            class="bg-blue-700 text-white hover:bg-blue-800 px-4 py-2 rounded min-w-[5rem] font-bold">
      등록
    </button>

    <a href="/admin/promotion/list"
       class="bg-gray-500 text-white hover:bg-gray-600 px-4 py-2 rounded min-w-[5rem] text-center font-bold">
      취소
    </a>
  </div>
</form>

<script>
  // 날짜 유효성 체크 스크립트
  document.querySelector('form').onsubmit = function() {
    const start = document.getElementById('startDate').value;
    const end = document.getElementById('endDate').value;

    if (start > end) {
      alert("종료일은 시작일보다 빠를 수 없습니다.");
      return false;
    }
    return true;
  };
</script>
<form action="/admin/promotion/add" method="post">

</form>
</body>
</html>