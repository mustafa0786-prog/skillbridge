package com.skillbridge.service;

import java.util.List;

import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.stereotype.Service;

import com.skillbridge.entity.Role;
import com.skillbridge.entity.User;
import com.skillbridge.repository.UserRepository;

@Service
public class UserService {

    @Autowired
    private UserRepository userRepository;

    private final BCryptPasswordEncoder passwordEncoder = new BCryptPasswordEncoder();

    /**
     * Naya user register karta hai.
     * Password ko BCrypt se hash karta hai before saving.
     */
    public User registerUser(String name, String email, String rawPassword,
                             String phone, Role role) throws Exception {

        // Check if email already exists
        if (userRepository.existsByEmail(email)) {
            throw new Exception("Email already registered: " + email);
        }

        // Create new user
        User user = new User();
        user.setName(name);
        user.setEmail(email);
        user.setPassword(passwordEncoder.encode(rawPassword));  // Hashing here
        user.setPhone(phone);
        user.setRole(role);

        // Save to database
        return userRepository.save(user);
    }

    /**
     * Email se user dhundho.
     */
    public Optional<User> findByEmail(String email) {
        return userRepository.findByEmail(email);
    }

    /**
     * Saare users laao.
     */
    public List<User> getAllUsers() {
        return userRepository.findAll();
    }

    /**
     * Role se users laao.
     */
    public List<User> getUsersByRole(Role role) {
        return userRepository.findByRole(role);
    }
    
    /**
     * Saare freelancers laao.
     */
    public List<User> getAllFreelancers() {
        return userRepository.findByRole(Role.FREELANCER);
    }

    /**
     * Freelancers search karo (name se).
     */
    public List<User> searchFreelancers(String keyword) {
        if (keyword == null || keyword.trim().isEmpty()) {
            return getAllFreelancers();
        }
        return userRepository.findByRoleAndNameContainingIgnoreCase(
            Role.FREELANCER, keyword.trim());
    }

    /**
     * User ID se dhundho.
     */
    public Optional<User> findById(Long id) {
        return userRepository.findById(id);
    }
    /**
     * Login verify karta hai.
     * Email se user dhundhta hai, phir BCrypt se password match karta hai.
     */
    public User login(String email, String rawPassword) throws Exception {
        Optional<User> userOpt = userRepository.findByEmail(email);

        if (userOpt.isEmpty()) {
            throw new Exception("No account found with email: " + email);
        }

        User user = userOpt.get();

        // BCrypt se password verify karo
        if (!passwordEncoder.matches(rawPassword, user.getPassword())) {
            throw new Exception("Invalid password. Please try again.");
        }

        return user;
    }
}