package com.whythem.shop.order.mapper;

import com.whythem.shop.cart.vo.CartItemVO;
import com.whythem.shop.member.vo.MemberAddressVO;
import com.whythem.shop.order.vo.OrderItemVO;
import com.whythem.shop.order.vo.OrderVO;
import com.whythem.shop.order.vo.PaymentVO;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;

import java.util.List;

@Mapper
public interface OrderMapper {
    // 주문 생성 단계
    Double getProductPrice(Long productId);
    List<CartItemVO> getCartItemsByMember(Long memberId, List<Long> itemIds);
    void insertOrder(OrderVO order);
    void insertOrderItem(OrderItemVO orderItem);
    void insertPayment(PaymentVO payment);
    void deleteSelectedCartItems(@Param("memberId") Long memberId, @Param("itemIds") List<Long> productIds);

    // 주문 확인 단계
    List<OrderItemVO> selectOrderList(Long orderId, Long memberId);
    MemberAddressVO selectMemberById(Long memberId);

    // 결제 단계
    int updatePaymentCompleted(@Param("orderId") Long orderId, @Param("paymentMethod") String paymentMethod, @Param("status") String status);
    void updateOrderStatus(@Param("orderId") Long orderId, @Param("status") String status);
    List<OrderItemVO> getOrderItems(Long orderId);
    int reduceStock(@Param("productId") Long productId, @Param("quantity") int quantity);

    // 현재 재고 조회
    Integer getStockQuantity(Long productId);

    // 상품 상태 변경
    int updateProductStatus(@Param("productId") Long productId, @Param("status") String status);

    // 결제 확인
    PaymentVO selectPaymentByOrderId(@Param("orderId") Long orderId);
    List<PaymentVO> selectPaymentsByMemberId(@Param("memberId") Long memberId);
    void updatePaymentCartItems(@Param("orderId") Long orderId, @Param("cartItemIds") String cartItemIds);
    String getCartItemIdsByPayment(@Param("orderId") Long orderId);
}
