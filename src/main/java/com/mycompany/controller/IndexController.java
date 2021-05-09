package com.mycompany.controller;

import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;

@Controller
public class IndexController {

    @GetMapping
    public String index() {
        return "redirect:system/index";
    }
    
    @GetMapping("/login")
    public String login() {
        return "login";
    }
   
}
