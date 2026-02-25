package com.whythem.shop.order.controller;

import com.whythem.shop.member.vo.MemberAddressVO;
import com.whythem.shop.member.vo.MemberVO;
import com.whythem.shop.order.service.OrderService;
import com.whythem.shop.order.vo.OrderItemVO;
import com.whythem.shop.order.vo.PaymentVO;
import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.servlet.mvc.support.RedirectAttributes;

import java.util.List;

@Controller
public class OrderController {
    @Autowired
    private OrderService orderService;

    // STEP1. 주문처리
    // 상세페이지 주문
    @PostMapping("/order/directConfirm")
    public String createDirectOrder(HttpSession session,
                                    @RequestParam Long productId,
                                    @RequestParam(required = false, defaultValue = "1") int quantity) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long orderId = orderService.processDirectOrder(
            loginMember.getMemberId(),
            productId,
            quantity
        );

        return "redirect:/order/" + orderId + "/confirm";
    }
    // 장바구니 주문
    @PostMapping("/order/cartConfirm")
    public String createCartOrder(Model model, HttpSession session,
                                  @RequestParam List<Long> cartItemIds,
                                  @RequestParam Double totalPrice) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long orderId = orderService.processCartOrder(loginMember.getMemberId(), cartItemIds, totalPrice);

        return "redirect:/order/" + orderId + "/confirm";
    }

    @GetMapping("/order/{orderId}/confirm")
    public String confirmPage(Model model, HttpSession session,
                              @PathVariable Long orderId) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();
        List<OrderItemVO> orderItems = orderService.getOrderItems(orderId, memberId);
        MemberAddressVO memberInfo = orderService.getMemberInfo(memberId);

        double totalPrice = orderItems.stream()
            .mapToDouble(item -> item.getPrice() * item.getQuantity())
            .sum();

        model.addAttribute("orderItems", orderItems);
        model.addAttribute("memberInfo", memberInfo);
        model.addAttribute("totalPrice", totalPrice);
        model.addAttribute("orderId", orderId);

        return "order/confirm";
    }

//  STEP2. 결제처리
    @GetMapping("/order/{orderId}/payment")
    public String paymentPage(Model model, HttpSession session,
                              @PathVariable Long orderId) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        model.addAttribute("orderId", orderId);
        return "order/payment";
    }

    @PostMapping("/order/{orderId}/payment")
    public String processPayment(Model model, HttpSession session,
                                 @PathVariable Long orderId,
                                 @RequestParam("payment") String paymentMethod,
                                 RedirectAttributes redirectAttributes) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();

        try{
            orderService.completePayment(orderId, paymentMethod, memberId);
            redirectAttributes.addFlashAttribute("message", "결제가 완료되었습니다.");
            return "redirect:/order/" + orderId + "/complete";
        } catch (RuntimeException e) {
            model.addAttribute("msg", e.getMessage());
            model.addAttribute("orderId", orderId);

            return "order/payment";
        }
    }

    //  STEP3. 결제완료
    @GetMapping("/order/{orderId}/complete")
    public String completePage(Model model, HttpSession session,
                               @PathVariable Long orderId){
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        PaymentVO paymentInfo = orderService.getPaymentInfo(orderId);
        model.addAttribute("orderId", orderId);
        model.addAttribute("paymentMethod", paymentInfo.getPaymentMethod());
        model.addAttribute("amount", paymentInfo.getAmount());
        model.addAttribute("paidAt", paymentInfo.getPaidAt());

        return "order/complete";
    }


    // 주문 내역 확인
    @GetMapping("/order/list")
    public String orderHistory(Model model, HttpSession session) {
        MemberVO loginMember = (MemberVO) session.getAttribute("loginMember");
        if (loginMember == null) {
            return "redirect:/member/login";
        }

        Long memberId = loginMember.getMemberId();
        List<PaymentVO> payments = orderService.getMemberPayments(memberId);

        model.addAttribute("payments", payments);
        return "order/list";
    }

}
