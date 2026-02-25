window.onload = function () {
    const urlParams = new URLSearchParams(window.location.search);
    const msg = urlParams.get('msg');

    if (msg === 'session_expired'){
        alert("개인정보 보호를 위해 세션이 만료되었습니다.\n다시 로그인 해주세요.")
    }
}