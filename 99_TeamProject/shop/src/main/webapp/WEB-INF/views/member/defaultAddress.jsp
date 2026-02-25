<%@ page language="java" contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<link rel="stylesheet" href="/css/member_defaultaddress.css">
<script src="//t1.daumcdn.net/mapjsapi/bundle/postcode/prod/postcode.v2.js"></script>


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

<script src="${pageContext.request.contextPath}/js/member_defaultaddress.js"></script>