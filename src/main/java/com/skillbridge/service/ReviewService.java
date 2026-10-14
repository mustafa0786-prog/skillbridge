
package com.skillbridge.service;

import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skillbridge.entity.Project;
import com.skillbridge.entity.Review;
import com.skillbridge.entity.User;
import com.skillbridge.repository.ReviewRepository;

@Service
public class ReviewService {

    @Autowired
    private ReviewRepository reviewRepository;

    /**
     * Naya review submit karta hai.
     */
    public Review addReview(Project project, User reviewer, User reviewedUser,
                             Integer rating, String reviewText) throws Exception {

        // Validation
        if (rating == null || rating < 1 || rating > 5) {
            throw new Exception("Rating must be between 1 and 5");
        }
        if (reviewText == null || reviewText.trim().isEmpty()) {
            throw new Exception("Review text is required");
        }

        // Already reviewed?
        if (reviewRepository.existsByProjectIdAndReviewerId(project.getId(), reviewer.getId())) {
            throw new Exception("You have already reviewed this project");
        }

        // Review banao
        Review review = new Review();
        review.setProject(project);
        review.setReviewer(reviewer);
        review.setReviewedUser(reviewedUser);
        review.setRating(rating);
        review.setReview(reviewText.trim());

        return reviewRepository.save(review);
    }

    /**
     * User ke saare reviews.
     */
    public List<Review> getReviewsForUser(Long userId) {
        return reviewRepository.findByReviewedUserIdOrderByCreatedAtDesc(userId);
    }

    /**
     * User ka average rating.
     */
    public Double getAverageRating(Long userId) {
        Double avg = reviewRepository.getAverageRating(userId);
        return avg != null ? Math.round(avg * 10.0) / 10.0 : 0.0;
    }

    /**
     * User ka total review count.
     */
    public long getReviewCount(Long userId) {
        return reviewRepository.countByReviewedUserId(userId);
    }

    /**
     * User ne already review diya?
     */
    public boolean hasReviewed(Long projectId, Long reviewerId) {
        return reviewRepository.existsByProjectIdAndReviewerId(projectId, reviewerId);
    }
}