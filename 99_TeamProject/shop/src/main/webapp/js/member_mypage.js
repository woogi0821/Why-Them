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

// 비밀번호 섹션 보여주기 함수
function showPasswordSection() {
    const section = document.getElementById("password-section");
    section.style.display = "block";
    section.scrollIntoView({ behavior: "smooth", block: "center" });
    document.getElementById("verifyId").focus();
}

// 폼 검사 함수
function validateResetForm() {
    const verifyId = document.getElementById("verifyId");
    const verifyName = document.getElementById("verifyName");
    const verifyPhone = document.getElementById("verifyPhone");
    const newPw = document.getElementById("newPw");
    const confirmPw = document.getElementById("confirmPw");
    const pwMsg = document.getElementById("pwMsg");

    pwMsg.textContent = "";

    if (!verifyId.value.trim()) {
        alert("본인 확인을 위해 아이디를 입력해주세요.");
        verifyId.focus();
        return false;
    }

    if (!verifyName.value.trim()) {
        alert("본인 확인을 위해 이름을 입력해주세요.");
        verifyName.focus();
        return false;
    }

    if (!verifyPhone.value.trim()) {
        alert("본인 확인을 위해 전화번호를 입력해주세요.");
        verifyPhone.focus();
        return false;
    }

    if (newPw.value !== confirmPw.value) {
        pwMsg.textContent = "비밀번호가 일치하지 않습니다.";
        pwMsg.className = "msg-area msg-error";
        confirmPw.focus();
        return false;
    }

    return confirm("입력하신 정보로 본인 확인 후 비밀번호를 변경하시겠습니까?");
}

// [NEW] ★ 오토 하이픈 함수 추가됨 ★
function autoHyphen(target) {
    target.value = target.value
        .replace(/[^0-9]/g, '') // 숫자 빼고 다 지움
        .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3") // 010-1234-5678 포맷
        .replace(/(\-{1,2})$/g, ""); // 끝에 남는 하이픈 제거
}
// 1. 회원 탈퇴 로직 (POST 방식이 안전하므로 동적 폼 생성)
function withdrawMember() {
    if(confirm("정말 라라 부티크를 탈퇴하시겠습니까?\n탈퇴 시 모든 정보와 적립금이 소멸됩니다.")) {
        let form = document.createElement("form");
        form.setAttribute("method", "post");
        // ★ 백엔드의 실제 탈퇴 URL에 맞게 수정해주세요! (예: /member/delete 등)
        form.setAttribute("action", "/member/withdraw");
        document.body.appendChild(form);
        form.submit();
    }
}

// 2. 현재 비밀번호 검증 (아까 복구한 /member/checkPw 활용)
let isCurrentPwVerified = false;

function verifyCurrentPw() {
    const currentPw = document.getElementById("currentPw").value;
    if(!currentPw) {
        alert("현재 비밀번호를 입력해주세요.");
        return;
    }

    fetch('/member/checkPw', {
        method: 'POST',
        headers: { 'Content-Type': 'application/x-www-form-urlencoded' },
        body: 'currentPw=' + encodeURIComponent(currentPw)
    })
        .then(response => response.text())
        .then(result => {
            const msgArea = document.getElementById("currentPwMsg");
            if(result === 'true') {
                msgArea.style.color = "#27ae60";
                msgArea.innerText = "비밀번호가 확인되었습니다. 새 비밀번호를 입력해주세요.";
                document.getElementById("currentPw").readOnly = true;
                document.getElementById("newPwArea").style.display = "block"; // 새 비밀번호 입력창 오픈!
                isCurrentPwVerified = true;
            } else {
                msgArea.style.color = "#e74c3c";
                msgArea.innerText = "비밀번호가 일치하지 않습니다.";
                isCurrentPwVerified = false;
            }
        })
        .catch(err => console.error(err));
}

// 3. 새 비밀번호 일치 실시간 검사
function checkNewPwMatch() {
    const newPw = document.getElementById("newPw").value;
    const confirmPw = document.getElementById("confirmPw").value;
    const msg = document.getElementById("pwMsg");

    if (confirmPw === "") { msg.innerText = ""; return; }

    if (newPw === confirmPw) {
        msg.style.color = "#27ae60";
        msg.innerText = "새 비밀번호가 일치합니다.";
    } else {
        msg.style.color = "#e74c3c";
        msg.innerText = "새 비밀번호가 일치하지 않습니다.";
    }
}

// 4. 최종 폼 제출 검증
function validateMyPageResetForm() {
    if(!isCurrentPwVerified) {
        alert("먼저 현재 비밀번호를 확인해주세요.");
        return false;
    }
    const newPw = document.getElementById("newPw").value;
    const confirmPw = document.getElementById("confirmPw").value;

    if(!newPw || newPw !== confirmPw) {
        alert("새 비밀번호를 정확히 입력 및 확인해주세요.");
        return false;
    }
    return confirm("비밀번호를 정말 변경하시겠습니까?");
}