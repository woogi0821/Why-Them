package com.simplecoding.simplecontroller.controller.ex01;

import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;



@Controller
 public class BasicController {
    @RequestMapping(value = "/ex01/hello",method = RequestMethod.GET)
    public String hello() {
        return "/ex01/hello";
    }
}
