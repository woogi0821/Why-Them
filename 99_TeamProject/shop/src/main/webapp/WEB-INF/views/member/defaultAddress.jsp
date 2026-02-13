<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>

<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>

<style>
    /* ... 기존 스타일 유지 ... */
    .lala-form-wrapper {
        padding: 40px 20px;
        background: #fff;
        border-top: 1px solid #1a1a1a;
        margin-top: 30px;
        font-family: 'Noto Sans KR', sans-serif;
    }
    .lala-title {
        font-family: 'Cormorant Garamond', serif;
        font-size: 24px;
        font-weight: 600;
        text-transform: uppercase;
        letter-spacing: 2px;
        margin-bottom: 30px;
        color: #1a1a1a;
        text-align: center;
    }
    .lala-input-group { margin-bottom: 20px; position: relative; }
    .lala-label {
        display: block; font-size: 11px; color: #888; letter-spacing: 1px;
        margin-bottom: 5px; text-transform: uppercase;
    }
    .lala-input {
        width: 100%; padding: 10px 0; border: none; border-bottom: 1px solid #ddd;
        font-size: 13px; color: #333; outline: none; transition: border-color 0.3s; border-radius: 0;
    }
    .lala-input:focus { border-bottom: 1px solid #1a1a1a; }
    .lala-input[readonly] { color: #999; background-color: transparent; cursor: not-allowed; }

    .lala-btn-black {
        background: #1a1a1a; color: #fff; border: 1px solid #1a1a1a;
        padding: 12px 30px; font-size: 11px; letter-spacing: 2px; text-transform: uppercase;
        cursor: pointer; transition: all 0.3s; width: 100%;
    }
    .lala-btn-black:hover { background: #fff; color: #1a1a1a; }
    .lala-btn-outline {
        background: #fff; color: #1a1a1a; border: 1px solid #ddd;
        padding: 5px 10px; font-size: 10px; cursor: pointer; letter-spacing: 1px;
    }

    /* ★ [추가] 미니 버튼 (+ / -) 스타일 */
    .btn-mini {
        background: #fff; border: 1px solid #ddd; color: #1a1a1a;
        width: 30px; height: 30px; line-height: 28px; text-align: center;
        cursor: pointer; font-size: 16px; margin-left: 5px;
        display: inline-block; transition: all 0.2s;
    }
    .btn-mini:hover { background: #1a1a1a; color: #fff; border-color: #1a1a1a; }
    .btn-mini.remove { color: #d9534f; border-color: #d9534f; } /* 삭제 버튼은 붉은색 포인트 */
    .btn-mini.remove:hover { background: #d9534f; color: #fff; }

    .phone-row {
        display: flex;
        align-items: center;
        margin-bottom: 8px; /* 입력창 사이 간격 */
    }

    .lala-checkbox-wrapper {
        display: flex; align-items: center; gap: 8px; margin: 20px 0 30px;
        font-size: 12px; color: #555; justify-content: center;
    }
</style>

<div class="lala-form-wrapper">

    <h4 class="lala-title">New Address</h4>

    <form action="/member/address/save" method="post" name="addrForm">

        <input type="hidden" name="from" value="${empty param.from ? 'mypage' : param.from}">

        <div class="lala-input-group">
            <label class="lala-label">User Name</label>
            <input type="text" class="lala-input" value="${sessionScope.loginMember.memberName}" readonly>
        </div>

        <div class="lala-input-group">
            <label class="lala-label">Address Name</label>
            <input type="text" class="lala-input" name="addressName" placeholder="ex) HOME, OFFICE" required>
        </div>

        <div style="display: flex; gap: 20px; align-items: flex-start;">

            <div class="lala-input-group" style="flex: 1;">
                <label class="lala-label">Recipient</label>
                <input type="text" class="lala-input" name="recipientName" placeholder="수령인 이름" required>
            </div>

            <div class="lala-input-group" style="flex: 1.5;">
                <label class="lala-label">Phone</label>

                <div id="phone-container">
                    <div class="phone-row">
                        <input type="text" class="lala-input" name="recipientPhone"
                               placeholder="010-0000-0000" required
                               oninput="autoHyphen(this)" maxlength="13">

                        <button type="button" class="btn-mini" onclick="addPhoneField()">+</button>
                    </div>
                </div>
            </div>
        </div>

        <div class="lala-input-group">
            <label class="lala-label">Zip Code</label>
            <div style="display: flex; justify-content: space-between; align-items: flex-end;">
                <input type="text" id="daum_zipCode" name="zipCode" class="lala-input" style="width: 70%;" readonly required>
                <button type="button" class="lala-btn-outline" onclick="execDaumPostcode()">SEARCH</button>
            </div>
        </div>

        <div id="wrap" style="display:none; border:1px solid #1a1a1a; width:100%; height:300px; margin:5px 0; position:relative;">
            <img src="//t1.daumcdn.net/postcode/resource/images/close.png" id="btnFoldWrap" style="cursor:pointer;position:absolute;right:0px;top:-1px;z-index:1" onclick="foldDaumPostcode()" alt="접기 버튼">
        </div>

        <div class="lala-input-group">
            <input type="text" id="daum_addr1" name="baseAddress" class="lala-input" placeholder="기본 주소" readonly>
        </div>
        <div class="lala-input-group">
            <input type="text" id="daum_addr2" name="detailAddress" class="lala-input" placeholder="상세 주소를 입력해주세요">
        </div>

        <div class="lala-checkbox-wrapper">
            <input type="hidden" name="isDefault" value="N">
            <input type="checkbox" id="chk_default_${param.from}" name="isDefault" value="Y" style="accent-color: #1a1a1a;">
            <label for="chk_default_${param.from}" style="cursor: pointer;">Set as Default Address</label>
        </div>

        <div style="text-align: center;">
            <button type="submit" class="lala-btn-black">SAVE ADDRESS</button>
        </div>

    </form>
</div>

<script>
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
</script>