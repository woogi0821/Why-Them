package com.whythem.shop.admin.service;

import com.whythem.shop.admin.mapper.TestMapper;
import com.whythem.shop.admin.vo.AdminVO;
import com.whythem.shop.admin.vo.TestVO;
import com.whythem.shop.common.CommonUtil;
import lombok.RequiredArgsConstructor;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;

@Service
@RequiredArgsConstructor
public class TestService {
    private final TestMapper testMapper;
    private final CommonUtil commonUtil;

    public List<TestVO> getAdminProductList(Long categoryId) {
        return testMapper.getTestProductList(categoryId);
    }
    public TestVO findTestProductById(Long productId){
        return testMapper.findTestProductById(productId);
    }
    @Transactional
    public void  registerTestProduct(TestVO product){
            testMapper.insertTestProduct(product);
    }
    @Transactional
    public void updateTestProduct(TestVO product){
        testMapper.updateTestProduct(product);
    }
    @Transactional
    public void deleteTestProduct(Long productId){
        testMapper.deleteTestProduct(productId);
    }

}
