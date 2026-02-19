package com.whythem.shop.cart.service;

import com.whythem.shop.cart.vo.CartItemVO;
import org.junit.jupiter.api.DisplayName;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

// JUnit5 기본 단언문(Assert) 임포트
import static org.junit.jupiter.api.Assertions.*;

@SpringBootTest
@Transactional // ★ 필수: 테스트가 끝나면 방금 지지고 볶은 데이터를 싹 다 롤백해줍니다.
class CartServiceTest {

    @Autowired
    CartService cartService; // 테스트할 진짜 서비스 객체

    @Test
    @DisplayName("1. 장바구니 상품 추가 테스트")
    void addCart() {
        // given: 1번 회원(test)이 100번 상품(니트)을 5개 담을 준비
        Long memberId = 9L;
        CartItemVO newItem = new CartItemVO();
        newItem.setProductId(100L);
        newItem.setQuantity(5);

        // when: 담기 실행!
        cartService.addCart(memberId, newItem);

        // then: 내 장바구니를 불러와서 진짜로 늘어났는지 확인
        List<CartItemVO> myCart = cartService.getMyCartList(memberId);

        System.out.println("=== 🛒 담긴 후 장바구니 항목 개수: " + myCart.size());

        // 검증: 장바구니 목록이 비어있지 않고(true), 에러 없이 넘어갔다면 성공!
        assertTrue(myCart.size() > 0, "장바구니에 상품이 담겨야 합니다.");
    }

    @Test
    @DisplayName("2. 내 장바구니 목록 조회 테스트")
    void getMyCartList() {
        // given: 1번 회원
        Long memberId = 9L;

        // when: 목록 가져오기
        List<CartItemVO> myCart = cartService.getMyCartList(memberId);

        // then: 콘솔에 예쁘게 찍어보고 객체가 잘 나왔는지 검증
        System.out.println("=== 🎁 내 장바구니 목록 ===");
        for (CartItemVO item : myCart) {
            System.out.println("상품명: " + item.getProductName() + " | 수량: " + item.getQuantity() + " | 가격: " + item.getPrice());
        }

        assertNotNull(myCart, "장바구니 목록은 Null이 아니어야 합니다.");
    }

    @Test
    @DisplayName("3. 장바구니 수량 변경 테스트")
    void updateQuantity() {
        // given: 먼저 1번 회원의 장바구니 목록을 가져와서 첫 번째 항목을 타겟으로 잡음
        Long memberId = 9L;
        List<CartItemVO> myCart = cartService.getMyCartList(memberId);

        // data.sql에 미리 담아둔 게 없다면 테스트 중지
        if (myCart.isEmpty()) {
            fail("테스트를 진행할 장바구니 데이터가 없습니다.");
        }

        Long targetCartItemId = myCart.get(0).getCartItemId();
        int newQuantity = 99; // 수량을 99개로 파격 변경!


        cartService.updateQuantity(targetCartItemId, newQuantity);

        List<CartItemVO> updatedCart = cartService.getMyCartList(memberId);
        CartItemVO updatedItem = updatedCart.stream()
                .filter(item -> item.getCartItemId().equals(targetCartItemId))
                .findFirst()
                .orElse(null);

        System.out.println("=== 🔄 변경된 수량: " + updatedItem.getQuantity());
        assertEquals(99, updatedItem.getQuantity(), "수량이 99개로 변경되어야 합니다.");
    }

    @Test
    @DisplayName("4. 장바구니 삭제 테스트")
    void removeCartItem() {

        Long memberId = 9L;
        List<CartItemVO> beforeCart = cartService.getMyCartList(memberId);

        if (beforeCart.isEmpty()) {
            fail("테스트를 진행할 장바구니 데이터가 없습니다.");
        }

        int beforeSize = beforeCart.size();
        Long targetCartItemId = beforeCart.get(0).getCartItemId(); // 첫 번째 항목 날릴 예정


        cartService.removeCartItem(targetCartItemId);


        List<CartItemVO> afterCart = cartService.getMyCartList(memberId);
        System.out.println("=== 🗑️ 삭제 전 항목 수: " + beforeSize + " / 삭제 후 항목 수: " + afterCart.size());

        assertEquals(beforeSize - 1, afterCart.size(), "장바구니 항목 수가 1개 줄어들어야 합니다.");
    }
}