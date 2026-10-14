package com.skillbridge.controller;

import java.util.List;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.RequestParam;

import com.skillbridge.entity.Review;
import com.skillbridge.entity.User;
import com.skillbridge.repository.UserRepository;
import com.skillbridge.service.BidService;
import com.skillbridge.service.ReviewService;
import com.skillbridge.entity.Category;
import com.skillbridge.entity.Project;
import com.skillbridge.service.ProjectService;
import com.skillbridge.service.UserService;

@Controller
public class ProjectController {
	
    @Autowired
    private UserService userService;

    @Autowired
    private ReviewService reviewService;

    @Autowired
    private UserRepository userRepository;
    
    @Autowired
    private ProjectService projectService;

    
    /**
     * Freelancer public profile page
     */
    @GetMapping("/freelancers/{id}")
    public String freelancerProfile(@PathVariable("id") Long id, Model model) {

        java.util.Optional<User> userOpt = userRepository.findById(id);
        if (userOpt.isEmpty() || !"FREELANCER".equals(userOpt.get().getRole().name())) {
            model.addAttribute("errorMessage", "Freelancer not found");
            return "redirect:/";
        }

        User freelancer = userOpt.get();
        List<Review> reviews = reviewService.getReviewsForUser(id);
        Double avgRating = reviewService.getAverageRating(id);
        long reviewCount = reviewService.getReviewCount(id);

        model.addAttribute("freelancer", freelancer);
        model.addAttribute("reviews", reviews);
        model.addAttribute("avgRating", avgRating);
        model.addAttribute("reviewCount", reviewCount);

        return "freelancer/profile";
    }
    
    /**
     * Freelancer Listing — public page.
     * Search (q) query param support karta hai.
     */
    @GetMapping("/freelancers")
    public String listFreelancers(
            @RequestParam(value = "q", required = false) String keyword,
            Model model) {

        List<User> freelancers = userService.searchFreelancers(keyword);

        // Har freelancer ke liye rating aur review count nikaalo
        java.util.Map<Long, Double> ratingsMap = new java.util.HashMap<>();
        java.util.Map<Long, Long> countsMap = new java.util.HashMap<>();

        for (User f : freelancers) {
            ratingsMap.put(f.getId(), reviewService.getAverageRating(f.getId()));
            countsMap.put(f.getId(), reviewService.getReviewCount(f.getId()));
        }

        model.addAttribute("freelancers", freelancers);
        model.addAttribute("ratingsMap", ratingsMap);
        model.addAttribute("countsMap", countsMap);
        model.addAttribute("keyword", keyword == null ? "" : keyword);

        return "freelancer/list";
    }
    @GetMapping("/projects")
    public String browseProjects(
            @RequestParam(value = "q", required = false) String keyword,
            @RequestParam(value = "category", required = false) Long categoryId,
            Model model) {

        List<Project> projects = projectService.searchProjects(keyword, categoryId);
        List<Category> categories = projectService.getAllCategories();

        model.addAttribute("projects", projects);
        model.addAttribute("categories", categories);
        model.addAttribute("keyword", keyword == null ? "" : keyword);
        model.addAttribute("selectedCategory", categoryId);

        return "projects/browse";
    }

    /**
     * Project Details — public page.
     */
    @GetMapping("/projects/{id}")
    public String projectDetails(@PathVariable("id") Long id, Model model) {

        Optional<Project> projectOpt = projectService.findById(id);

        if (projectOpt.isEmpty()) {
            model.addAttribute("errorMessage", "Project not found");
            return "redirect:/projects";
        }

        model.addAttribute("project", projectOpt.get());
        return "projects/details";
    }
}