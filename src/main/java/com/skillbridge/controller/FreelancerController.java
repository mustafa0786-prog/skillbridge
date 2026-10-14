package com.skillbridge.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skillbridge.entity.Bid;
import com.skillbridge.entity.Project;
import com.skillbridge.entity.User;
import com.skillbridge.repository.UserRepository;
import com.skillbridge.service.BidService;
import com.skillbridge.service.ProjectService;

import jakarta.servlet.http.HttpSession;

@Controller
public class FreelancerController {

    @Autowired
    private ProjectService projectService;

    @Autowired
    private BidService bidService;

    @Autowired
    private UserRepository userRepository;

    /**
     * Freelancer dashboard
     */
    @GetMapping("/freelancer/dashboard")
    public String freelancerDashboard(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"FREELANCER".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        Long freelancerId = (Long) session.getAttribute("userId");

        // Statistics
        long availableProjects = projectService.getOpenProjects().size();
        long totalBids = bidService.getBidsByFreelancer(freelancerId).size();
        long acceptedBids = bidService.getBidsByFreelancer(freelancerId).stream()
                .filter(b -> "ACCEPTED".equals(b.getStatus())).count();
        long pendingBids = bidService.getBidsByFreelancer(freelancerId).stream()
                .filter(b -> "PENDING".equals(b.getStatus())).count();

        model.addAttribute("availableProjects", availableProjects);
        model.addAttribute("totalBids", totalBids);
        model.addAttribute("acceptedBids", acceptedBids);
        model.addAttribute("pendingBids", pendingBids);

        return "freelancer/dashboard";
    }

    /**
     * Submit Bid form dikhata hai
     */
    @GetMapping("/freelancer/submit-bid/{projectId}")
    public String showSubmitBidPage(@PathVariable("projectId") Long projectId,
                                     HttpSession session, Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"FREELANCER".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        Long freelancerId = (Long) session.getAttribute("userId");

        // Already bid kiya?
        if (bidService.hasBid(projectId, freelancerId)) {
            return "redirect:/freelancer/my-bids";
        }

        // Project dhundho
        java.util.Optional<Project> projectOpt = projectService.findById(projectId);
        if (projectOpt.isEmpty()) {
            return "redirect:/projects";
        }

        model.addAttribute("project", projectOpt.get());
        return "freelancer/submit-bid";
    }

    /**
     * Submit Bid form POST
     */
    @PostMapping("/freelancer/submit-bid/{projectId}")
    public String submitBid(
            @PathVariable("projectId") Long projectId,
            @RequestParam("amount") Double amount,
            @RequestParam("proposal") String proposal,
            @RequestParam("deliveryDays") Integer deliveryDays,
            HttpSession session,
            Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            Long freelancerId = (Long) session.getAttribute("userId");
            User freelancer = userRepository.findById(freelancerId).orElseThrow(
                () -> new Exception("User not found"));

            bidService.submitBid(freelancer, projectId, amount, proposal, deliveryDays);

            return "redirect:/freelancer/my-bids?success=true";

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            java.util.Optional<Project> projectOpt = projectService.findById(projectId);
            if (projectOpt.isPresent()) {
                model.addAttribute("project", projectOpt.get());
            }
            return "freelancer/submit-bid";
        }
    }

    /**
     * My Bids page — freelancer ke saare bids
     */
    @GetMapping("/freelancer/my-bids")
    public String myBids(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }
        if (!"FREELANCER".equals(session.getAttribute("userRole"))) {
            return "redirect:/";
        }

        Long freelancerId = (Long) session.getAttribute("userId");
        List<Bid> bids = bidService.getBidsByFreelancer(freelancerId);
        model.addAttribute("bids", bids);

        return "freelancer/my-bids";
    }
}