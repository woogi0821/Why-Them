package com.whythem.shop.cart.service;

import com.whythem.shop.cart.vo.CartVO;
import com.shop.mapper.CartMapper;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import java.util.List;

@Service // 인터페이스 없이 이 클래스 자체가 서비스 객체가 됩니다.
public class CartService {

    @Autowired
    private CartMapper cartMapper; // DB 통신을 위한 Mapper 주입

    /**
     * 특정 사용자의 장바구니 목록 조회
     */
    public List<CartVO> getCartList(Long memberId) {
        // 나중에 배송비 계산 logic 등을 여기에 추가하면 좋습니다.
        return cartMapper.getCartList(memberId);
    }

    /**
     * 장바구니 수량 수정
     */
    public void updateQuantity(CartVO cartVO) {
        cartMapper.updateQuantity(cartVO);
    }

    /**
     * 장바구니 상품 삭제
     */
    public void deleteCartItem(int cartId) {
        cartMapper.deleteCartItem(cartId);
    }
}