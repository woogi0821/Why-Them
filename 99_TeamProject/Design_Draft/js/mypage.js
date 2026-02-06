/**
 * MY PAGE LOGIC
 */
window.onload = () => {
    const loginUser = localStorage.getItem("loginUser");
    const users = JSON.parse(localStorage.getItem("userList") || "[]");
    const user = users.find(u => u.userName === loginUser);

    if (user) {
        document.getElementById('user-id').value = user.userId;
        document.getElementById('user-name').value = user.userName;
        document.getElementById('user-phone').value = user.userPhone;
        document.getElementById('user-addr').value = user.userAddr;
    }
};

const updateProfile = () => {
    const users = JSON.parse(localStorage.getItem("userList") || "[]");
    const loginUser = localStorage.getItem("loginUser");
    
    // 수정한 정보 반영 (map 활용)
    const updatedUsers = users.map(u => {
        if (u.userName === loginUser) {
            u.userName = document.getElementById('user-name').value;
            u.userPhone = document.getElementById('user-phone').value;
            // 이름 수정 시 로그인 세션 이름도 변경
            localStorage.setItem("loginUser", u.userName);
        }
        return u;
    });

    localStorage.setItem("userList", JSON.stringify(updatedUsers));
    alert("정보가 성공적으로 수정되었습니다.");
    location.reload();
};