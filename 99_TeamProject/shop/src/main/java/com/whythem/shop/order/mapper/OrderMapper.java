package com.whythem.shop.order.mapper;

import com.whythem.shop.order.vo.CartItemVO;
import com.whythem.shop.order.vo.OrderItemVO;
import com.whythem.shop.order.vo.OrderVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderMapper {
    List<CartItemVO> getCartItemsByMember(Long memberId, List<Long> itemIds);    // 회원 장바구니 아이템 조회
    void insertOrder(OrderVO order);                                             // 주문 생성(insert 후 생성 된 orderId를 받아와야 함)
    void insertOrderItem(OrderItemVO orderItem);                                 // 주문 상세 생성(CartItem 정보를 바탕으로 삽입)
    void deleteSelectedCartItems(@Param("memberId") Long memberId,               // 장바구니 선택된 아이템 삭제
                                 @Param("itemIds") List<Long> itemIds);
}
