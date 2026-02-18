package com.whythem.shop.cart.mapper;

import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.cart.vo.CartVO;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper
public interface CartMapper {

    CartVO getCartByMemberId(Long memberId);

    void insertCart(CartVO cartVO);


    void insertCartItem(CartItemVO cartItemVO);

    List<CartItemVO> getCartItemList(Long cartId);

    void updateCartItemQuantity(CartItemVO cartItemVO);

    void deleteCartItem(Long cartItemId);
}