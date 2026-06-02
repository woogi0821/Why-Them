package com.whythem.shop.admin.controller;

import com.whythem.shop.admin.service.AdminService;
import com.whythem.shop.admin.vo.AdminVO;
import com.whythem.shop.common.CommonUtil; // 패키지 경로 일치 확인!
import com.whythem.shop.product.vo.ProductVO;
import lombok.RequiredArgsConstructor;
import lombok.extern.log4j.Log4j2;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;
import com.whythem.shop.product.service.ProductService;

import java.util.List;
import java.util.UUID;

@Controller
@RequestMapping("/admin")
@Log4j2
@RequiredArgsConstructor // 생성자 주입 자동화
public class AdminController {

    private final AdminService adminService;
    private final CommonUtil commonUtil; // CommonUtil 추가
    private final ProductService productService;

    // 1. 관리자 메인 (상품 목록 관리 페이지)
    @GetMapping("/admin_main")
    public String adminShopPage(@RequestParam(value = "categoryId", required = false) Long categoryId, Model model) {
        // 관리자 서비스의 목록 조회 호출
        List<AdminVO> productList = adminService.getAdminProductList(categoryId);

        model.addAttribute("productList", productList);
        model.addAttribute("selectedCategory", categoryId);
        model.addAttribute("stoppedCount", adminService.getStoppedProductCount());
        model.addAttribute("recentProducts", adminService.getRecentProducts(5));
        model.addAttribute("lowStockProducts", adminService.getLowStockProducts(5));

        return "admin/admin_main"; // 관리자 메인 페이지 JSP 이름
    }
    // 🚩 2. 판매 중지 상품 목록 조회 (추가)
    @GetMapping("/stopped_list") // 🚩 주소 확인
    public String stoppedList(Model model) throws Exception {
        List<AdminVO> stoppedList = adminService.getStoppedProductList();

        model.addAttribute("productList", stoppedList);
        model.addAttribute("showStopped", true); // 🚩 중요: 이게 있어야 사이드바가 반응함

        // selectedCategory는 보내지 않습니다. (null 상태 유지)
        return "admin/stopped_list";
    }

    // 3. 상품 등록 페이지 이동
    @GetMapping("/product/add")
    public String addPage() {
        return "admin/product_add";
    }

    // 4. 상품 등록 처리
    @PostMapping("/product/add")
    public String addProcess(AdminVO product) throws Exception {
        // 서비스에서 발생한 예외가 여기까지 전달됩니다.
        adminService.registerAdminProduct(product);
        return "redirect:/admin/admin_main";
    }

    // 5. 상품 수정 페이지 이동
    @GetMapping("/product/edit")
    public String editPage(@RequestParam("productId") Long productId, Model model) {
        // AdminService의 상세 조회 호출
        AdminVO product = adminService.findAdminProductById(productId);
        model.addAttribute("product", product);

        return "admin/product_edit";
    }

    // 6. 상품 수정 처리
    @PostMapping("/product/edit")
    public String updateProcess(AdminVO product) throws Exception {
        // 수정 로직 역시 서비스에서 예외를 던지므로 throws를 붙입니다.
        adminService.updateAdminProduct(product);

        return "redirect:/admin/admin_main";
    }

// 7. 상품 삭제
@PostMapping("/product/delete") // Get을 Post로 변경
public String deleteProcess(@RequestParam("productId") Long productId) throws Exception {
    adminService.deleteAdminProduct(productId);
    return "redirect:/admin/admin_main";
}
    // 🚩 8. 판매 재개 처리 (STOP -> SALE) (추가)
    @PostMapping("/product/restore")
    public String restoreProcess(@RequestParam("productId") Long productId) throws Exception {
        adminService.restoreAdminProduct(productId);
        // 복구 후에는 중지 목록 페이지로 다시 이동합니다.
        return "redirect:/admin/stopped_list";
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

    @GetMapping("/admin/product/list")
    public String adminProductList(Model model) {
        List<ProductVO> allProducts = productService.getAdminProductList();
        model.addAttribute("productList", allProducts);
        return "admin/product_list"; // 관리자 상품 목록 JSP 경로
    }
}