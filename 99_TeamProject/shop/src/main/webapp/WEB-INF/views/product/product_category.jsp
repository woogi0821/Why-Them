<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | OFFICIAL STORE</title>
    <link rel="stylesheet" href="/css/index.css">

    <style>
        .product-card { position: relative; cursor: pointer; }
        .btn-wish-icon {
            position: absolute; top: 15px; right: 15px; z-index: 20;
            font-size: 24px; color: #ccc; background: rgba(255, 255, 255, 0.3);
            border: none; border-radius: 50%; width: 35px; height: 35px;
            display: flex; align-items: center; justify-content: center;
            cursor: pointer; transition: all 0.2s;
        }
        .btn-wish-icon:hover { transform: scale(1.1); background: rgba(255, 255, 255, 0.8); }
        .btn-wish-icon.active { color: #e74c3c; }
        .view-count { font-size: 11px; color: #999; margin-bottom: 2px; }

        /* [추가] 품절 및 판매중지 오버레이 스타일 */
        .sold-out-overlay {
            position: absolute; top: 0; left: 0; width: 100%; height: 100%;
            background: rgba(0, 0, 0, 0.4); /* 반투명 검정 */
            color: #fff; display: flex; flex-direction: column;
            justify-content: center; align-items: center;
            z-index: 10; font-weight: bold; letter-spacing: 1px;
            pointer-events: none; /* 오버레이가 있어도 클릭 가능하게 유지 (상세페이지 이동을 위해) */
        }
        .overlay-text {
            border: 1.5px solid #fff; padding: 8px 15px; font-size: 14px;
            text-transform: uppercase;
        }
        .status-msg { font-size: 12px; color: #ff4d4d; font-weight: bold; margin-bottom: 5px; }
    </style>
</head>
<body>
<div id="main-wrapper">

    <jsp:include page="/common/header.jsp" />

    <main id="content-body">
        <section class="special-section">
            <h2 id="main-title" class="stitle">
                <c:out value="${not empty categoryName ? categoryName : 'COLLECTION'}" />
            </h2>
            <div id="grid-root" class="grid-container">

                <c:forEach var="item" items="${productList}">
                    <div class="product-card" onclick="location.href='/product/detail?productId=<c:out value="${item.productId}"/>'">

                            <%-- 위시리스트 버튼 --%>
                        <button type="button" class="btn-wish-icon ${item.wished ? 'active' : ''}"
                                onclick="toggleWishList(event, '<c:out value="${item.productId}"/>', this)">
                            ♥
                        </button>

                            <%-- 이미지 영역 --%>
                        <div class="img-box" style="position: relative;">
                                <%-- [추가] 품절(SOLD_OUT) 또는 중지(STOP) 상태 오버레이 --%>
                            <c:if test="${item.status == 'SOLD_OUT' || item.status == 'STOP'}">
                                <div class="sold-out-overlay">
                                    <div class="overlay-text">
                                        <c:choose>
                                            <c:when test="${item.status == 'SOLD_OUT'}">SOLD OUT</c:when>
                                            <c:otherwise>판매 일시 중지</c:otherwise>
                                        </c:choose>
                                    </div>
                                </div>
                            </c:if>

                            <c:choose>
                                <c:when test="${not empty item.imageUrl}">
                                    <img src="${item.imageUrl}" alt="<c:out value='${item.name}' />">
                                </c:when>
                                <c:otherwise>
                                    <img src="/img/no-image.jpg" alt="No Image">
                                </c:otherwise>
                            </c:choose>
                        </div>

                            <%-- 정보 영역 --%>
                        <div class="info-box">
                            <p class="view-count">VIEWS <c:out value="${item.viewCount}" default="0" /></p>
                            <p class="name"><c:out value="${item.name}" /></p>
                            <p class="brand"><c:out value="${item.brandName}" default="LALA BOUTIQUE" /></p>

                            <div class="price-area" style="margin-top: 5px;">
                                    <%-- [추가] 품절/중지 상태 메시지 표시 --%>
                                <c:choose>
                                    <c:when test="${item.status == 'SOLD_OUT'}">
                                        <p class="status-msg">[품절] 재입고 예정</p>
                                    </c:when>
                                    <c:when test="${item.status == 'STOP'}">
                                        <p class="status-msg" style="color:#999;">[판매 중지]</p>
                                    </c:when>
                                </c:choose>

                                    <%-- 가격 표시 로직 --%>
                                <c:choose>
                                    <c:when test="${not empty item.promotion && item.salePrice > 0 && item.salePrice < item.price}">
                                        <div style="display: flex; flex-direction: column; align-items: flex-start;">
                                            <span style="text-decoration: line-through; color: #bbb; font-size: 13px;">
                                                ₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/>
                                            </span>
                                            <div style="display: flex; align-items: center; gap: 8px;">
                                                <span style="color: #d9534f; font-weight: bold; font-size: 16px;">
                                                    ₩ <fmt:formatNumber value="${item.salePrice}" pattern="#,###"/>
                                                </span>
                                                <span style="font-size: 11px; color: #fff; background-color: #d9534f; padding: 2px 4px; border-radius: 2px;">
                                                   SALE
                                                </span>
                                            </div>
                                        </div>
                                    </c:when>
                                    <c:otherwise>
                                        <p class="price" style="font-size: 16px; font-weight: 500; color: #333; margin:0;">
                                            ₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/>
                                        </p>
                                    </c:otherwise>
                                </c:choose>
                            </div>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </section>
    </main>

    <jsp:include page="/common/footer.jsp" />

</div>
<%-- 스크립트 생략 (기존과 동일) --%>
</body>
</html>