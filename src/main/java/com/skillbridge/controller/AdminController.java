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
import com.skillbridge.entity.Role;
import com.skillbridge.entity.User;
import com.skillbridge.repository.BidRepository;
import com.skillbridge.repository.ProjectRepository;
import com.skillbridge.repository.UserRepository;
import com.skillbridge.service.UserService;

import jakarta.servlet.http.HttpSession;

@Controller
public class AdminController {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private BidRepository bidRepository;

    @Autowired
    private UserService userService;

    /**
     * Admin Dashboard — statistics
     */
    @GetMapping("/admin/dashboard")
    public String adminDashboard(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        long totalUsers = userRepository.count();
        long totalClients = userRepository.findByRole(Role.CLIENT).size();
        long totalFreelancers = userRepository.findByRole(Role.FREELANCER).size();
        long totalProjects = projectRepository.count();
        long totalBids = bidRepository.count();
        long openProjects = projectRepository.findByStatus("OPEN").size();
        long inProgress = projectRepository.findByStatus("IN_PROGRESS").size();
        long completed = projectRepository.findByStatus("COMPLETED").size();

        model.addAttribute("totalUsers", totalUsers);
        model.addAttribute("totalClients", totalClients);
        model.addAttribute("totalFreelancers", totalFreelancers);
        model.addAttribute("totalProjects", totalProjects);
        model.addAttribute("totalBids", totalBids);
        model.addAttribute("openProjects", openProjects);
        model.addAttribute("inProgress", inProgress);
        model.addAttribute("completed", completed);

        return "admin/dashboard";
    }

    /**
     * Manage Users — list all users
     */
    @GetMapping("/admin/users")
    public String manageUsers(
            @RequestParam(value = "role", required = false) String roleFilter,
            HttpSession session, Model model) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        List<User> users;
        if (roleFilter != null && !roleFilter.isEmpty()) {
            try {
                Role role = Role.valueOf(roleFilter.toUpperCase());
                users = userRepository.findByRole(role);
            } catch (Exception e) {
                users = userRepository.findAll();
            }
        } else {
            users = userRepository.findAll();
        }

        model.addAttribute("users", users);
        model.addAttribute("roleFilter", roleFilter);
        return "admin/users";
    }

    /**
     * Delete User
     */
    @PostMapping("/admin/users/{id}/delete")
    public String deleteUser(@PathVariable("id") Long id, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            userRepository.deleteById(id);
            return "redirect:/admin/users?deleted=true";
        } catch (Exception e) {
            return "redirect:/admin/users?error=" + e.getMessage();
        }
    }

    /**
     * Manage Projects
     */
    @GetMapping("/admin/projects")
    public String manageProjects(
            @RequestParam(value = "status", required = false) String statusFilter,
            HttpSession session, Model model) {

        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        List<Project> projects;
        if (statusFilter != null && !statusFilter.isEmpty()) {
            projects = projectRepository.findByStatus(statusFilter);
        } else {
            projects = projectRepository.findAll();
        }

        model.addAttribute("projects", projects);
        model.addAttribute("statusFilter", statusFilter);
        return "admin/projects";
    }

    /**
     * Delete Project
     */
    @PostMapping("/admin/projects/{id}/delete")
    public String deleteProject(@PathVariable("id") Long id, HttpSession session) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        try {
            projectRepository.deleteById(id);
            return "redirect:/admin/projects?deleted=true";
        } catch (Exception e) {
            return "redirect:/admin/projects?error=" + e.getMessage();
        }
    }

    /**
     * Manage Bids
     */
    @GetMapping("/admin/bids")
    public String manageBids(HttpSession session, Model model) {
        if (!isAdmin(session)) {
            return "redirect:/login";
        }

        List<Bid> bids = bidRepository.findAll();
        model.addAttribute("bids", bids);
        return "admin/bids";
    }

    /**
     * Helper — check if user is admin
     */
    private boolean isAdmin(HttpSession session) {
        Object userId = session.getAttribute("userId");
        Object role = session.getAttribute("userRole");
        return userId != null && "ADMIN".equals(role);
    }
}