package com.whythem.shop.wishlist.mapper;

import com.whythem.shop.wishlist.vo.WishlistVO;
import org.apache.ibatis.annotations.Mapper;

import java.util.List;

@Mapper
public interface WishlistMapper {
    //위시리스트 목록 조회
    List<WishlistVO> selectMyWishlist(Long memberId);
    //위시리스트 추가 성공여부
    int insertWishlist(WishlistVO wishlistVO);
    //위시리스트 pk로 삭제 성공여부
    int deleteWishlist(Long wishId);
    //위시리스트 fk로 삭제 성공여부
    int deleteWishlistByMemberAndProduct(WishlistVO wishlistVO);
    //위시리스트 중복 체크 성공여부
    int checkWishlist(WishlistVO wishlistVO);
    //위시리스트 페이지 내 총 금액 표기(관리자 할인 구현예정)
    long selectTotalPrice(Long memberId);
    //찜목록 전체 삭제 성공여부
    int deleteAllWishlist(Long memberId);
}
