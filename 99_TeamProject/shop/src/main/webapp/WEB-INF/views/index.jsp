<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fmt" uri="http://java.sun.com/jsp/jstl/fmt" %>

<!DOCTYPE html>
<html lang="ko">
<head>
    <meta charset="UTF-8">
    <title>LALA BOUTIQUE | OFFICIAL STORE</title>
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <link rel="stylesheet" href="/css/index.css">

    <%-- ★ [추가] Swiper CSS --%>
    <link rel="stylesheet" href="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.css" />

    <link rel="icon" type="image/png" href="/images/favicon-96x96.png" sizes="96x96" />
    <link rel="icon" type="image/svg+xml" href="/images/favicon.svg" />
    <link rel="shortcut icon" href="/images/favicon.ico" />
    <link rel="apple-touch-icon" sizes="180x180" href="/images/apple-touch-icon.png" />
    <meta name="apple-mobile-web-app-title" content="LALA BOUTIQUE" />
    <link rel="manifest" href="/images/site.webmanifest" />

    <style>
        /* [추가된 CSS] 하트 버튼 스타일링 */
        .product-card {
            position: relative; /* 하트 버튼의 기준점 */
            cursor: pointer;
        }

        .btn-wish-icon {
            position: absolute;
            top: 15px;
            right: 15px;
            z-index: 20; /* 이미지보다 위에 떠야 함 */
            font-size: 24px;
            color: #ccc; /* 기본: 빈 하트(회색) */
            background: rgba(255, 255, 255, 0.3); /* 배경 살짝 깔아서 잘 보이게 */
            border: none;
            border-radius: 50%;
            width: 35px;
            height: 35px;
            display: flex;
            align-items: center;
            justify-content: center;
            cursor: pointer;
            transition: all 0.2s;
        }

        .btn-wish-icon:hover {
            transform: scale(1.1);
            background: rgba(255, 255, 255, 0.8);
        }

        /* 찜 된 상태 (빨간 하트) */
        .btn-wish-icon.active {
            color: #e74c3c;
        }

        /* =========================================
           ★ [추가] 메인 Swiper 배너 스타일
           ========================================= */
        .main-swiper-container {
            width: 100%;
            aspect-ratio: 16 / 5;
            max-height: 600px;
            margin-bottom: 80px;
        }


        .main-swiper {
            width: 100%;
            height: 100%;
        }

        .main-swiper .swiper-slide {
            position: relative;
            width: 100%;
            height: 100%;
        }

        .main-swiper .swiper-slide img {
            width: 100%;
            height: 100%;
            object-fit: cover;
            display: block;
        }

        /* 슬라이드 위에 올라가는 텍스트 (옵션) */
        .slide-text-box {
            position: absolute;
            top: 50%;
            left: 50%;
            transform: translate(-50%, -50%);
            text-align: center;
            color: #fff;
            text-shadow: 0 2px 4px rgba(0,0,0,0.5); /* 글씨가 잘 보이게 그림자 */
            z-index: 10;
        }

        .slide-text-box h2 {
            font-family: 'Cormorant Garamond', serif;
            font-size: 3rem;
            letter-spacing: 5px;
            font-weight: 300;
            margin-bottom: 15px;
        }

        .slide-text-box p {
            font-family: 'Noto Sans KR', sans-serif;
            font-size: 1.1rem;
            font-weight: 300;
            letter-spacing: 1px;
        }

        /* Swiper 페이징 버튼 (점) 커스텀 */
        .swiper-pagination-bullet {
            width: 10px;
            height: 10px;
            background: #fff;
            opacity: 0.5;
            transition: all 0.3s;
        }
        .swiper-pagination-bullet-active {
            opacity: 1;
            width: 30px; /* 선택된 점은 길쭉하게 변경 */
            border-radius: 5px;
            background: #fff;
        }
    </style>
</head>
<body>
<div id="main-wrapper">

    <jsp:include page="/common/header.jsp" />

    <main id="content-body">

        <%-- ★ [수정] 빈 이미지 대신 플레이스홀더(사이즈 표시) 적용 --%>
        <section class="main-swiper-container">
            <div class="swiper main-swiper">
                <div class="swiper-wrapper">
                    <%-- 슬라이드 1 --%>
                    <div class="swiper-slide">
                        <img src="/upload/001.png" alt="Slide 1">
                        <div class="slide-text-box">
                            <%-- 여기에 텍스트 필요할 경우 p태그 h태그로 넣어주세요 --%>
                        </div>
                    </div>
                    <%-- 슬라이드 2 --%>
                    <div class="swiper-slide">
                        <img src="/upload/002.png" alt="Slide 2">
                        <div class="slide-text-box">
                            <%-- 여기에 텍스트 필요할 경우 p태그 h태그로 넣어주세요 --%>
                        </div>
                    </div>
                    <%-- 슬라이드 3 (이벤트 등) --%>
                    <div class="swiper-slide">
                        <img src="/upload/003.png" alt="Slide 3">
                        <div class="slide-text-box">
                            <%-- 여기에 텍스트 필요할 경우 p태그 h태그로 넣어주세요 --%>
                        </div>
                    </div>
                </div>
                <%-- 하단 점(Pagination) 영역 --%>
                <div class="swiper-pagination"></div>
            </div>
        </section>

        <%-- NEW ARRIVALS 섹션 --%>
        <section class="curation-section">
            <div class="section-header">
                <h2 class="section-title">NEW ARRIVALS</h2>
                <a href="/product/new/all" class="view-more">VIEW ALL +</a>
            </div>

            <div class="grid-container">
                <c:forEach var="item" items="${newList}" >
                    <%-- 클릭 시 이동하는 ID값도 c:out으로 안전하게 처리 --%>
                    <div class="product-card" onclick="location.href='/product/detail?productId=<c:out value="${item.productId}"/>'">

                        <button type="button" class="btn-wish-icon ${item.wished ? 'active' : ''}"
                                onclick="toggleWishList(event, '<c:out value="${item.productId}"/>', this)">
                            ♥
                        </button>

                        <div class="img-box">
                            <img src="${not empty item.imageUrl ? item.imageUrl : '/img/no-image.jpg'}"
                                 alt="<c:out value='${item.name}' />">
                        </div>
                        <div class="info-box">
                                <%-- 브랜드명과 상품명에 c:out 적용 --%>
                            <p class="brand"><c:out value="${item.brandName}" default="LALA BOUTIQUE" /></p>
                            <p class="name"><c:out value="${item.name}" /></p>
                            <p class="price">₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

        <%-- WEEKLY BEST 섹션 --%>
        <section class="curation-section">
            <div class="section-header">
                <h2 class="section-title">WEEKLY BEST</h2>
                <a href="/product/best/all" class="view-more">VIEW ALL +</a>
            </div>

            <div class="grid-container">
                <c:forEach var="item" items="${bestList}">
                    <div class="product-card" onclick="location.href='/product/detail?productId=<c:out value="${item.productId}"/>'">

                        <button type="button" class="btn-wish-icon ${item.wished ? 'active' : ''}"
                                onclick="toggleWishList(event, '<c:out value="${item.productId}"/>', this)">
                            ♥
                        </button>

                        <div class="img-box">
                            <img src="${not empty item.imageUrl ? item.imageUrl : '/img/no-image.jpg'}"
                                 alt="<c:out value='${item.name}' />">
                        </div>
                        <div class="info-box">
                            <p class="brand"><c:out value="${item.brandName}" default="LALA BOUTIQUE" /></p>
                            <p class="name"><c:out value="${item.name}" /></p>
                            <p class="price">₩ <fmt:formatNumber value="${item.price}" pattern="#,###"/></p>
                        </div>
                    </div>
                </c:forEach>
            </div>
        </section>

    </main>

    <jsp:include page="/common/footer.jsp" />

</div>

<%-- ★ [추가] Swiper JS 라이브러리 --%>
<script src="https://cdn.jsdelivr.net/npm/swiper@12/swiper-bundle.min.js"></script>

<script>
    /* =========================================
       ★ [추가] Swiper 초기화 및 자동 롤링 설정
       ========================================= */
    document.addEventListener('DOMContentLoaded', function() {
        var swiper = new Swiper(".main-swiper", {
            loop: true, // 무한 반복
            autoplay: {
                delay: 4000, // 4초마다 자동 넘김
                disableOnInteraction: false, // 고객이 건드려도 자동 넘김 유지
            },
            pagination: {
                el: ".swiper-pagination",
                clickable: true, // 점 누르면 해당 슬라이드로 이동
            },
            effect: "fade", // 사진이 밀리는 대신 부드럽게 겹쳐서 바뀌는 효과 (고급스러움 추가)
            fadeEffect: {
                crossFade: true
            }
        });
    });

    /* --- 기존 하트(위시리스트) 로직 완벽 복구 --- */
    function toggleWishList(event, productId, btnElement) {
        event.stopPropagation();
        event.preventDefault();

        // 생략되었던 fetch 옵션 원복!
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
                }
                else if (result === 'add') {
                    btnElement.classList.add('active');
                    showToast('위시리스트에 담았습니다.');

                    // ★ [여기에 추가!] 헤더에 있는 N 뱃지 띄우기 함수 호출
                    if (typeof showWishNewBadge === 'function') {
                        showWishNewBadge();
                    }
                }
                else if (result === 'remove') {
                    btnElement.classList.remove('active');
                    showToast('위시리스트에서 삭제했습니다.');
                }
            })
            .catch(err => {
                console.error(err);
                alert("서버 통신 중 오류가 발생했습니다.");
            });
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