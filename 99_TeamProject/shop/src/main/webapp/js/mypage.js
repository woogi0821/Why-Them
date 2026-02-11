function resetIdCheck() {
    const originalId = document.getElementById("originalId").value;
    const currentId = document.getElementById("loginId").value;
    const msgBox = document.getElementById("checkMsg");

    if(currentId === originalId) {
        document.getElementById("idCheckStatus").value = "1";
        msgBox.textContent = "";
    } else {
        document.getElementById("idCheckStatus").value = "0";
        msgBox.textContent = "아이디 중복 확인이 필요합니다.";
        msgBox.className = "msg-area msg-error";
    }
}

function checkDuplicateId() {
    const loginId = document.getElementById("loginId").value;
    const msgBox = document.getElementById("checkMsg");

    if(!loginId) {
        alert("아이디를 입력해주세요.");
        return;
    }

    fetch('/member/checkId?loginId=' + loginId)
        .then(response => response.json())
        .then(count => {
            if(count === 0) {
                msgBox.textContent = "사용 가능한 아이디입니다.";
                msgBox.className = "msg-area msg-success";
                document.getElementById("idCheckStatus").value = "1";
            } else {
                msgBox.textContent = "이미 사용 중인 아이디입니다.";
                msgBox.className = "msg-area msg-error";
                document.getElementById("idCheckStatus").value = "0";
            }
        })
        .catch(error => {
            console.error('Error:', error);
            alert("중복 확인 중 오류가 발생했습니다.");
        });
}

function validateForm() {
    const checkStatus = document.getElementById("idCheckStatus").value;
    if(checkStatus === "0") {
        alert("아이디 중복 확인을 해주세요!");
        document.getElementById("loginId").focus();
        return false;
    }
    return confirm("회원 정보를 수정하시겠습니까?");
}
// [NEW] 비밀번호 섹션 보여주기 함수
function showPasswordSection() {
    const section = document.getElementById("password-section");

    // 1. 보이게 설정
    section.style.display = "block";

    // 2. 부드럽게 스크롤 이동
    section.scrollIntoView({ behavior: "smooth", block: "center" });

    // 3. 아이디 입력창에 바로 포커스 (편의성)
    document.getElementById("verifyId").focus();
}

// [수정] 폼 검사 함수 (아이디 검사 추가)
function validateResetForm() {
    const verifyId = document.getElementById("verifyId"); // 아이디 입력창
    const verifyName = document.getElementById("verifyName");
    const verifyPhone = document.getElementById("verifyPhone");
    const newPw = document.getElementById("newPw");
    const confirmPw = document.getElementById("confirmPw");
    const pwMsg = document.getElementById("pwMsg");

    pwMsg.textContent = "";

    // 1. 아이디 확인 (추가됨)
    if (!verifyId.value.trim()) {
        alert("본인 확인을 위해 아이디를 입력해주세요.");
        verifyId.focus();
        return false;
    }

    // 2. 이름 확인
    if (!verifyName.value.trim()) {
        alert("본인 확인을 위해 이름을 입력해주세요.");
        verifyName.focus();
        return false;
    }

    // ... (나머지 전화번호, 비번 검사는 기존과 동일) ...

    if (newPw.value !== confirmPw.value) {
        pwMsg.textContent = "비밀번호가 일치하지 않습니다.";
        pwMsg.className = "msg-area msg-error";
        confirmPw.focus();
        return false;
    }

    return confirm("입력하신 정보로 본인 확인 후 비밀번호를 변경하시겠습니까?");
}