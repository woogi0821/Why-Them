window.onload = function (){
    const urlParams = new URLSearchParams(window.location.search);
    if (urlParams.get('error') === 'true'){
        alert("회원가입에 실패했습니다. \n입력 정보를 다시 확인해주세요.");
    }
};

function joinCheck(){
    var id =document.getElementById("userId").value;
    var pw =document.getElementById("userPw").value;
    var name = document.getElementById("memberName").value;
    var zip = document.getElementById("zipCode").value;

    if (id.length === 0) {
        alert("아이디는 필수 입니다.");
        return false;
    }
    if (pw.length < 8){
        alert("비밀번호는 8글자 이상이어야 합니다.")
        return false;
    }
    if (zip.length === 0){
        alert("주소를 검색해주세요")
        return false
    }
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
}