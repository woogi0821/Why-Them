<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<footer class="footer-section">
    <c:if test="${not empty sessionScope.loginMember}">
        <button class="btn-withdraw" onclick="executeWithdraw()">회원탈퇴</button>
    </c:if>


<style>
    /* ★ 라라 부티크 푸터 전용 스타일 */
    footer {
        background-color: #1a1a1a; /* 딥 블랙 배경 */
        color: #fff;
        padding: 60px 20px 40px; /* 넉넉한 여백 */
        text-align: center;
        border-top: 1px solid #333;
        margin-top: 100px; /* 본문과 거리 두기 */
        font-family: 'Noto Sans KR', sans-serif;
    }

    .footer-info {
        margin-bottom: 30px;
    }

    .footer-info p {
        margin: 6px 0;
        font-size: 11px;
        color: #888; /* 너무 튀지 않는 회색 텍스트 */
        letter-spacing: 0.5px;
        font-weight: 300;
    }

    /* 사업자 정보 사이의 구분선(|) 스타일 */
    .footer-info span.sep {
        display: inline-block;
        margin: 0 10px;
        color: #444;
        font-size: 10px;
        vertical-align: middle;
    }

    /* 하단 저작권 (Copyright) 스타일 */
    .footer-copyright {
        font-family: 'Cormorant Garamond', serif; /* 시그니처 폰트 */
        font-size: 12px;
        color: #555; /* 아주 어두운 회색으로 은은하게 */
        text-transform: uppercase;
        letter-spacing: 2px;
        margin-top: 30px;
        padding-top: 20px;
        border-top: 1px solid #222; /* 살짝 보이는 구분선 */
        display: inline-block; /* 선 길이를 텍스트에 맞춤 (선택사항) */
        width: 100%;
        max-width: 800px;
    }
</style>

<footer>
    <div class="footer-info">
        <p>
            회사명: 라라 부티크 <span class="sep">|</span>
            대표자: 행님 <span class="sep">|</span>
            사업자등록번호: 123-45-67890
        </p>
        <p>
            통신판매업신고: 제 2026-부산-0000호 <span class="sep">|</span>
            주소: 부산광역시 라라구 부티크로 88
        </p>
        <p style="margin-top: 15px; color: #666;">
            CS CENTER : 051-123-4567 (Mon-Fri 10:00 - 18:00)
        </p>
    </div>

    <p class="footer-copyright">
        &copy; 2026 LALA BOUTIQUE. ALL RIGHTS RESERVED.
    </p>
</footer>

