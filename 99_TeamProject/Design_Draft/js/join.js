/**
 * JOIN PAGE LOGIC
 */

// 중복 확인 여부 체크 변수
let isIdChecked = false;

/**
 * 1. 아이디 중복 확인
 */
function checkDuplicate() {
    const id = document.getElementById('join-id').value;
    if (!id) return alert("아이디를 입력해주세요.");

    // 로컬스토리지에서 기존 유저 목록 가져오기 (배열 형태)
    const users = JSON.parse(localStorage.getItem("userList") || "[]");
    const isExist = users.some(user => user.userId === id);

    if (isExist) {
        alert("이미 사용 중인 아이디입니다.");
        isIdChecked = false;
    } else {
        alert("사용 가능한 아이디입니다.");
        isIdChecked = true;
        // 확인 후 아이디 수정 시 재확인 필요하도록 처리 가능
        document.getElementById('join-id').readOnly = true; 
    }
}

/**
 * 2. Daum 주소 API 연동
 */
function execDaumPostcode() {
    new daum.Postcode({
        oncomplete: function(data) {
            const addr = data.userSelectedType === 'R' ? data.roadAddress : data.jibunAddress;
            document.getElementById('postcode').value = data.zonecode;
            document.getElementById("address").value = addr;
            document.getElementById("detailAddress").focus();
        }
    }).open();
}

/**
 * 3. 회원가입 실행 (필수값 검증 및 데이터 저장)
 */
function processJoin() {
    // 입력값 가져오기
    const fields = ['join-id', 'join-pw', 'join-name', 'join-phone', 'address', 'detailAddress'];
    const values = {};
    fields.forEach(f => values[f] = document.getElementById(f).value);

    // 유효성 검사
    if (!isIdChecked) return alert("아이디 중복확인을 해주세요.");
    if (!values['join-pw'] || !values['join-name'] || !values['address']) return alert("모든 정보를 입력해주세요.");

    // 유저 데이터 구성
    const newUser = {
        userId: values['join-id'],
        userPw: values['join-pw'],
        userName: values['join-name'],
        userPhone: values['join-phone'],
        userAddr: `${values['address']} ${values['detailAddress']}`
    };

    // 기존 유저 목록에 추가 저장 (배열 방식)
    const users = JSON.parse(localStorage.getItem("userList") || "[]");
    users.push(newUser);
    localStorage.setItem("userList", JSON.stringify(users));

    alert(`${values['join-name']}님, 회원가입이 완료되었습니다!`);
    location.href = 'homepage.html';
}