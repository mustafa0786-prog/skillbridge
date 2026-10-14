package com.skillbridge.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.data.jpa.repository.Query;
import org.springframework.data.repository.query.Param;
import org.springframework.stereotype.Repository;

import com.skillbridge.entity.Review;

@Repository
public interface ReviewRepository extends JpaRepository<Review, Long> {

    // Freelancer (ya kisi bhi user) ke reviews
    List<Review> findByReviewedUserIdOrderByCreatedAtDesc(Long reviewedUserId);

    // Project ke reviews
    List<Review> findByProjectId(Long projectId);

    // User ka review is project pe already hai?
    boolean existsByProjectIdAndReviewerId(Long projectId, Long reviewerId);

    // Average rating of user
    @Query("SELECT AVG(r.rating) FROM Review r WHERE r.reviewedUser.id = :userId")
    Double getAverageRating(@Param("userId") Long userId);

    // Total reviews of user
    long countByReviewedUserId(Long reviewedUserId);
}