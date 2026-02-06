/**
 * LALA BOUTIQUE - Integrated Master Script
 */

const luxuryNames = {
    coat: ["캐시미어 멜톤 롱 코트", "핸드메이드 더블 울 코트", "벨티드 미니멀 오버코트", "클래식 실루엣 트렌치"],
    shirts: ["실크 텍스처 릴렉스 셔츠", "핀스트라이프 파인 셔츠", "시그니처 옥스퍼드 셔츠", "프렌치 린넨 소프트 셔츠"],
    sweater: ["파인 메리노 울 니트", "캐시미어 블렌드 터틀넥", "헤비 케이블 풀오버", "모헤어 소프트 브이넥"],
    pants: ["테일러드 와이드 트라우저", "스트레이트 핏 울 팬츠", "프리미엄 로우 데님", "미니멀 벨티드 슬랙스"],
    skirts: ["플리츠 미디 스커트", "레더 실루엣 펜슬 스커트", "트위드 에이라인 스커트", "실크 슬립 맥시 스커트"],
    onepiece: ["플로럴 자카드 드레스", "미니멀 칼라 원피스", "니트 슬림 롱 드레스", "퍼프 슬리브 셔츠 드레스"],
    suit: ["싱글 브레스티드 수트", "더블 테일러드 셋업", "울 블렌드 체크 슈트", "모던 슬림핏 웨딩 슈트"],
    dressshoe: ["카프스킨 로우 더비", "포인티드 가죽 슬링백", "고트스킨 클래식 로퍼", "페이턴트 레더 펌프스"],
    sandals: ["미니멀 스트랩 샌들", "레더 위브 슬라이드", "플랫폼 버클 샌들", "스웨이드 소프트 샌들"],
    bag: ["카프스킨 미디 숄더백", "미니멀 레더 토트백", "퀼팅 체인 미니백", "캔버스 콤비 크로스백"],
    hat: ["울 펠트 페도라", "캐시미어 니트 비니", "코튼 베이스볼 캡", "라피아 와이드 선햇"]
};

const luxuryDescs = [
    "세련된 실루엣과 최상의 소재가 선사하는 고귀한 감각",
    "섬세한 디테일로 완성된 컨템포러리 미니멀리즘",
    "시간이 흐를수록 깊이를 더하는 클래식의 가치",
    "현대적인 감성으로 재해석한 익스클루시브 에디션"
];

window.onload = () => {
    renderProducts("COLLECTION", 'top/coat');
    updateAuthUI();
};

const renderProducts = (displayTitle, path) => {
    const titleEl = document.querySelector('#main-title');
    const gridEl = document.querySelector('#grid-root');
    if (!titleEl || !gridEl) return;

    titleEl.innerText = displayTitle;
    const subKey = path.split('/').pop();
    
    gridEl.innerHTML = Array.from({ length: 12 }, (_, i) => {
        const id = i + 1;
        const nameList = luxuryNames[subKey] || ["LALA BOUTIQUE PIECE"];
        const pName = nameList[i % nameList.length];
        const pDesc = luxuryDescs[i % luxuryDescs.length];
        const price = (185000 + (i * 45000)).toLocaleString();

        return `
            <article class="product-card" onclick="location.href='detail.html?path=${path}&id=${id}'">
                <img src="./img/${path}/${id}.jpg" alt="${pName}" 
                     onerror="this.src='https://via.placeholder.com/600x800?text=LALA+BOUTIQUE'">
                <div class="product-info">
                    <p class="p-name">${pName}</p>
                    <p class="p-desc">${pDesc}</p>
                    <p class="p-price">₩ ${price}</p>
                </div>
            </article>`;
    }).join('');
    
    window.scrollTo({ top: 0, behavior: 'smooth' });
};

const loadCategory = (path) => {
    const categoryTitle = path.split('/').pop().toUpperCase();
    renderProducts(categoryTitle, path);
};

const updateAuthUI = () => {
    const isLogin = localStorage.getItem("isLogin") === "true";
    const user = localStorage.getItem("loginUser");
    const authBtn = document.querySelector("#auth-btn");
    const userDisp = document.querySelector("#user-display");
    
    if (authBtn) authBtn.innerText = isLogin ? "LOGOUT" : "LOGIN";
    if (userDisp) {
        userDisp.style.display = isLogin ? "inline" : "none";
        userDisp.innerText = isLogin ? `${user}님 ` : "";
    }
};

const handleAuth = () => {
    if (localStorage.getItem("isLogin") === "true") {
        if (confirm("로그아웃 하시겠습니까?")) {
            localStorage.removeItem("isLogin");
            localStorage.removeItem("loginUser");
            location.reload();
        }
    } else {
        location.href = 'login.html';
    }
};

const executeWithdraw = () => {
    if (localStorage.getItem("isLogin") !== "true") return alert("로그인 후 이용 가능합니다.");
    if (confirm("정말 탈퇴하시겠습니까?")) {
        localStorage.clear();
        alert("탈퇴가 완료되었습니다.");
        location.href = 'homepage.html';
    }
};