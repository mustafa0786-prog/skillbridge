package com.skillbridge.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;

import com.skillbridge.entity.Category;
import com.skillbridge.service.ProjectService;

@Controller
public class HomeController {

    @Autowired
    private ProjectService projectService;

    @GetMapping("/")
    public String home() {
        return "index";
    }

    /**
     * Categories page — saare categories dikhata hai
     */
    @GetMapping("/categories")
    public String categories(Model model) {
        List<Category> categories = projectService.getAllCategories();
        model.addAttribute("categories", categories);
        return "categories";
    }

    /**
     * About page
     */
    @GetMapping("/about")
    public String about() {
        return "about";
    }
}