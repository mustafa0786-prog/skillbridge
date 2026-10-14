package com.skillbridge.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.skillbridge.entity.Message;

@Repository
public interface MessageRepository extends JpaRepository<Message, Long> {

    /**
     * Do users ke beech ki conversation (dono directions).
     */
    @Query("SELECT m FROM Message m " +
           "WHERE (m.sender.id = :userId1 AND m.receiver.id = :userId2) " +
           "   OR (m.sender.id = :userId2 AND m.receiver.id = :userId1) " +
           "ORDER BY m.sentAt ASC")
    List<Message> findConversation(@Param("userId1") Long userId1,
                                    @Param("userId2") Long userId2);

    /**
     * User ko mile saare messages (receiver ke roop me).
     */
    List<Message> findByReceiverIdOrderBySentAtDesc(Long receiverId);

    /**
     * User ne bheje saare messages.
     */
    List<Message> findBySenderIdOrderBySentAtDesc(Long senderId);

    /**
     * User ke saare conversation partners (unique user IDs).
     */
    @Query("SELECT DISTINCT CASE " +
           "    WHEN m.sender.id = :userId THEN m.receiver.id " +
           "    ELSE m.sender.id " +
           "END " +
           "FROM Message m " +
           "WHERE m.sender.id = :userId OR m.receiver.id = :userId")
    List<Long> findConversationPartnerIds(@Param("userId") Long userId);

    /**
     * Unread message count.
     */
    long countByReceiverIdAndIsRead(Long receiverId, Boolean isRead);
}
