package com.whythem.shop.cart.mapper;

import com.whythem.shop.cart.vo.CartVO;
import lombok.Getter;
import lombok.Setter;
import org.apache.ibatis.annotations.Mapper;
import java.util.List;

@Mapper // MyBatis 매퍼임을 선언 (스프링이 관리하도록 함)
@Getter
@Setter
public interface CartMapper {

    /**
     * 1. 특정 회원의 장바구니 목록 조회
     * XML의 <select id="getCartList">와 연결됨
     */
    List<CartVO> getCartList(Long memberId);

    /**
     * 2. 장바구니 수량 수정
     * XML의 <update id="updateQuantity">와 연결됨
     */
    void updateQuantity(CartVO cartVO);

    /**
     * 3. 장바구니 항목 삭제
     * XML의 <delete id="deleteCartItem">와 연결됨
     */
    void deleteCartItem(int cartId);
}