/**
 * LOGIN LOGIC - ES6+
 */
const processLogin = () => {
    const [id, pw] = ['login-id', 'login-pw'].map(el => document.getElementById(el).value);

    if (!id || !pw) return alert("아이디와 비밀번호를 모두 입력해주세요.");

    // 가입된 유저 목록 확인
    const users = JSON.parse(localStorage.getItem("userList") || "[]");
    const user = users.find(u => u.userId === id && u.userPw === pw);

    if (user) {
        // 로그인 상태 저장
        localStorage.setItem("isLogin", "true");
        localStorage.setItem("loginUser", user.userName);
        alert(`${user.userName}님, 환영합니다!`);
        location.href = 'homepage.html';
    } else {
        alert("아이디 또는 비밀번호가 일치하지 않습니다.");
    }
};