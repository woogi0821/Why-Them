/**
 * LALA BOUTIQUE 핵심 로직 파일 (수정판)
 * 상세페이지는 비회원도 접근 가능하도록 변경함
 */

let isLoggedIn = localStorage.getItem("lala_login") === "true";
let cart = JSON.parse(localStorage.getItem("lala_cart")) || [];
let allProducts = [];

const categoryInfo = {
    "top/coat": "코트", "top/shirts": "셔츠", "top/sweater": "스웨터",
    "bottom/pants": "팬츠", "bottom/skirts": "스커트", "set/onepiece": "원피스",
    "set/suit": "슈트", "shoes/dressshoe": "구두", "shoes/sandal": "샌들",
    "acc/bag": "가방", "acc/hat": "모자",
};

const EXTRA_DATA = {
    "top/coat": {
        names: ["캐시미어 블렌드 로브", "헤링본 트위드 더블", "미니멀 히든 버튼 맥", "알파카 텍스처 롱", "클래식 체크 트렌치", "시어링 칼라 무스탕", "벨티드 카멜 헤어", "오버사이즈 구조적 울"],
        descs: ["부드러운 캐시미어 혼방 소재입니다.", "중량감 있는 헤링본 패턴의 코트입니다.", "깔끔한 맥코트 실루엣입니다.", "고급 알파카 소재의 롱 코트입니다.", "방수 기능이 있는 체크 트렌치입니다.", "보온성이 뛰어난 시어링 무스탕입니다.", "카멜 헤어 소재의 럭셔리 코트입니다.", "현대적인 오버사이즈 핏의 울 코트입니다."]
    },
    "shoes/sandal": {
        names: ["피셔맨 레더 샌들", "미니멀 스트랩 슬라이드", "플랫폼 스웨이드 샌들", "글래디에이터 카프 스킨", "투 스트랩 버클 슬리퍼", "에스파드류 웨지 샌들"],
        descs: ["천연 소가죽으로 제작된 클래식 피셔맨 샌들입니다.", "간결한 디자인의 슬라이드입니다.", "편안한 플랫폼 샌들입니다.", "세련된 라인의 글래디에이터입니다.", "가벼운 버클 슬리퍼입니다.", "휴양지 룩에 완벽한 웨지 샌들입니다."]
    }
};

const CONFIG = {
    mainSections: [
        { title: "EDITORIAL SELECTION", gridClass: "grid-4", category: "top/coat", itemIds: [1, 2, 3, 4] },
        { title: "ESSENTIAL DAILY", gridClass: "grid-3", category: "bottom/pants", itemIds: [1, 2, 3, 4, 5, 6] },
        { title: "SUMMER VIBES", gridClass: "grid-4", category: "shoes/sandal", itemIds: [1, 2, 3, 4] },
    ],
};

function initData() {
    allProducts = [];
    Object.keys(categoryInfo).forEach((path) => {
        const extra = EXTRA_DATA[path];
        for (let i = 1; i <= 12; i++) {
            let pName = extra && extra.names && extra.names[i - 1] ? extra.names[i - 1] : `${categoryInfo[path]} ${i}호`;
            let pDesc = extra && extra.descs && extra.descs[i - 1] ? extra.descs[i - 1] : `라라 부티크 고품격 컬렉션 상품입니다.`;
            allProducts.push({
                id: i, path: path, catName: categoryInfo[path], name: pName, desc: pDesc,
                price: (Math.floor(Math.random() * 80) + 40) * 10000, date: new Date(2026, 1, i),
            });
        }
    });
    updateUI();
}

function toggleLogin() {
    isLoggedIn = !isLoggedIn;
    localStorage.setItem("lala_login", isLoggedIn);
    updateUI();
    alert(isLoggedIn ? "로그인 되었습니다." : "로그아웃 되었습니다.");
}

function updateUI() {
    const authBtn = document.getElementById("auth-btn");
    const cartCnt = document.getElementById("cart-count");
    if(authBtn) authBtn.innerText = isLoggedIn ? "로그아웃" : "로그인";
    if(cartCnt) cartCnt.innerText = cart.length;
}

/**
 * [수정된 핵심 함수] goDetail
 * 설명: 로그인 여부와 상관없이 누구나 상세페이지를 볼 수 있게 합니다.
 */
function goDetail(pData) {
    const params = new URLSearchParams({ 
        path: pData.path, id: pData.id, name: pData.name, 
        price: pData.price, desc: pData.desc 
    });
    location.href = `detail.html?${params.toString()}`;
}

/**
 * [수정된 핵심 함수] checkAuthAndGo
 * 설명: 장바구니, 위시리스트 등 "회원 전용 기능"을 쓸 때만 체크합니다.
 */
function checkAuthAndGo(target) {
    if (!isLoggedIn) {
        if (confirm("비회원 로그인입니다.\n회원가입하시겠습니까?")) {
            location.href = "join.html";
        }
    } else {
        alert(`${target} 페이지로 이동합니다.`);
        // 실제 페이지가 있다면 location.href = `${target}.html`;
    }
}

// 그리드 렌더링 시 onclick 이벤트를 goDetail로 변경
function renderGrid(containerId, items) {
    const container = document.getElementById(containerId);
    if (!container) return;
    container.innerHTML = items.map((p) => `
        <div class="card" onclick='goDetail(${JSON.stringify(p)})'>
            <div class="img-box">
                <img src="img/${p.path}/${p.id}.jpg" alt="${p.name}" 
                     onerror="this.src='https://via.placeholder.com/600x800?text=${p.catName}'">
            </div>
            <div class="info-text">
                <p class="p-name">${p.name}</p>
                <p class="p-price">₩ ${p.price.toLocaleString()}</p>
            </div>
        </div>`).join("");
}

function loadHome() {
    const area = document.getElementById("main-content");
    if(!area) return;
    area.innerHTML = "";
    CONFIG.mainSections.forEach((section, idx) => {
        const gridId = `grid-${idx}`;
        area.innerHTML += `<h2 class="section-title">${section.title}</h2><div class="grid ${section.gridClass}" id="${gridId}"></div>`;
        const filtered = allProducts.filter(p => p.path === section.category && section.itemIds.includes(p.id));
        renderGrid(gridId, filtered);
    });
}

function loadCategory(path, title) {
    const area = document.getElementById("main-content");
    area.innerHTML = `<h2 class="section-title">${title}</h2><div class="grid grid-4" id="cat-grid"></div>`;
    renderGrid("cat-grid", allProducts.filter(p => p.path === path));
    window.scrollTo(0, 0);
}

function handleSearch() {
    const query = document.getElementById("search-input").value.trim();
    if (!query) { loadHome(); return; }
    const filtered = allProducts.filter(p => p.name.includes(query) || p.catName.includes(query));
    const area = document.getElementById("main-content");
    area.innerHTML = `<h2 class="section-title">RESULTS: ${query}</h2><div class="grid grid-4" id="res-grid"></div>`;
    renderGrid("res-grid", filtered);
}

function sortItems(type) {
    document.querySelectorAll(".filter-btns button").forEach(b => b.classList.remove("active"));
    const btn = document.getElementById(`btn-${type}`);
    if(btn) btn.classList.add("active");
    if (type === "low") allProducts.sort((a, b) => a.price - b.price);
    else if (type === "high") allProducts.sort((a, b) => b.price - a.price);
    else allProducts.sort((a, b) => b.date - a.date);
    if (document.getElementById("res-grid")) handleSearch(); else loadHome();
}

window.onload = () => { initData(); loadHome(); };