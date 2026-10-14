package com.skillbridge.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skillbridge.entity.Bid;
import com.skillbridge.entity.Project;
import com.skillbridge.entity.User;

@Repository
public interface BidRepository extends JpaRepository<Bid, Long> {

    // Project ke saare bids
    List<Bid> findByProject(Project project);

    // Project ID ke bids
    List<Bid> findByProjectId(Long projectId);

    // Project ID ke bids - latest first
    List<Bid> findByProjectIdOrderByCreatedAtDesc(Long projectId);

    // Freelancer ke saare bids
    List<Bid> findByFreelancer(User freelancer);

    // Freelancer ID ke bids
    List<Bid> findByFreelancerId(Long freelancerId);

    // Freelancer ID ke bids - latest first
    List<Bid> findByFreelancerIdOrderByCreatedAtDesc(Long freelancerId);

    // Freelancer ne is project pe already bid kiya kya?
    boolean existsByProjectIdAndFreelancerId(Long projectId, Long freelancerId);

    // Count - project pe kitne bids hain
    long countByProjectId(Long projectId);

    // Count - freelancer ke accepted bids
    long countByFreelancerIdAndStatus(Long freelancerId, String status);
}