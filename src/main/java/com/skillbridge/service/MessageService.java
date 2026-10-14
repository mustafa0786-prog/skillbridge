package com.skillbridge.service;

import java.util.ArrayList;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skillbridge.entity.Message;
import com.skillbridge.entity.User;
import com.skillbridge.repository.MessageRepository;
import com.skillbridge.repository.UserRepository;

@Service
public class MessageService {

    @Autowired
    private MessageRepository messageRepository;

    @Autowired
    private UserRepository userRepository;

    /**
     * Naya message bhejta hai.
     */
    public Message sendMessage(User sender, Long receiverId, String text) throws Exception {

        if (text == null || text.trim().isEmpty()) {
            throw new Exception("Message cannot be empty");
        }
        if (sender.getId().equals(receiverId)) {
            throw new Exception("You cannot message yourself");
        }

        User receiver = userRepository.findById(receiverId).orElseThrow(
            () -> new Exception("Recipient not found"));

        Message msg = new Message();
        msg.setSender(sender);
        msg.setReceiver(receiver);
        msg.setMessage(text.trim());
        msg.setIsRead(false);

        return messageRepository.save(msg);
    }

    /**
     * Do users ke beech conversation.
     */
    public List<Message> getConversation(Long userId1, Long userId2) {
        return messageRepository.findConversation(userId1, userId2);
    }

    /**
     * User ke saare conversation partners.
     */
    public List<User> getConversationPartners(Long userId) {
        List<Long> partnerIds = messageRepository.findConversationPartnerIds(userId);
        List<User> partners = new ArrayList<>();
        for (Long id : partnerIds) {
            userRepository.findById(id).ifPresent(partners::add);
        }
        return partners;
    }

    /**
     * Unread count.
     */
    public long getUnreadCount(Long userId) {
        return messageRepository.countByReceiverIdAndIsRead(userId, false);
    }

    /**
     * Conversation me saare messages ko read mark karo.
     */
    public void markConversationAsRead(Long userId, Long otherUserId) {
        List<Message> conversation = messageRepository.findConversation(userId, otherUserId);
        for (Message m : conversation) {
            if (m.getReceiver().getId().equals(userId) && !m.getIsRead()) {
                m.setIsRead(true);
                messageRepository.save(m);
            }
        }
    }
}