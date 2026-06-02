package com.whythem.shop.cart.service;

import com.whythem.shop.cart.mapper.CartMapper;
import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.cart.vo.CartVO;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class CartService {

    private final CartMapper cartMapper;

    /**
     * 장바구니 담기
     * - 장바구니가 없으면 새로 생성
     * - 이미 담긴 상품이면 수량만 합산 (중복 방지)
     * - 새 상품이면 INSERT
     */
    @Transactional
    public void addCart(Long memberId, CartItemVO cartItemVO) {
        CartVO cart = cartMapper.getCartByMemberId(memberId);

        if (cart == null) {
            cart = new CartVO();
            cart.setMemberId(memberId);
            cartMapper.insertCart(cart);
        }

        cartItemVO.setCartId(cart.getCartId());

        // 동일 상품이 이미 담겨 있으면 수량 합산
        CartItemVO existing = cartMapper.getCartItemByProductId(cart.getCartId(), cartItemVO.getProductId());
        if (existing != null) {
            int newQty = existing.getQuantity() + cartItemVO.getQuantity();
            // 최대 99개 제한
            if (newQty > 99) newQty = 99;
            existing.setQuantity(newQty);
            cartMapper.updateCartItemQuantity(existing);
        } else {
            cartMapper.insertCartItem(cartItemVO);
        }
    }

    /**
     * 내 장바구니 목록 조회
     */
    public List<CartItemVO> getMyCartList(Long memberId) {
        CartVO cart = cartMapper.getCartByMemberId(memberId);
        if (cart == null) {
            return List.of();
        }
        return cartMapper.getCartItemList(cart.getCartId());
    }

    /**
     * 판매 중인(SALE) 상품들만의 합계 금액 계산
     */
    public long calculateTotalPrice(List<CartItemVO> cartList) {
        if (cartList == null || cartList.isEmpty()) {
            return 0;
        }
        return cartList.stream()
                .filter(item -> "SALE".equals(item.getStatus()))
                .mapToLong(item -> item.getPrice() * item.getQuantity())
                .sum();
    }

    /**
     * 수량 변경
     */
    public void updateQuantity(Long cartItemId, int quantity) {
        CartItemVO item = new CartItemVO();
        item.setCartItemId(cartItemId);
        item.setQuantity(quantity);
        cartMapper.updateCartItemQuantity(item);
    }

    /**
     * 장바구니 아이템 삭제
     */
    public void removeCartItem(Long cartItemId) {
        cartMapper.deleteCartItem(cartItemId);
    }
}
