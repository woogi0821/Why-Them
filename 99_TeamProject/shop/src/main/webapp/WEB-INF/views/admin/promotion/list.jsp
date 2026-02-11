<%@ taglib prefix="c" uri="http://java.sun.com/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: khuser
  Date: 26. 2. 11.
  Time: 오후 12:10
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<html>
<head>
    <title>Title</title>
</head>
<body>
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
        <tr>
            <td>${promotion.promotionId}</td>
            <td>
                <a href="/admin/promotion/${promotion.promotionId}">
                        ${promotion.title}
                </a>
            </td>
            <td>
                    ${promotion.startDate} ~ ${promotion.endDate}
            </td>
            <td>
                <c:choose>
                    <c:when test="${promotion.status eq 'ACTIVE'}">
                        <span style="color:green;">진행중</span>
                    </c:when>

                    <c:when test="${promotion.status eq 'READY'}">
                        대기
                    </c:when>

                    <c:otherwise>
                        <span style="color:red;">종료</span>
                    </c:otherwise>
                </c:choose>
            </td>

            <td>
                <c:choose>
                    <!-- 진행중일 때만 종료 가능 -->
                    <c:when test="${promotion.status eq 'ACTIVE'}">
                        <form action="/end" method="post" style="display:inline;">
                            <input type="hidden"
                                   name="promotionId"
                                   value="${promotion.promotionId}" />
                            <button type="submit">종료</button>
                        </form>
                    </c:when>

                    <!-- READY 또는 END -->
                    <c:otherwise>
                        <button disabled>종료</button>
                    </c:otherwise>
                </c:choose>
            </td>
        </tr>
    </c:forEach>
    </tbody>
</table>
</body>
</html>
