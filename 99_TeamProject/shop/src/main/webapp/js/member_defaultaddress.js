// [NEW] 1. 연락처 추가 로직 (생성될 때도 오토하이픈 적용)
function addPhoneField() {
    var container = document.getElementById("phone-container");
    var currentCount = container.getElementsByClassName("phone-row").length;

    if (currentCount >= 5) {
        alert("연락처는 최대 5개까지만 등록 가능합니다.");
        return;
    }

    // 새로운 입력줄 생성
    var newRow = document.createElement("div");
    newRow.className = "phone-row";

    // [핵심] 여기서도 oninput="autoHyphen(this)" maxlength="13" 추가!
    newRow.innerHTML = `
            <input type="text" class="lala-input" name="recipientPhone"
                   placeholder="추가 연락처"
                   oninput="autoHyphen(this)" maxlength="13">
            <button type="button" class="btn-mini remove" onclick="removePhoneField(this)">-</button>
        `;

    container.appendChild(newRow);
}

// 2. 연락처 삭제 로직 (기존 동일)
function removePhoneField(btn) {
    var row = btn.parentNode;
    row.parentNode.removeChild(row);
}

// [NEW] ★ 3. 오토 하이픈 자동완성 함수 ★
function autoHyphen(target) {
    target.value = target.value
        .replace(/[^0-9]/g, '') // 숫자 이외의 문자 제거
        .replace(/^(\d{0,3})(\d{0,4})(\d{0,4})$/g, "$1-$2-$3") // 3-4-4 자리 하이픈 처리
        .replace(/(\-{1,2})$/g, ""); // 입력 중 끝에 붙은 하이픈 제거
}

// --- (아래는 기존 주소 찾기 스크립트 유지) ---
var element_wrap = document.getElementById('wrap');

function foldDaumPostcode() {
    element_wrap.style.display = 'none';
}

function execDaumPostcode() {
    var currentScroll = Math.max(document.body.scrollTop, document.documentElement.scrollTop);
    new daum.Postcode({
        oncomplete: function(data) {
            var addr = (data.userSelectedType === 'R') ? data.roadAddress : data.jibunAddress;
            document.getElementById('daum_zipCode').value = data.zonecode;
            document.getElementById('daum_addr1').value = addr;
            document.getElementById('daum_addr2').focus();
            element_wrap.style.display = 'none';
            document.body.scrollTop = currentScroll;
        },
        onresize : function(size) {
            element_wrap.style.height = size.height+'px';
        },
        width : '100%',
        height : '100%'
    }).embed(element_wrap);
    element_wrap.style.display = 'block';
}