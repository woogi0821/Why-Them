// 1. 자동 하이픈
const autoHyphen = (target) => {
    target.value = target.value
        .replace(/[^0-9]/g, '')
        .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3").replace(/(\-{1,2})$/g, "");
}

// 2. 이메일 도메인 선택
function handleEmailSelect() {
    const select = document.getElementById("domainSelect");
    const domainInput = document.getElementById("emailDomain");

    if (select.value !== ""){
        domainInput.value = select.value;
        domainInput.readOnly = true;
        domainInput.style.backgroundColor = "#f9f9f9";
    } else {
        domainInput.value = "";
        domainInput.readOnly = false;
        domainInput.style.backgroundColor = "#fff";
        domainInput.focus();
    }
}

// 3. 주소 찾기 (레이어 방식)
var element_layer = document.getElementById('postcode-layer');

function closePostcode() {
    element_layer.style.display = 'none';
}

function togglePostcode() {
    if(element_layer.style.display === 'block') {
        closePostcode();
        return;
    }
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;

            document.getElementById('zipCode').value = data.zonecode;
            document.getElementById("baseAddress").value = addr;
            document.getElementById("detailAddress").focus();
            element_layer.style.display = 'none';
        },
        width : '100%',
        height : '100%',
        maxSuggestItems : 5
    }).embed(element_layer);
    element_layer.style.display = 'block';
}

// 4. 아이디 중복체크 (AJAX 연동 필요시 여기에 fetch/axios 추가)
function idCheck() {
    const id = document.getElementById("loginId").value;
    if(id.length < 4) {
        alert("아이디를 4자 이상 입력해주세요.");
        return;
    }
    // TODO: 실제 서버와 통신하는 AJAX 코드가 들어갈 자리
    // 지금은 임시로 성공 처리
    alert("사용 가능한 아이디입니다.");
    document.getElementById("idCheckFlag").value = "Y";
}

// 5. 최종 유효성 검사 및 전송
function joinCheck() {
    const id = document.getElementById("loginId");
    const pw = document.getElementById("loginPw");
    const name = document.getElementById("memberName");
    const phone = document.getElementById("memberPhone");
    const emailId = document.getElementById("emailId").value;
    const emailDomain = document.getElementById("emailDomain").value;

    if (!id.value.trim()) { alert("아이디는 필수입니다."); id.focus(); return; }
    if (!pw.value.trim()) { alert("비밀번호를 입력해주세요."); pw.focus(); return; }
    if (pw.value.length < 8) { alert("비밀번호는 8자 이상이어야 합니다."); pw.focus(); return; }
    if (!name.value.trim()) { alert("이름을 입력해주세요."); name.focus(); return; }
    if (!phone.value.trim()) { alert("연락처를 입력해주세요."); phone.focus(); return; }

    // 이메일 조합
    if (emailId && emailDomain) {
        document.getElementById("fullEmail").value = emailId + "@" + emailDomain;
    } else {
        alert("이메일을 완성해주세요.");
        document.getElementById("emailId").focus();
        return;
    }

    // 중복체크 확인 (선택사항 - 필요시 주석 해제)
    if(document.getElementById("idCheckFlag").value !== "Y"){
        alert("아이디 중복확인을 해주세요.");
        return;
    }

    // 전송
    document.getElementById("joinForm").submit();
}