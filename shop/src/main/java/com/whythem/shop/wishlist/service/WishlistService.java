package com.whythem.shop.wishlist.service;

import com.whythem.shop.wishlist.mapper.WishlistMapper;
import com.whythem.shop.wishlist.vo.WishlistVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Log4j2
@Service
@RequiredArgsConstructor
public class WishlistService {
    private final WishlistMapper wishlistMapper;

    public List<WishlistVO> getMyWishlist(Long memberId) {
        return wishlistMapper.selectMyWishlist(memberId);
    }

    @Transactional
    public String toggleWishlist(WishlistVO wishlistVO) {
        int count = wishlistMapper.checkWishlist(wishlistVO);

        if (count > 0) {
            wishlistMapper.deleteWishlistByMemberAndProduct(wishlistVO);
            log.info("찜 취소 완료 : member={},product={}", wishlistVO.getMemberId(), wishlistVO.getProductId());
            return "remove";
        } else {
            wishlistMapper.insertWishlist(wishlistVO);
            log.info("찜 하기 완료 : member={},product={}", wishlistVO.getMemberId(), wishlistVO.getProductId());
            return "add";
        }
    }
    @Transactional
    public int removeWishlist(Long wishId){
        return wishlistMapper.deleteWishlist(wishId);
    }
    public long getTotalPrice(Long memberId){
        return wishlistMapper.selectTotalPrice(memberId);
    }
    @Transactional
    public int removeAllWishlist(Long memberId){
        return wishlistMapper.deleteAllWishlist(memberId);
    }
}
