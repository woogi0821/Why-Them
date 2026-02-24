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

    @Transactional
    public void addCart(Long memberId, CartItemVO cartItemVO) {
        CartVO cart = cartMapper.getCartByMemberId(memberId);

        if (cart == null) {
            cart = new CartVO();
            cart.setMemberId(memberId);
            cartMapper.insertCart(cart);
        }

        cartItemVO.setCartId(cart.getCartId());
        cartMapper.insertCartItem(cartItemVO);
    }

    public List<CartItemVO> getMyCartList(Long memberId) {
        CartVO cart = cartMapper.getCartByMemberId(memberId);
        if (cart == null) {
            return List.of();
        }
        return cartMapper.getCartItemList(cart.getCartId());
    }

    /**
     * 🚩 추가: 판매 중인(SALE) 상품들만의 합계 금액 계산
     * 장바구니 리스트를 받아와서 'SALE' 상태인 상품의 (가격 * 수량)을 모두 더합니다.
     */
    public long calculateTotalPrice(List<CartItemVO> cartList) {
        if (cartList == null || cartList.isEmpty()) {
            return 0;
        }

        return cartList.stream()
                .filter(item -> "SALE".equals(item.getStatus())) // 🚩 판매 중인 상품만 필터링
                .mapToLong(item -> item.getPrice() * item.getQuantity()) // 가격 * 수량
                .sum(); // 합계
    }

    public void updateQuantity(Long cartItemId, int quantity) {
        CartItemVO item = new CartItemVO();
        item.setCartItemId(cartItemId);
        item.setQuantity(quantity);
        cartMapper.updateCartItemQuantity(item);
    }

    public void removeCartItem(Long cartItemId) {
        cartMapper.deleteCartItem(cartItemId);
    }
}