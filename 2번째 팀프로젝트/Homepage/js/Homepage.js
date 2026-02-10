/* 상세 페이지 정보를 가져와서 화면에 뿌려주는 기능 
   주소창의 ?img=경로&name=이름 부분을 해석함 
*/
window.onload = function() {
    // 1. URL에서 파라미터 추출
    const params = new URLSearchParams(window.location.search);
    const imgPath = params.get('img');
    const prodName = params.get('name');

    // 2. 해당 데이터가 있으면 상세 페이지 요소에 삽입
    if (imgPath && prodName) {
        const imgElement = document.getElementById('detail-img');
        const nameElement = document.getElementById('detail-name');

        if (imgElement) imgElement.src = imgPath;
        if (nameElement) nameElement.innerText = prodName.toUpperCase();
    }
};