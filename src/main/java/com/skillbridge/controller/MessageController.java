package com.skillbridge.controller;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestParam;

import com.skillbridge.entity.Message;
import com.skillbridge.entity.User;
import com.skillbridge.repository.UserRepository;
import com.skillbridge.service.MessageService;

import jakarta.servlet.http.HttpSession;

@Controller
public class MessageController {

    @Autowired
    private MessageService messageService;

    @Autowired
    private UserRepository userRepository;

    /**
     * Inbox — saare conversations
     */
    @GetMapping("/messages")
    public String inbox(HttpSession session, Model model) {
        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Long userId = (Long) session.getAttribute("userId");
        List<User> partners = messageService.getConversationPartners(userId);
        long unreadCount = messageService.getUnreadCount(userId);

        model.addAttribute("partners", partners);
        model.addAttribute("unreadCount", unreadCount);

        return "messages/inbox";
    }

    /**
     * Conversation with specific user
     */
    @GetMapping("/messages/{otherUserId}")
    public String conversation(@PathVariable("otherUserId") Long otherUserId,
                                HttpSession session, Model model) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        Long userId = (Long) session.getAttribute("userId");

        if (userId.equals(otherUserId)) {
            return "redirect:/messages";
        }

        User otherUser = userRepository.findById(otherUserId).orElse(null);
        if (otherUser == null) {
            return "redirect:/messages";
        }

        // Mark as read
        messageService.markConversationAsRead(userId, otherUserId);

        List<Message> messages = messageService.getConversation(userId, otherUserId);

        model.addAttribute("otherUser", otherUser);
        model.addAttribute("messages", messages);

        return "messages/conversation";
    }

    /**
     * Send message
     */
    @PostMapping("/messages/{receiverId}/send")
    public String sendMessage(@PathVariable("receiverId") Long receiverId,
                               @RequestParam("message") String text,
                               HttpSession session) {

        if (session.getAttribute("userId") == null) {
            return "redirect:/login";
        }

        try {
            Long userId = (Long) session.getAttribute("userId");
            User sender = userRepository.findById(userId).orElseThrow(
                () -> new Exception("User not found"));

            messageService.sendMessage(sender, receiverId, text);

            return "redirect:/messages/" + receiverId;

        } catch (Exception e) {
            return "redirect:/messages/" + receiverId + "?error=" + e.getMessage();
        }
    }
}