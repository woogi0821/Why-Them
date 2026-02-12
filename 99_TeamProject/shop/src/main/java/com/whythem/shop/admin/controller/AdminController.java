package com.whythem.shop.admin.controller;

import com.whythem.shop.admin.service.AdminService;
import com.whythem.shop.admin.vo.AdminVO;
import com.whythem.shop.common.CommonUtil; // 패키지 경로 일치 확인!
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
@Log4j2
@RequiredArgsConstructor // 생성자 주입 자동화
public class AdminController {

    private final AdminService adminService;
    private final CommonUtil commonUtil; // CommonUtil 추가

    @GetMapping("/admin_main")
    public String adminShopPage(@RequestParam(value = "categoryId", required = false) Long categoryId, Model model) {
        List<AdminVO> productList = adminService.getAdminProductList(categoryId);
        model.addAttribute("productList", productList);
        model.addAttribute("selectedCategory", categoryId);
        return "admin/admin_main";
    }

    @PostMapping("/product/add")
    public String addProcess(AdminVO product) {
        if (product.getProductImage() != null && !product.getProductImage().isEmpty()) {
            product.setImageUrl(saveFile(product.getProductImage()));
        }
        adminService.registerAdminProduct(product);
        return "redirect:/admin/admin_main";
    }

    @PostMapping("/product/edit")
    public String editProcess(AdminVO product) {
        if (product.getProductImage() != null && !product.getProductImage().isEmpty()) {
            product.setImageUrl(saveFile(product.getProductImage()));
        }
        adminService.updateAdminProduct(product);
        return "redirect:/admin/admin_main";
    }

    @GetMapping("/product/delete")
    public String deleteProcess(@RequestParam("productId") Long productId) {
        adminService.deleteAdminProduct(productId);
        return "redirect:/admin/admin_main";
    }

    // [수정된 로직] CommonUtil의 saveFile을 호출
    private String saveFile(MultipartFile file) {
        if (file == null || file.isEmpty()) return null;

        // 1. UUID 파일명 생성
        String uuidName = UUID.randomUUID().toString() + "_" + file.getOriginalFilename();

        try {
            // 2. CommonUtil을 통해 실제 폴더(C:/shop/upload/)에 저장
            commonUtil.saveFile(file, uuidName);
        } catch (Exception e) {
            log.error("파일 저장 실패: " + e.getMessage());
            throw new RuntimeException("파일 저장 중 에러 발생");
        }

        // 3. DB 저장용 경로
        return "/upload/" + uuidName;
    }
}