package com.whythem.shop.product.controller;

import com.whythem.shop.product.service.ProductService;
import com.whythem.shop.product.vo.ProductVO;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.multipart.MultipartFile;

import java.io.File;
import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.UUID;

@Controller
public class ProductController {
    private final ProductService productService;

    public ProductController(ProductService productService) {
        this.productService = productService;
    }

    @GetMapping("/shop")
    public String shopPage(@RequestParam(value = "categoryId", required = false) Long categoryId, Model model) {
        // 서비스 호출 시 categoryId 전달
        List<ProductVO> productList = productService.getProductList(categoryId);

        model.addAttribute("productList", productList);
        // 현재 선택된 카테고리가 무엇인지 JSP로 다시 알려줌 (메뉴 강조용)
        model.addAttribute("selectedCategory", categoryId);

        return "admin_main";
    }

    @GetMapping("/product/add")
    public String addPage() {
        return "product/product_add";
    }

    @PostMapping("/product/add")
    public String addProcess(ProductVO product) {
        // 1. 이미지를 담을 리스트 객체를 생성 (null 방지)
        List<String> savedPaths = new ArrayList<>();

        // 2. VO에서 파일을 꺼냄
        MultipartFile file = product.getProductImage();

        // 3. 파일이 비어있지 않은지 확인
        if (file != null && !file.isEmpty()) {
            // 파일 저장 서비스 실행 (저장된 경로 /upload/uuid_... 반환)
            String path = saveFile(file);

            // ProductVO(메인 테이블용)에 경로 저장
            product.setImageUrl(path);

            // 리스트(이미지 테이블용)에 경로 추가
            savedPaths.add(path);
        }

        // 4. 서비스 호출 (리스트를 반드시 포함)
        // 리스트가 비어있더라도(사진을 안 올렸더라도) null 대신 빈 리스트 객체가 전달되어야 안전합니다.
        productService.registerProduct(product, savedPaths);

        return "redirect:/shop";
    }
    @GetMapping("/main") // 이제 주소는 이거 하나면 충분합니다!
    public String customerMain(@RequestParam(value = "categoryId", required = false) Long categoryId, Model model) {

        // 1. 상품 리스트 가져오기 (categoryId가 null이면 전체, 아니면 필터링)
        List<ProductVO> productList = productService.getProductList(categoryId);
        model.addAttribute("productList", productList);
        model.addAttribute("selectedCategory", categoryId);

        // 2. 카테고리 이름 매칭 (기본값 설정)
        String categoryName = "ALL COLLECTIONS";

        // categoryId가 null이 아닐 때만 이름 변경 로직 실행
        if (categoryId != null) {
            if (categoryId == 1) categoryName = "COAT";
            else if (categoryId == 2) categoryName = "SHIRTS";
            else if (categoryId == 3) categoryName = "SWEATER";
            else if (categoryId == 4) categoryName = "PANTS";
            else if (categoryId == 5) categoryName = "SKIRTS";
            else if (categoryId == 6) categoryName = "ONEPIECE";
            else if (categoryId == 7) categoryName = "SUIT";
            else if (categoryId == 8) categoryName = "SSHOES";
            else if (categoryId == 9) categoryName = "SANDALS";
            else if (categoryId == 10) categoryName = "BAG";
            else if (categoryId == 11) categoryName = "HAT";
        }

        // 3. JSP로 전달
        model.addAttribute("categoryName", categoryName);

        return "product/index";
    }
    @GetMapping("/product/edit")
    public String editPage(@RequestParam("productId") Long productId, Model model) {
        // 1. 수정할 상품 정보를 DB에서 가져옴
        ProductVO product = productService.findById(productId);

        // 2. JSP로 데이터 전달
        model.addAttribute("product", product);

        // 3. product_edit.jsp 파일로 이동
        // (주의: WEB-INF/views/ 밑에 파일이 있다면 경로를 맞춰주세요)
        return "product/product_edit";
    }

    @PostMapping("/product/edit")
    public String editProcess(ProductVO product) {
        if (product.getProductImage() != null && !product.getProductImage().isEmpty()) {
            product.setImageUrl(saveFile(product.getProductImage()));
        }
        productService.updateProduct(product);
        return "redirect:/shop";
    }

    @GetMapping("/product/delete")
    public String deleteProcess(@RequestParam("productId") Long productId) {
        productService.deleteProduct(productId);
        return "redirect:/shop";
    }

    private String saveFile(MultipartFile file) {
        if (file == null || file.isEmpty()) return null;
        try {
            String fileName = UUID.randomUUID() + "_" + file.getOriginalFilename();
            String uploadPath = "C:/Users/khuser/Desktop/images/";
            File folder = new File(uploadPath);
            if (!folder.exists()) folder.mkdirs();
            file.transferTo(new File(uploadPath, fileName));
            return "/upload/" + fileName;
        } catch (IOException e) {
            return null;
        }
    }

}