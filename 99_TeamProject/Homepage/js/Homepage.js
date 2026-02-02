/* [데이터 창고] 행님 폴더에 있는 파일명이랑 똑같이 맞췄심더 */
const productDB = [
    { id: 2, name: "럭셔리 가방 02", price: "159,000", cate: "가방", thum: "bag_02_thum.jpg", detail: "bag_02_thum.jpg" },
    { id: 3, name: "클래식 가방 03", price: "189,000", cate: "가방", thum: "bag_03_thum.jpg", detail: "bag_03_thum.jpg" },
    { id: 4, name: "화이트 가방 04", price: "210,000", cate: "가방", thum: "bag_04_thum.jpg", detail: "bag_04_thum.jpg" },
    { id: 5, name: "데일리 가방 05", price: "125,000", cate: "가방", thum: "bag_05_thum.jpg", detail: "bag_05_thum.jpg" },
    { id: 7, name: "레더 가방 07", price: "178,000", cate: "가방", thum: "bag_07_thum.jpg", detail: "bag_07_thum.jpg" },
    { id: 8, name: "심플 가방 08", price: "99,000", cate: "가방", thum: "bag_08_thum.jpg", detail: "bag_08_thum.jpg" },
    { id: 9, name: "모던 가방 09", price: "245,000", cate: "가방", thum: "bag_09_thum.jpg", detail: "bag_09_thum.jpg" },
    { id: 10, name: "스퀘어 가방 10", price: "167,000", cate: "가방", thum: "bag_10_thum.jpg", detail: "bag_10_thum.jpg" },
    { id: 11, name: "빈티지 가방 11", price: "142,000", cate: "가방", thum: "bag_11_thum.jpg", detail: "bag_11_thum.jpg" },
    { id: 12, name: "어반 가방 12", price: "135,000", cate: "가방", thum: "bag_12_thum.jpg", detail: "bag_12_thum.jpg" },
    { id: 13, name: "파우치 가방 13", price: "88,000", cate: "가방", thum: "bag_13_thum.jpg", detail: "bag_13_thum.jpg" },
    { id: 14, name: "체인 가방 14", price: "220,000", cate: "가방", thum: "bag_14_thum.jpg", detail: "bag_14_thum.jpg" },
    { id: 15, name: "캔버스 가방 15", price: "45,000", cate: "가방", thum: "bag_15_thum.jpg", detail: "bag_15_thum.jpg" },
    { id: 17, name: "호보 가방 17", price: "198,000", cate: "가방", thum: "bag_17_thum.jpg", detail: "bag_17_thum.jpg" },
    { id: 18, name: "라운드 가방 18", price: "110,000", cate: "가방", thum: "bag_18_thum.jpg", detail: "bag_18_thum.jpg" }
];

/* [공통 기능] 로그인 상태 확인 */
function checkAuth() {
    const authBox = document.getElementById('authLinks');
    if(sessionStorage.getItem('isAuth') && authBox) {
        const id = atob(sessionStorage.getItem('userKey'));
        authBox.innerHTML = `<span>${id}님 환영합니다</span>`;
    }
}