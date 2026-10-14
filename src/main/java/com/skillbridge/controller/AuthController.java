
package com.skillbridge.controller;

import jakarta.servlet.http.HttpSession;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skillbridge.entity.Role;
import com.skillbridge.entity.User;
import com.skillbridge.service.UserService;

@Controller
public class AuthController {

    @Autowired
    private UserService userService;

    /**
     * Registration form dikhata hai (GET /register)
     */
    @GetMapping("/register")
    public String showRegisterPage() {
        return "register";
    }

    /**
     * Registration form submit handle karta hai (POST /register)
     */
    @PostMapping("/register")
    public String registerUser(
            @RequestParam("name") String name,
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            @RequestParam("phone") String phone,
            @RequestParam("role") String roleStr,
            Model model) {

        try {
            Role role = Role.valueOf(roleStr.toUpperCase());
            User savedUser = userService.registerUser(name, email, password, phone, role);

            model.addAttribute("successMessage",
                "Registration successful! Welcome " + savedUser.getName());
            return "login";

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "register";
        }
    }

    /**
     * Login page dikhata hai (GET /login)
     */
    @GetMapping("/login")
    public String showLoginPage() {
        return "login";
    }
    
    /**
     * Login form submit handle karta hai (POST /login)
     */
    @PostMapping("/login")
    public String loginUser(
            @RequestParam("email") String email,
            @RequestParam("password") String password,
            HttpSession session,
            Model model) {

        try {
            User user = userService.login(email, password);

            // Session me user store karo
            session.setAttribute("userId", user.getId());
            session.setAttribute("userName", user.getName());
            session.setAttribute("userEmail", user.getEmail());
            session.setAttribute("userRole", user.getRole().name());

            // Role ke hisaab se redirect
            switch (user.getRole()) {
                case CLIENT:
                    return "redirect:/client/dashboard";
                case FREELANCER:
                    return "redirect:/freelancer/dashboard";
                case ADMIN:
                    return "redirect:/admin/dashboard";
                default:
                    return "redirect:/";
            }

        } catch (Exception e) {
            model.addAttribute("errorMessage", e.getMessage());
            return "login";
        }
    }

    /**
     * Logout karta hai (GET /logout)
     */
    @GetMapping("/logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:/";
    }
}
