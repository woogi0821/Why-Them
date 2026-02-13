package com.whythem.shop.product.controller;

import com.whythem.shop.product.service.testservice;
import com.whythem.shop.product.vo.testvo;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import java.util.List;

@Controller
public class testcontroller {
    private  final testservice testservice;

    public testcontroller(testservice testservice) {
        this.testservice = testservice;
    }
    @GetMapping("main")
    public String customerMain(Model model){
        List<testvo> testvoList = testservice.getTestList((null));
        model.addAttribute("testvoList", testvoList);
        return "index";
    }
}
