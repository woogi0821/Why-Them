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