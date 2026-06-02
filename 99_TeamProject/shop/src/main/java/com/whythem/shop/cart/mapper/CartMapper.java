package com.whythem.shop.cart.mapper;

import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.cart.vo.CartVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface CartMapper {

    CartVO getCartByMemberId(Long memberId);

    void insertCart(CartVO cartVO);

    void insertCartItem(CartItemVO cartItemVO);

    List<CartItemVO> getCartItemList(Long cartId);

    /** 동일 상품이 이미 담겨 있는지 조회 (중복 담기 방지용) */
    CartItemVO getCartItemByProductId(@Param("cartId") Long cartId,
                                     @Param("productId") Long productId);

    void updateCartItemQuantity(CartItemVO cartItemVO);

    void deleteCartItem(Long cartItemId);
}
