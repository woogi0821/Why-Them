package com.whythem.shop.order.controller;

import com.whythem.shop.order.service.OrderService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.ModelAttribute;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;

    @PostMapping
    public String createDirectOrder(@RequestParam("memberId") Long memberId,
                                    @RequestParam("productId") Long productId,
                                    @RequestParam("price") Double price,
                                    @RequestParam("quantity") int quantity,
                                    Model model) {

        // 값 확인
        System.out.println("memberId = " + memberId);
        System.out.println("productId = " + productId);
        System.out.println("price = " + price);
        System.out.println("quantity = " + quantity);

        // 주문 Service 호출
//        Long orderId = orderService.processDirectOrder(memberId, productId, quantity, price * quantity);

        // 결제 페이지로 이동
        return "redirect:/order/order-confirm";
    }
}
