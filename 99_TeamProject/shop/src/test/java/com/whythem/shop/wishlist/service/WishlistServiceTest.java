package com.whythem.shop.wishlist.service;

import com.whythem.shop.wishlist.vo.WishlistVO;
import lombok.extern.log4j.Log4j2;
import org.junit.jupiter.api.Test;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.boot.test.context.SpringBootTest;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

import static org.assertj.core.api.Assertions.assertThat;

import static org.junit.jupiter.api.Assertions.*;

@Log4j2
@SpringBootTest
@Transactional
class WishlistServiceTest {
    @Autowired
    private WishlistService wishlistService;
    final Long TEST_MEMBER_ID = 9L;
    final Long TEST_PRODUCT_ID = 85L;

    @Test
    void testToggleWishlist() {
        WishlistVO togglewish = new WishlistVO();
        togglewish.setMemberId(TEST_MEMBER_ID);
        togglewish.setProductId(TEST_PRODUCT_ID);

        log.info("CASE 1 : 찜하기 INSERT 동작 기대 ");
        String result1 =wishlistService.toggleWishlist(togglewish);
        assertThat(result1).isEqualTo("add");

        List<WishlistVO> listAfterAdd = wishlistService.getMyWishlist(TEST_MEMBER_ID);
        boolean exists = listAfterAdd.stream().anyMatch(item ->item.getProductId().equals(TEST_PRODUCT_ID));
        assertThat(exists).isTrue();

        log.info("CASE 2 : 찜하기 취소 DELETE 동작 기대");
        String result2 = wishlistService.toggleWishlist(togglewish);
        assertThat(result2).isEqualTo("remove");

        List<WishlistVO> listAfterRemove = wishlistService.getMyWishlist(TEST_MEMBER_ID);
        boolean existsAfterRemove = listAfterRemove.stream().anyMatch(item -> item.getProductId().equals(TEST_PRODUCT_ID));
        assertThat(existsAfterRemove).isFalse();
    }

    @Test
    void getTotalPrice() {
        WishlistVO wishtotal = new WishlistVO();
        wishtotal.setMemberId(TEST_MEMBER_ID);
        wishtotal.setProductId(TEST_PRODUCT_ID);
        wishlistService.toggleWishlist(wishtotal);

        long total = wishlistService.getTotalPrice(TEST_MEMBER_ID);
        log.info("CASE 3 : 찜목록 총 금액 -" + total);

        assertThat(total).isGreaterThanOrEqualTo(0);
    }
}