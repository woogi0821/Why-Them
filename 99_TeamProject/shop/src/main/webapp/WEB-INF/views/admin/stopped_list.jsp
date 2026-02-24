<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>
<!DOCTYPE html>
<html>
<head>
    <title>관리자 페이지 - 판매 중지 목록</title>
    <link rel="stylesheet" href="/css/admin_stoppde.css">
    <link rel="stylesheet" href="/css/admin_sidebar.css">
</head>
<body>

<jsp:include page="/common/sidebar.jsp" />

<div class="main-content">
    <div class="top-nav">
        <div style="font-size: 0.85rem; color: #7f8c8d;">상품 관리 / <b>판매 중지 목록</b></div>
    </div>

    <div class="content-body">
        <div class="list-container">
            <div class="list-header">
                <h2 style="color: #e74c3c;">🚫 판매 중지된 상품</h2>
            </div>

            <table>
                <thead>
                <tr>
                    <th style="width: 80px;">번호</th>
                    <th style="width: 100px;">이미지</th>
                    <th>상품명</th>
                    <th style="width: 150px;">가격</th>
                    <th style="width: 120px;">관리</th>
                </tr>
                </thead>
                <tbody>
                <c:forEach var="item" items="${productList}">
                    <tr>
                        <td><c:out value="${item.productId}" /></td>
                        <td>
                            <img src="${not empty item.imageUrl ? item.imageUrl : '/img/no-image.jpg'}" class="prod-img">
                        </td>
                        <td style="font-weight: 600; color: #95a5a6;">
                            <c:out value="${item.name}" /> <span style="font-size: 0.8rem;">(판매중지)</span>
                        </td>
                        <td><fmt:formatNumber value="${item.price}" pattern="#,###"/>원</td>
                        <td>
                            <form action="/admin/product/restore" method="post" style="display:inline;">
                                <input type="hidden" name="productId" value="${item.productId}">
                                <button type="submit" class="btn-restore" onclick="return confirm('판매를 재개하시겠습니까?');">
                                    판매 재개
                                </button>
                            </form>
                        </td>
                    </tr>
                </c:forEach>
                <c:if test="${empty productList}">
                    <tr>
                        <td colspan="5" style="text-align: center; padding: 50px; color: #999;">판매 중지된 상품이 없습니다.</td>
                    </tr>
                </c:if>
                </tbody>
            </table>
        </div>
    </div>
</div>

</body>
</html>