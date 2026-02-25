function fn_toggleAddrEdit() {
    const isEdit = $("#editMode").is(":visible");

    if (!isEdit) {
        // [변경] 클릭 시: 입력창 보여주기
        $("#viewMode").hide();
        $("#editMode").show();
        $("#addrEditBtn").text("적용");
    } else {
        // [적용] 클릭 시: 입력값을 텍스트로 옮기고 다시 숨기기
        const newName = $("#iptRecipientName").val();
        const newPhone = $("#iptRecipientPhone").val();
        const newAddr = $("#iptFullAddress").val();

        if(!newName || !newPhone || !newAddr) {
            alert("배송지 정보를 모두 입력해주세요.");
            return;
        }

        // 텍스트 업데이트
        $("#txtRecipientName").text(newName);
        $("#txtRecipientPhone").text(newPhone);
        $("#txtFullAddress").text(newAddr);

        $("#editMode").hide();
        $("#viewMode").show();
        $("#addrEditBtn").text("변경");
    }
}


function fn_payment() {
    var orderId = $("input[name='orderId']").val();

    if (!orderId) {
        alert("주문 정보가 없습니다.");
        return;
    }
    // payment 페이지로 이동
    window.location.href = "/order/" + orderId + "/payment";
}