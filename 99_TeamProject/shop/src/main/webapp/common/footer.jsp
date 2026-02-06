<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="footer-section">
    <c:if test="${not empty sessionScope.loginMember}">
        <button class="btn-withdraw" onclick="executeWithdraw()">회원탈퇴</button>
    </c:if>

    <div class="footer-info">
        <p>COMPANY: LALA BOUTIQUE | OWNER: TEAM LEADER | CALL: 1544-0000</p>
        <p>© 2026 LALA BOUTIQUE. ALL RIGHTS RESERVED.</p>
    </div>
</footer>

<script>
    function executeWithdraw() {
        if(confirm("정말로 탈퇴하시겠습니까?\n탈퇴 시 모든 정보가 삭제되며 복구할 수 없습니다.")) {
            // 실제 탈퇴 처리 URL로 이동 (컨트롤러 필요)
            location.href = '${pageContext.request.contextPath}/member/withdraw';
        }
    }
</script>