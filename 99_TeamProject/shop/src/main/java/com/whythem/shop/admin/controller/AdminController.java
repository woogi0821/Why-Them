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
    public String addProcess(AdminVO product) throws Exception {
        // 서비스에서 발생한 예외가 여기까지 전달됩니다.
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
    public String updateProcess(AdminVO product) throws Exception {
        // 수정 로직 역시 서비스에서 예외를 던지므로 throws를 붙입니다.
        adminService.updateAdminProduct(product);

        return "redirect:/admin/admin_main";
    }

// 6. 상품 삭제
    @PostMapping("/product/delete") // @GetMapping에서 @PostMapping으로 변경
    public String deleteProcess(@RequestParam("productId") Long productId) {
        // 서비스 호출 (이미지 파일 삭제 + DB 삭제 로직이 들어있어야 함)
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