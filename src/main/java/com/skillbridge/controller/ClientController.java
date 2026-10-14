package com.skillbridge.controller;

import java.time.LocalDate;

import java.util.List;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skillbridge.entity.Review;
import com.skillbridge.service.ReviewService;
import com.skillbridge.entity.Bid;
import com.skillbridge.service.BidService;
import com.skillbridge.entity.Category;
import com.skillbridge.entity.Project;
import com.skillbridge.entity.User;
import com.skillbridge.repository.UserRepository;
import com.skillbridge.service.ProjectService;

import jakarta.servlet.http.HttpSession;

@Controller
public class ClientController {
	
    @Autowired
    private ReviewService reviewService;
	
    @Autowired
    private BidService bidService;

    @Autowired
    private ProjectService projectService;

    @Autowired
    private UserRepository userRepository;

    /**
     * Client dashboard — statistics ke saath
     */
    @GetMapping("/client/dashboard")
    public String clientDashboard(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"CLIENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        Long clientId = (Long) session.getAttribute("userId");

        // Statistics
        long totalProjects = projectService.countByClientId(clientId);
        long openProjects = projectService.countByClientIdAndStatus(clientId, "OPEN");
        long inProgress = projectService.countByClientIdAndStatus(clientId, "IN_PROGRESS");
        long completed = projectService.countByClientIdAndStatus(clientId, "COMPLETED");

        model.addAttribute("totalProjects", totalProjects);
        model.addAttribute("openProjects", openProjects);
        model.addAttribute("inProgressProjects", inProgress);
        model.addAttribute("completedProjects", completed);

        return "client/dashboard";
    }

    /**
     * Post Project form dikhata hai
     */
    @GetMapping("/client/post-project")
    public String showPostProjectPage(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"CLIENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        List<Category> categories = projectService.getAllCategories();
        model.addAttribute("categories", categories);
        return "client/post-project";
    }
    
    /**
     * Received Bids — client ke project pe aaye saare bids
     */
    @GetMapping("/client/project/{projectId}/bids")
    public String viewReceivedBids(@PathVariable("projectId") Long projectId,
                                     HttpSession session, Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"CLIENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        Long clientId = (Long) session.getAttribute("userId");

        // Project dhundho
        java.util.Optional<Project> projectOpt = projectService.findById(projectId);
        if (projectOpt.isEmpty()) {
            return "redirect:/client/my-projects";
        }

        Project project = projectOpt.get();

        // Verify: ye project is client ka hi hai
        if (!project.getClient().getId().equals(clientId)) {
            return "redirect:/client/my-projects";
        }

        List<Bid> bids = bidService.getBidsByProject(projectId);
        model.addAttribute("project", project);
        model.addAttribute("bids", bids);

        return "client/received-bids";
    }
    
    /**
     * Accept a bid
     */
    @PostMapping("/client/bid/{bidId}/accept")
    public String acceptBid(@PathVariable("bidId") Long bidId,
                            HttpSession session,
                            Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"CLIENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        try {
            Long clientId = (Long) session.getAttribute("userId");

            // Bid se project ID nikaalo (redirect ke liye)
            java.util.Optional<Bid> bidOpt = bidService.findById(bidId);
            if (bidOpt.isEmpty()) {
                return "redirect:/client/my-projects";
            }
            Long projectId = bidOpt.get().getProject().getId();

            bidService.acceptBid(bidId, clientId);

            return "redirect:/client/project/" + projectId + "/bids?accepted=true";

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "redirect:/client/my-projects?error=" + e.getMessage();
        }
    }

    /**
     * Reject a bid
     */
    @PostMapping("/client/bid/{bidId}/reject")
    public String rejectBid(@PathVariable("bidId") Long bidId,
                            HttpSession session,
                            Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"CLIENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        try {
            Long clientId = (Long) session.getAttribute("userId");

            java.util.Optional<Bid> bidOpt = bidService.findById(bidId);
            if (bidOpt.isEmpty()) {
                return "redirect:/client/my-projects";
            }
            Long projectId = bidOpt.get().getProject().getId();

            bidService.rejectBid(bidId, clientId);

            return "redirect:/client/project/" + projectId + "/bids?rejected=true";

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "redirect:/client/my-projects?error=" + e.getMessage();
        }
    }

    /**
     * Post Project form submit handle karta hai
     */
    @PostMapping("/client/post-project")
    public String postProject(
            @RequestParam("title") String title,
            @RequestParam("description") String description,
            @RequestParam(value = "categoryId", required = false) Long categoryId,
            @RequestParam("budget") Double budget,
            @RequestParam("deadline") String deadlineStr,
            HttpSession session,
            Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            Long userId = (Long) session.getAttribute("userId");
            User client = userRepository.findById(userId).orElseThrow(
                () -> new Exception("User not found"));

            LocalDate deadline = LocalDate.parse(deadlineStr);

            projectService.postProject(client, categoryId, title, description, budget, deadline);

            return "redirect:/client/my-projects";

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            List<Category> categories = projectService.getAllCategories();
            model.addAttribute("categories", categories);
            return "client/post-project";
        }
    }

    
    /**
     * Project ko mark as completed karta hai
     */
    @PostMapping("/client/project/{projectId}/complete")
    public String completeProject(@PathVariable("projectId") Long projectId,
                                   HttpSession session) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"CLIENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        try {
            Long clientId = (Long) session.getAttribute("userId");
            projectService.completeProject(projectId, clientId);
            return "redirect:/client/project/" + projectId + "/bids?completed=true";
        } catch (Exception e) {
            return "redirect:/client/my-projects?error=" + e.getMessage();
        }
    }

    /**
     * Review form dikhata hai
     */
    @GetMapping("/client/project/{projectId}/review")
    public String showReviewForm(@PathVariable("projectId") Long projectId,
                                  HttpSession session, Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"CLIENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        Long clientId = (Long) session.getAttribute("userId");

        java.util.Optional<Project> projectOpt = projectService.findById(projectId);
        if (projectOpt.isEmpty()) {
            return "redirect:/client/my-projects";
        }
        Project project = projectOpt.get();

        if (!project.getClient().getId().equals(clientId)) {
            return "redirect:/client/my-projects";
        }

        if (!"COMPLETED".equals(project.getStatus())) {
            return "redirect:/client/project/" + projectId + "/bids";
        }

        // Already reviewed?
        if (reviewService.hasReviewed(projectId, clientId)) {
            return "redirect:/client/project/" + projectId + "/bids?alreadyReviewed=true";
        }

        // Freelancer dhundho - accepted bid se
        java.util.Optional<Bid> acceptedBidOpt = bidService.getBidsByProject(projectId)
            .stream()
            .filter(b -> "ACCEPTED".equals(b.getStatus()))
            .findFirst();

        if (acceptedBidOpt.isEmpty()) {
            return "redirect:/client/my-projects?error=No accepted bid found";
        }

        model.addAttribute("project", project);
        model.addAttribute("freelancer", acceptedBidOpt.get().getFreelancer());

        return "client/review-form";
    }

    /**
     * Review form POST
     */
    @PostMapping("/client/project/{projectId}/review")
    public String submitReview(
            @PathVariable("projectId") Long projectId,
            @RequestParam("rating") Integer rating,
            @RequestParam("review") String reviewText,
            HttpSession session,
            Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            Long clientId = (Long) session.getAttribute("userId");
            User client = userRepository.findById(clientId).orElseThrow(
                () -> new Exception("User not found"));

            java.util.Optional<Project> projectOpt = projectService.findById(projectId);
            if (projectOpt.isEmpty()) {
                throw new Exception("Project not found");
            }
            Project project = projectOpt.get();

            if (!project.getClient().getId().equals(clientId)) {
                throw new Exception("You can only review your own projects");
            }

            if (!"COMPLETED".equals(project.getStatus())) {
                throw new Exception("Only completed projects can be reviewed");
            }

            // Freelancer dhundho
            java.util.Optional<Bid> acceptedBidOpt = bidService.getBidsByProject(projectId)
                .stream()
                .filter(b -> "ACCEPTED".equals(b.getStatus()))
                .findFirst();

            if (acceptedBidOpt.isEmpty()) {
                throw new Exception("No accepted bid found for this project");
            }

            User freelancer = acceptedBidOpt.get().getFreelancer();

            reviewService.addReview(project, client, freelancer, rating, reviewText);

            return "redirect:/client/project/" + projectId + "/bids?reviewed=true";

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "redirect:/client/my-projects?error=" + e.getMessage();
        }
    }
    /**
     * My Projects page — client ke saare projects
     */
    @GetMapping("/client/my-projects")
    public String myProjects(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"CLIENT".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        Long clientId = (Long) session.getAttribute("userId");
        List<Project> projects = projectService.getProjectsByClientId(clientId);
        model.addAttribute("projects", projects);

        return "client/my-projects";
    }
}