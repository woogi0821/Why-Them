/**
 * LALA BOUTIQUE - Luxury Detail Logic
 */
window.onload = () => {
    const params = new URLSearchParams(location.search);
    const path = params.get('path');
    const id = params.get('id');

    if (!path || !id) {
        location.href = 'homepage.html';
        return;
    }

    renderDetail(path, id);
};

// 홈페이지와 동일한 한글 네이밍 데이터 사용
const luxuryNames = {
    coat: ["캐시미어 블렌드 롱 코트", "핸드메이드 울 더블 코트", "미니멀 벨티드 오버코트", "시그니처 트렌치 코트"],
    shirts: ["실크 텍스처 릴렉스 셔츠", "핀스트라이프 코튼 셔츠", "클래식 옥스퍼드 화이트 셔츠", "프렌치 린넨 밴드 셔츠"],
    sweater: ["파인 메리노 울 스웨터", "헤비 케이블 니트 풀오버", "소프트 캐시미어 터틀넥", "모헤어 블렌드 브이넥 니트"],
    pants: ["테일러드 와이드 슬랙스", "스트레이트 핏 울 트라우저", "프리미엄 데님 팬츠", "슬림 벨티드 치노"],
    // ... (필요시 나머지 데이터도 homepage.js와 동일하게 유지)
};

const renderDetail = (path, id) => {
    const subKey = path.split('/').pop();
    const idx = (parseInt(id) - 1) % 4;
    
    // 데이터 바인딩
    const pName = luxuryNames[subKey] ? luxuryNames[subKey][idx] : "라라 부티크 럭셔리 에디션";
    const price = (158000 + (idx * 32000)).toLocaleString();

    document.querySelector('#main-img').src = `./img/${path}/${id}.jpg`;
    document.querySelector('#p-category').innerText = subKey.toUpperCase();
    document.querySelector('#p-name').innerText = pName;
    document.querySelector('#p-price').innerText = `₩ ${price}`;
    
    // 이미지 로드 실패 시 대체
    document.querySelector('#main-img').onerror = function() {
        this.src = 'https://via.placeholder.com/800x1100?text=LALA+BOUTIQUE';
    };
};

const addToCart = () => {
    alert("선택하신 상품이 장바구니에 담겼습니다.");
};