package com.simplecoding.simplecontroller;

import org.springframework.stereotype.Controller;

@Controller
public class HomeController {
    @org.springframework.web.bind.annotation.GetMapping("/")
    public String home(){
        return "home";
    }
}
