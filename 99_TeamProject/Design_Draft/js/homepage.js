/**
 * LALA BOUTIQUE - Integrated Final Logic
 */
window.onload = () => {
    // 초기 로딩: 에디터 픽으로 COAT 12개 출력
    renderProducts("Editor's Pick", 'top/coat');
    updateAuthUI();
};

/**
 * 카테고리별 12개 상품의 고유 이름 및 설명 데이터
 * 각 번호(1~12)에 맞춰 중복 없이 다르게 구성했습니다.
 */
const productData = {
    "coat": {
        name: "프리미엄 캐시미어 블렌드 코트",
        descriptions: [
            "부드러운 터치감의 최고급 캐시미어 혼방 소재", "우아한 실루엣을 완성하는 더블 브레스티드 라인", "세련된 도시적 감각의 미니멀 롱 코트", "보온성과 스타일을 모두 잡은 핸드메이드 마감",
            "클래식한 매력의 오버사이즈 테일러드 코트", "유연한 드레이프성이 돋보이는 숄 칼라 디자인", "고급스러운 광택이 흐르는 이탈리아산 울 소재", "벨트 디테일로 슬림한 라인을 강조한 코트",
            "차분한 톤의 멜란지 컬러가 매력적인 데일리 코트", "구조적인 어깨 라인이 돋보이는 모던 실루엣", "가벼우면서도 따뜻한 압축 울 펠트 공법 적용", "브랜드 헤리티지를 담은 시그니처 체크 코트"
        ]
    },
    "shirts": {
        name: "실루엣 오버핏 포플린 셔츠",
        descriptions: [
            "바스락거리는 질감이 매력적인 프리미엄 코튼", "자연스러운 구김마저 멋스러운 린넨 혼방 셔츠", "섬세한 스티치 라인이 돋보이는 드레스 셔츠", "여유로운 무드의 드롭 숄더 오버사이즈 핏",
            "은은한 진주 자개 단추로 더한 고급스러운 디테일", "격식 있는 자리에도 어울리는 깔끔한 밴드 칼라", "활동성을 고려한 뒷면 플리츠 디테일 적용", "부드러운 파스텔 톤의 실크 터치 셔츠",
            "스트라이프 패턴으로 경쾌함을 더한 포멀 셔츠", "가슴 포켓 포인트로 실용성을 높인 워크 셔츠", "와이드한 커프스 디자인이 돋보이는 커리어 룩", "단독으로도 레이어드로도 완벽한 에센셜 셔츠"
        ]
    },
    "sweater": {
        name: "헤리티지 모헤어 라운드 니트",
        descriptions: [
            "포근하게 몸을 감싸는 모헤어와 울의 조화", "입체적인 꽈배기 조직으로 완성한 클래식 니트", "섬세한 홀가먼트 기법으로 솔기 없는 편안함", "감각적인 컬러 배색이 돋보이는 아가일 니트",
            "보풀 걱정 없는 탄탄한 조직감의 메리노 울", "목선이 예뻐 보이는 우아한 보트넥 디자인", "포근한 겨울 감성을 담은 노르딕 패턴 니트", "가벼운 무게감에도 뛰어난 보온성을 자랑하는 캐시미어",
            "빈티지한 무드의 루즈핏 털실 짜임 니트", "소매 볼륨감을 살린 페미닌한 무드의 니트", "어디에나 매치하기 좋은 베이직한 리브 조직", "고급스러운 텍스처가 살아있는 브러쉬드 니트"
        ]
    },
    "pants": {
        name: "테일러드 스트레이트 슬랙스",
        descriptions: [
            "다리가 길어 보이는 하이웨이스트 스트레이트 핏", "움직임이 편안한 스트레치 소재의 데일리 슬랙스", "정교한 핀턱 디테일로 입체적인 라인 형성", "매끄러운 실루엣을 연출하는 울 블렌드 팬츠",
            "모던한 분위기의 와이드 레그 트라우저", "격식 있는 수트 셋업에 어울리는 포멀 팬츠", "자연스러운 텍스처의 코튼 치노 팬츠", "세련된 크롭 기장으로 경쾌함을 더한 팬츠",
            "고급스러운 광택감의 사틴 소재 카고 팬츠", "허리 밴딩 처리로 하루 종일 편안한 핏", "클래식한 체크 패턴이 가미된 브리티시 팬츠", "트렌디한 무드의 세미 부츠컷 데님 슬랙스"
        ]
    },
    "skirts": {
        name: "플리츠 실크 벨벳 스커트",
        descriptions: [
            "움직임에 따라 찰랑이는 정교한 플리츠 라인", "은은한 윤슬 같은 광택의 실크 새틴 스커트", "체형을 커버해 주는 우아한 A라인 실루엣", "계절감이 느껴지는 따뜻한 텍스처의 울 스커트",
            "다리 라인을 강조하는 슬릿 디테일 펜슬 스커트", "로맨틱한 무드를 자아내는 티어드 디자인", "고급스러운 자수 문양이 수놓아진 미디 스커트", "활동성을 높인 랩 스타일의 미니 스커트",
            "데님 소재로 캐주얼함을 더한 롱 스커트", "화려한 파티 룩에도 어울리는 벨벳 스커트", "미니멀한 무드의 레더 텍스처 스커트", "자연스러운 머메이드 라인이 돋보이는 스커트"
        ]
    },
    "onepiece": {
        name: "에테르 드레이프 실크 드레스",
        descriptions: [
            "한 폭의 그림 같은 우아한 드레이핑 디자인", "허리 라인을 잡아주는 페미닌한 셔츠 원피스", "최고급 실크 소재가 주는 부드러운 착용감", "격식 있는 자리를 빛내줄 트위드 미니 드레스",
            "여유로운 휴양지 무드의 맥시 드레스", "섬세한 레이스 디테일이 돋보이는 칵테일 드레스", "모던하고 깔끔한 라인의 슬리브리스 원피스", "니트 소재로 편안함과 스타일을 동시 잡은 드레스",
            "백 리스 포인트로 반전 매력을 더한 원피스", "클래식한 도트 패턴의 레트로풍 드레스", "세련된 배색 라인이 들어간 스포티 드레스", "풍성한 소매 볼륨이 특징인 로맨틱 드레스"
        ]
    },
    "suit": {
        name: "시그니처 더블 브레스티드 수트",
        descriptions: [
            "완벽한 핏을 완성하는 마스터 테일러의 수트", "최고급 원단으로 제작된 비즈니스 셋업", "모던한 감성의 오버사이즈 블레이저와 팬츠", "은은한 핀스트라이프 패턴의 클래식 수트",
            "여성스러운 라인을 강조한 슬림핏 재킷 셋업", "여유로운 무드의 린넨 소재 여름용 수트", "고급스러운 트위드 소재의 품격 있는 셋업", "미니멀한 디자인의 노카라 재킷 수트",
            "활동성을 극대화한 저지 소재의 컴포트 수트", "벨벳 소재로 우아함을 극대화한 이브닝 수트", "세련된 체크 패턴의 체크 테일러드 셋업", "구조적인 실루엣이 돋보이는 아방가르드 수트"
        ]
    },
    "dressshoe": {
        name: "클래식 카프스킨 페니 로퍼",
        descriptions: [
            "부드러운 카프스킨 레더로 완성한 로퍼", "이탈리아 장인의 손길이 닿은 수제 구두", "세련된 버클 디테일의 몽크 스트랩 슈즈", "안정적인 착화감을 선사하는 로우 힐 펌프스",
            "시크한 앞코 라인이 돋보이는 스틸레토 힐", "고급스러운 광택의 에나멜 옥스포드화", "데일리로 신기 좋은 미니멀한 슬링백", "쿠션 인솔로 장시간 착용에도 편안한 슈즈",
            "빈티지한 가공이 멋스러운 레더 부츠", "포멀한 룩의 완성, 클래식 레이스업 슈즈", "모던한 스퀘어 토 디자인의 레더 슈즈", "럭셔리한 금속 장식이 포인트인 로퍼"
        ]
    },
    "sandals": {
        name: "미니멀 스트랩 카프 레더 샌들",
        descriptions: [
            "발등을 가볍게 감싸는 미니멀 스트랩", "시원한 여름 무드의 에스파드류 샌들", "청키한 굽으로 스타일과 편안함을 동시에", "천연 가죽 소재의 베이직한 슬라이드",
            "발목을 가늘어 보이게 하는 앵클 스트랩", "세련된 메탈릭 컬러 포인트 샌들", "자연스러운 무드의 우드 굽 샌들", "스포티한 무드를 더한 플랫폼 샌들",
            "비대칭 스트랩으로 유니크함을 더한 슈즈", "보석 장식으로 화려함을 더한 샌들", "부드러운 스웨이드 질감의 뮬 샌들", "휴양지에서 빛나는 화려한 패턴 샌들"
        ]
    },
    "bag": {
        name: "타임리스 카세트 레더 숄더백",
        descriptions: [
            "견고한 가죽 질감이 돋보이는 숄더백", "데일리로 완벽한 사이즈의 실용적인 토트백", "미니멀한 디자인의 우아한 크로스백", "장인의 직조 기술이 들어간 인트레치아토",
            "귀여운 실루엣의 라운드 버킷백", "고급스러운 체인 스트랩이 포인트인 플랩백", "가벼운 외출에 적합한 레더 미니 파우치", "넉넉한 수납공간의 비즈니스 브리프케이스",
            "캔버스와 가죽의 조화가 세련된 캔버스백", "빈티지한 무드의 스웨이드 호보백", "세련된 클러치 스타일의 봉투형 백", "브랜드 로고가 각인된 시그니처 참 백"
        ]
    },
    "hat": {
        name: "울 펠트 클래식 소프트 페도라",
        descriptions: [
            "부드러운 울 펠트 소재의 클래식한 페도라", "포근한 겨울 무드를 완성하는 캐시미어 비니", "자외선 차단과 스타일을 동시에 챙기는 햇", "고급스러운 리본 장식이 들어간 클로슈",
            "캐주얼한 룩에 품격을 더하는 레더 캡", "프렌치 감성이 느껴지는 베이직 울 베레모", "시원한 라피아 소재의 여름용 보터 햇", "따뜻한 니트 짜임의 이어플랩 캡",
            "시크한 무드를 연출하는 가죽 베레모", "얼굴이 작아 보이는 와이드 브림 햇", "포근한 시어링 소재의 버킷 햇", "세련된 패턴이 가미된 자카드 햇"
        ]
    }
};

/**
 * 상품 렌더링 함수
 */
const renderProducts = (displayTitle, path) => {
    const titleEl = document.getElementById('main-title');
    const gridEl = document.getElementById('grid-root');
    if (!titleEl || !gridEl) return;

    titleEl.innerText = displayTitle;

    const subCategory = path.split('/')[1]; // 예: 'coat'
    const data = productData[subCategory] || { name: "라라 익스클루시브", descriptions: Array(12).fill("라라 부티크만의 특별한 감성을 담은 아이템") };

    gridEl.innerHTML = Array.from({ length: 12 }, (_, i) => {
        const id = i + 1;
        const price = (id * 15000 + 135000).toLocaleString();
        const description = data.descriptions[i]; // 각 번호별 고유 설명 추출

        return `
            <article class="product-card" onclick="location.href='detail.html?path=${path}&id=${id}'">
                <img src="./img/${path}/${id}.jpg" alt="${data.name}" onerror="this.src='https://via.placeholder.com/600x800?text=LALA+BOUTIQUE'">
                <div class="product-info">
                    <p class="p-name">${data.name}</p>
                    <p class="p-desc" style="font-size:10px; color:#aaa; margin:4px 0;">${description}</p>
                    <p class="p-price">₩ ${price}</p>
                </div>
            </article>`;
    }).join('');
    
    window.scrollTo({ top: 0, behavior: 'smooth' });
};

// 카테고리 로드
const loadCategory = (path) => {
    const categoryTitle = path.split('/')[1].toUpperCase();
    renderProducts(categoryTitle, path);
};

// 이하 인증(updateAuthUI, handleAuth, executeWithdraw) 코드는 기존과 동일하게 유지...
const updateAuthUI = () => {
    const isLogin = localStorage.getItem("isLogin") === "true";
    const user = localStorage.getItem("loginUser");
    const authBtn = document.getElementById("auth-btn");
    const userDisp = document.getElementById("user-display");

    if (isLogin && user) {
        authBtn.innerText = "LOGOUT";
        userDisp.innerText = `${user}님 `;
        userDisp.style.display = "inline";
    } else {
        if(authBtn) authBtn.innerText = "LOGIN";
        if(userDisp) userDisp.style.display = "none";
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
    if (confirm("정말 탈퇴하시겠습니까? 계정 정보가 모두 소멸됩니다.")) {
        localStorage.clear();
        alert("그동안 라라 부티크를 이용해주셔서 감사합니다.");
        location.href = 'homepage.html';
    }
};