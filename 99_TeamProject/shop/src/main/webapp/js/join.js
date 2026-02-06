window.onload = function (){
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('error') === 'true'){
        alert("회원가입에 실패했습니다. \n입력 정보를 다시 확인해주세요.");
    }
};

// join.jsp 하단 스크립트 수정

function joinCheck() {

    const id = document.getElementById("loginId"); // .value 아님 (포커스 주려고 객체 가져옴)
    const pw = document.getElementById("loginPw");
    const name = document.getElementById("memberName");
    const phone = document.getElementById("memberPhone");

    const emailId = document.getElementById("emailId").value;
    const emailDomain = document.getElementById("emailDomain").value;

    if (!id.value.trim()) {
        alert("아이디는 필수입니다.");
        id.focus();
        return;
    }
    if (!pw.value.trim()) {
        alert("비밀번호를 입력해주세요.");
        pw.focus();
        return;
    }
    if (pw.value.length < 8) {
        alert("비밀번호는 8자 이상이어야 합니다.");
        pw.focus();
        return;
    }
    if (!name.value.trim()) {
        alert("이름을 입력해주세요.");
        name.focus();
        return;
    }
    if (!phone.value.trim()) {
        alert("연락처를 입력해주세요.");
        phone.focus();
        return;
    }

    if (!emailId || !emailDomain) {
        alert("이메일을 완성해주세요.");
        document.getElementById("emailId").focus();
        return;
    }


    // 이메일 값 합쳐서 히든 태그에 넣기
    if (emailId && emailDomain) {
        document.getElementById("fullEmail").value = emailId + "@" + emailDomain;
    } else {
        // 이메일이 선택사항이라 비워뒀다면, 빈 값("")을 넣어서 보냄 -> 이러면 null 에러 안 남!
        document.getElementById("fullEmail").value = "";
    }

    // 4. 모든 검문 통과 시 전송!
    document.getElementById("joinForm").submit();
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