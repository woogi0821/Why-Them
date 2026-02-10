package com.whythem.shop.cart.vo;

import lombok.*;

import java.util.Date;
 // Lombok을 사용하면 Getter, Setter를 자동으로 생성해줍니다.
@Getter
@Setter
@ToString
@EqualsAndHashCode
public classCartVO {
    // 1. 장바구니 기본 정보
    private int cartId;        // 장바구니 고유 번호
    private String userId;     // 사용자 아이디
    private int productId;     // 상품 번호
    private int quantity;      // 수량
    private String sizeVal;    // 선택한 사이즈 (나이키 화면의 '사이즈 270')
    private Date createDate;   // 담은 날짜

    // 2. 화면 표시를 위한 상품 상세 정보 (Join 결과 담기)
    private String productName;  // 상품명 (에어 조던 1...)
    private String productImg;   // 상품 이미지 경로
    private String colorInfo;    // 색상 정보 (팬텀/세일/서밋 화이트...)
    private int price;           // 단가

    // 3. 계산된 필드
    private int totalPrice;      // 총 금액 (price * quantity)
}