package com.shop.controller;

import com.shop.model.CartVO;
import com.shop.service.CartService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import java.util.List;

@RestController
@RequestMapping("/api/cart")
@CrossOrigin(origins = "*") // 프론트엔드(React, Vue 등)와 통신할 때 발생하는 보안 이슈(CORS) 방지
public class CartController {

    @Autowired
    private CartService cartService;

    @GetMapping("/list/{memberId}")
    public List<CartVO> getCartList(@PathVariable("memberId") Long memberId) {
        // 서비스에게 해당 회원의 장바구니 목록을 가져오라고 시킵니다.
        return cartService.getCartList(memberId);
    }

    @PutMapping("/update")
    public ResponseEntity<String> updateQuantity(@RequestBody CartVO cartVO) {
        cartService.updateQuantity(cartVO);
        return ResponseEntity.ok("수량이 변경되었습니다.");
    }

    @DeleteMapping("/{cartId}")
    public ResponseEntity<String> deleteItem(@PathVariable("cartId") int cartId) {
        cartService.deleteCartItem(cartId);
        return ResponseEntity.ok("상품이 삭제되었습니다.");
    }
}