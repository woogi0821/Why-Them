package com.whythem.shop.order.mapper;

import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.order.vo.OrderItemVO;
import com.whythem.shop.order.vo.OrderVO;
import com.whythem.shop.order.vo.PaymentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderMapper {
    //  1. 주문 생성 단계
    List<CartItemVO> getCartItemsByMember(Long memberId, List<Long> itemIds);    // 회원 장바구니 아이템 조회
    void insertOrder(OrderVO order);                                             // 주문 생성(insert 후 생성 된 orderId를 받아와야 함)
    void insertOrderItem(OrderItemVO orderItem);                                 // 주문 상세 생성(CartItem 정보를 바탕으로 삽입)
    void insertPayment(PaymentVO payment);                                       // 결제 대기 데이터 생성
    void deleteSelectedCartItems(@Param("memberId") Long memberId, @Param("itemIds") List<Long> itemIds);   // 장바구니 선택된 아이템 삭제

    //  2. 결제 단계
//    1) 결제 상태값 변경
    void updatePaymentStatus(@Param("orderId") Long orderId, @Param("status") String status);
    //    2) 주문 상태 변경 (주문접수 → 구매확정)
    void updateOrderStatus(@Param("orderId") Long orderId, @Param("status") String status);
    //    3) 주문 상품 재고 조회
    List<OrderItemVO> getOrderItems(Long orderId);                                          // 주문한 상품 목록 가져오기 (재고 차감을 위해)
    int reduceStock(@Param("productId") Long productId, @Param("quantity") int quantity);   // 상품 재고 차감
}
