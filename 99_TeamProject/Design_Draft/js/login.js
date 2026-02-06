/**
 * LALA BOUTIQUE - Minimalist Login Logic
 */
const executeLogin = () => {
    const idValue = document.querySelector('#uid').value.trim();
    const pwValue = document.querySelector('#upw').value.trim();

    if (!idValue || !pwValue) {
        alert("입력 정보를 다시 확인해 주세요.");
        return;
    }

    const savedUser = JSON.parse(localStorage.getItem(idValue));

    // 로직 보존: 아이디 비밀번호 일치 확인 [cite: 2026-02-04]
    if (savedUser && savedUser.upw === pwValue) {
        localStorage.setItem("isLogin", "true");
        localStorage.setItem("loginUser", savedUser.uname);
        
        alert(`${savedUser.uname.toUpperCase()}님, 반갑습니다.`);
        location.href = 'homepage.html';
    } else {
        alert("아이디 또는 비밀번호가 올바르지 않습니다.");
        document.querySelector('#upw').value = "";
        document.querySelector('#upw').focus();
    }
};

// Enter 키로 로그인 실행
document.addEventListener('keypress', (e) => {
    if (e.key === 'Enter') executeLogin();
});