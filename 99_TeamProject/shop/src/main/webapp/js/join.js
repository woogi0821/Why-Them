window.onload = function (){
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('error') === 'true'){
        alert("회원가입에 실패했습니다. \n입력 정보를 다시 확인해주세요.");
    }
};

function joinCheck() {
    // 1. [입력 요소] 가져오기
    var id = document.getElementById("userId");
    var pw = document.getElementById("userPw");
    var name = document.getElementById("memberName");
    var email = document.getElementById("email");
    var phone = document.getElementById("phoneNumber");
    var zip = document.getElementById("zipCode"); // 주소 검사용 (우편번호)

    // 2. [에러 메시지 표시 공간] 가져오기 (HTML에 만들어둔 span 태그들)
    var idMsg = document.getElementById("idMsg");
    var pwMsg = document.getElementById("pwMsg");
    var nameMsg = document.getElementById("nameMsg");
    var emailMsg = document.getElementById("emailMsg");
    var phoneMsg = document.getElementById("phoneMsg");
    var addrMsg = document.getElementById("addrMsg");

    // 3. [초기화] 검사 시작 전에 기존 에러 메시지 싹 지우기 (깨끗하게 리셋)
    idMsg.innerText = "";
    pwMsg.innerText = "";
    nameMsg.innerText = "";
    emailMsg.innerText = "";
    phoneMsg.innerText = "";
    addrMsg.innerText = "";

    // 4. 유효성 검사 시작

    // [ID 검사]
    if (id.value.trim().length === 0) {
        idMsg.innerText = "아이디는 필수 입력 사항입니다."; // ★ 여기에 빨간 글씨 넣음
        id.focus(); // 스크롤 이동
        return false;
    }

    // [비밀번호 검사]
    if (pw.value.length < 8) {
        pwMsg.innerText = "비밀번호는 8글자 이상이어야 합니다.";
        pw.focus();
        return false;
    }

    // [이름 검사]
    if (name.value.trim().length === 0) {
        nameMsg.innerText = "이름을 입력해주세요.";
        name.focus();
        return false;
    }

    // [이메일 검사]
    if (email.value.trim().length === 0) {
        emailMsg.innerText = "이메일을 입력해주세요.";
        email.focus();
        return false;
    }

    // [전화번호 검사]
    if (phone.value.trim().length === 0) {
        phoneMsg.innerText = "전화번호를 입력해주세요.";
        phone.focus();
        return false;
    }

    // [주소 검사] - 우편번호가 비어있으면 검색 안 한 것
    if (zip.value.trim().length === 0) {
        addrMsg.innerText = "주소 검색(SEARCH)을 진행해주세요.";
        // 주소 검색 버튼이나 우편번호 칸으로 이동
        zip.focus();
        return false;
    }

    // 모든 검사 통과!
    return true;
}


function foldDaumPostcode(){
    var element_wrap = document.getElementById('wrap');
    element_wrap.style.display = 'none';
}

function kakaoPostcode(){
    var element_wrap = document.getElementById('wrap');

    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        theme: {
            bgColor: "#FFFFFF", //바탕 배경색
            searchBgColor: "#FFFFFF", //검색창 배경색
            contentBgColor: "#FFFFFF", //본문 배경색(검색결과,결과없음,첫화면,검색서제스트)
            pageBgColor: "#FFFFFF", //페이지 배경색
            textColor: "#333333", //기본 글자색
            queryTextColor: "#222222", //검색창 글자색
            postcodeTextColor: "#000000", //우편번호 글자색 (완전 블랙)
            emphTextColor: "#000000", //강조 글자색 (블루 대신 블랙)
            outlineColor: "#DDDDDD" //테두리
        },
        oncomplete: function (data){
            var addr = '';
            if (data.userSelectedType === 'R'){
                addr = data.roadAddress;
            }else {
                addr = data.jibunAddress;
            }
            document.getElementById('zipCode').value = data.zonecode;
            document.getElementById("baseAddress").value = addr;
            document.getElementById("detailAddress").focus();

            element_wrap.style.display = 'none';

            document.body.scrollTop = currentScroll;
        },
        onresize : function (size){
            element_wrap.style.height = size.height+'px';
        },
        width : '100%',height : '100%'
    }).embed(element_wrap);

    element_wrap.style.display = 'block';

    function checkId(){
        const id = document.getElementById('userId')
    }
}