package com.whythem.shop.admin.controller;

import com.whythem.shop.admin.service.AdminService;
import com.whythem.shop.admin.vo.AdminVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin") // 관리자 기능은 /admin 주소로 시작하도록 설정
public class AdminController {

    private final AdminService adminService;

    public AdminController(AdminService adminService) {
        this.adminService = adminService;
    }

    // 1. 관리자 메인 (상품 목록 관리 페이지)
    @GetMapping("/admin_main")
    public String adminShopPage(@RequestParam(value = "categoryId", required = false) Long categoryId, Model model) {
        // 관리자 서비스의 목록 조회 호출
        List<AdminVO> productList = adminService.getAdminProductList(categoryId);

        model.addAttribute("productList", productList);
        model.addAttribute("selectedCategory", categoryId);

        return "admin/admin_main"; // 관리자 메인 페이지 JSP 이름
    }

    // 2. 상품 등록 페이지 이동
    @GetMapping("/product/add")
    public String addPage() {
        return "admin/product_add";
    }

    // 3. 상품 등록 처리
    @PostMapping("/product/add")
    public String addProcess(AdminVO product) {
        MultipartFile file = product.getProductImage();

        if (file != null && !file.isEmpty()) {
            String path = saveFile(file);
            product.setImageUrl(path);
            // savedPaths.add(path); <- 이 부분도 이제 필요 없으니 삭제
        }

        // AdminService의 등록 메서드 호출 (인수 1개로 맞춤)
        adminService.registerAdminProduct(product);

        return "redirect:/admin/admin_main";
    }

    // 4. 상품 수정 페이지 이동
    @GetMapping("/product/edit")
    public String editPage(@RequestParam("productId") Long productId, Model model) {
        // AdminService의 상세 조회 호출
        AdminVO product = adminService.findAdminProductById(productId);
        model.addAttribute("product", product);

        return "admin/product_edit";
    }

    // 5. 상품 수정 처리
    @PostMapping("/product/edit")
    public String editProcess(AdminVO product) {
        if (product.getProductImage() != null && !product.getProductImage().isEmpty()) {
            product.setImageUrl(saveFile(product.getProductImage()));
        }

        // AdminService의 수정 메서드 호출
        adminService.updateAdminProduct(product);

        return "redirect:/admin/admin_main";
    }

    // 6. 상품 삭제 처리
    @GetMapping("/product/delete")
    public String deleteProcess(@RequestParam("productId") Long productId) {
        // AdminService의 삭제 메서드 호출
        adminService.deleteAdminProduct(productId);

        return "redirect:/admin/admin_main";
    }

    // [유틸리티] 파일 저장 로직
    private String saveFile(MultipartFile file) {
        if (file == null || file.isEmpty()) return null;
        try {
            String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            String uploadPath = "C:/Users/khuser/Desktop/images/";

            File folder = new File(uploadPath);
            if (!folder.exists()) folder.mkdirs();

            file.transferTo(new File(uploadPath, fileName));

            // DB에 "/upload/이름.jpg"로 저장해야 JSP에서 이미지가 잘 나옵니다.
            return "/upload/" + fileName;
        } catch (IOException e) {
            e.printStackTrace();
            return null;
        }
    }
}