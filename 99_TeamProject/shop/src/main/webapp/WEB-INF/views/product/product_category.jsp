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
        /* [추가] 하트 버튼 스타일 (메인 페이지와 동일) */
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
                    <div class="product-card" onclick="location.href='/product/detail?productId=${item.productId}'">

                        <button type="button" class="btn-wish-icon ${item.wished ? 'active' : ''}"
                                onclick="toggleWishList(event, '${item.productId}', this)">
                            ♥
                        </button>

                        <div class="img-box">
                            <c:choose>
                                <c:when test="${not empty item.imageUrl}">
                                    <img src="${item.imageUrl}" alt="${item.name}">
                                </c:when>
                                <c:otherwise>
                                    <img src="/img/no-image.jpg" alt="No Image">
                                </c:otherwise>
                            </c:choose>
                        </div>
                        <div class="info-box">
                            <p class="name">${item.name}</p>
                            <p class="brand">${item.brandName}</p>
                            <p class="price">₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/></p>
                        </div>
                    </div>
                </c:forEach>

            </div>
        </section>
    </main>

    <jsp:include page="/common/footer.jsp" />

</div>

<script>
    function toggleWishList(event, productId, btnElement) {
        event.stopPropagation(); // 카드 클릭 방지
        event.preventDefault();

        fetch('/wishlist/toggle', {
            method: 'POST',
            headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
            body: 'productId=' + productId
        })
            .then(response => response.text())
            .then(result => {
                if (result === 'login') {
                    if(confirm('로그인이 필요한 서비스입니다.\n로그인 하시겠습니까?')) {
                        location.href = '/member/login';
                    }
                } else if (result === 'add') {
                    btnElement.classList.add('active');
                    showToast('위시리스트에 담았습니다.');
                } else if (result === 'remove') {
                    btnElement.classList.remove('active');
                    showToast('위시리스트에서 삭제했습니다.');
                }
            })
            .catch(err => console.error(err));
    }

    function showToast(message) {
        let toast = document.getElementById('toast-msg');
        if (!toast) {
            toast = document.createElement('div');
            toast.id = 'toast-msg';
            toast.style.cssText = `
                position: fixed; bottom: 50px; left: 50%; transform: translateX(-50%);
                background: rgba(0,0,0,0.8); color: #fff; padding: 12px 24px;
                border-radius: 30px; font-size: 14px; opacity: 0; transition: opacity 0.3s; z-index: 9999;
                font-family: 'Noto Sans KR', sans-serif;
            `;
            document.body.appendChild(toast);
        }
        toast.innerText = message;
        toast.style.opacity = '1';
        setTimeout(() => { toast.style.opacity = '0'; }, 2000);
    }
</script>

</body>
</html>