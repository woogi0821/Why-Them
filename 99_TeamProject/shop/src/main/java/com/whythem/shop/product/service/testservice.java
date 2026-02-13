package com.whythem.shop.product.service;

import com.whythem.shop.product.mapper.testMapper;
import com.whythem.shop.product.vo.testvo;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class testservice {
  private final testMapper testMapper;


    public testservice(testMapper testMapper) {
        this.testMapper = testMapper;
    }
    public List<testvo> getTestList(Long categoryId){
        return testMapper.getTestList(categoryId);
    }
    public testvo findById(Long productId){
        return testMapper.findById(productId);
    }
}
