package com.skillbridge.service;

import java.util.List;
import java.util.Optional;
import org.springframework.transaction.annotation.Transactional;  // ye add karo
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skillbridge.entity.Bid;
import com.skillbridge.entity.Project;
import com.skillbridge.entity.User;
import com.skillbridge.repository.BidRepository;
import com.skillbridge.repository.ProjectRepository;

@Service
public class BidService {

    @Autowired
    private BidRepository bidRepository;

    @Autowired
    private ProjectRepository projectRepository;

    /**
     * Naya bid submit karta hai.
     */
    public Bid submitBid(User freelancer, Long projectId, Double amount,
                          String proposal, Integer deliveryDays) throws Exception {

        // Validation
        if (amount == null || amount <= 0) {
            throw new Exception("Bid amount must be greater than 0");
        }
        if (deliveryDays == null || deliveryDays <= 0) {
            throw new Exception("Delivery days must be greater than 0");
        }
        if (proposal == null || proposal.trim().isEmpty()) {
            throw new Exception("Proposal is required");
        }

        // Project dhundho
        Optional<Project> projectOpt = projectRepository.findById(projectId);
        if (projectOpt.isEmpty()) {
            throw new Exception("Project not found");
        }
        Project project = projectOpt.get();

        // Project OPEN hona chahiye
        if (!"OPEN".equals(project.getStatus())) {
            throw new Exception("This project is no longer accepting bids");
        }

        // Freelancer apne hi project pe bid na kare
        if (project.getClient().getId().equals(freelancer.getId())) {
            throw new Exception("You cannot bid on your own project");
        }

        // Already bid kiya kya?
        if (bidRepository.existsByProjectIdAndFreelancerId(projectId, freelancer.getId())) {
            throw new Exception("You have already submitted a bid for this project");
        }

        // Naya bid banao
        Bid bid = new Bid();
        bid.setProject(project);
        bid.setFreelancer(freelancer);
        bid.setAmount(amount);
        bid.setProposal(proposal.trim());
        bid.setDeliveryDays(deliveryDays);
        bid.setStatus("PENDING");

        return bidRepository.save(bid);
    }

    /**
     * Project ke saare bids laao.
     */
    public List<Bid> getBidsByProject(Long projectId) {
        return bidRepository.findByProjectIdOrderByCreatedAtDesc(projectId);
    }

    /**
     * Freelancer ke saare bids.
     */
    public List<Bid> getBidsByFreelancer(Long freelancerId) {
        return bidRepository.findByFreelancerIdOrderByCreatedAtDesc(freelancerId);
    }

    /**
     * Freelancer ne is project pe already bid kiya?
     */
    public boolean hasBid(Long projectId, Long freelancerId) {
        return bidRepository.existsByProjectIdAndFreelancerId(projectId, freelancerId);
    }

    /**
     * Count - project pe kitne bids.
     */
    public long countByProject(Long projectId) {
        return bidRepository.countByProjectId(projectId);
    }

    /**
     * Bid ID se dhundho.
     */
    public Optional<Bid> findById(Long id) {
        return bidRepository.findById(id);
    }
    
    /**
     * Ek bid accept karta hai.
     * Saath hi:
     * - Us project ke baaki PENDING bids reject kar deta hai
     * - Project ka status IN_PROGRESS kar deta hai
     */
    @org.springframework.transaction.annotation.Transactional
    public void acceptBid(Long bidId, Long clientId) throws Exception {

        // Bid dhundho
        Optional<Bid> bidOpt = bidRepository.findById(bidId);
        if (bidOpt.isEmpty()) {
            throw new Exception("Bid not found");
        }
        Bid acceptedBid = bidOpt.get();

        // Verify: ye bid is client ke project ka hai
        Project project = acceptedBid.getProject();
        if (!project.getClient().getId().equals(clientId)) {
            throw new Exception("You can only manage bids on your own projects");
        }

        // Bid PENDING hona chahiye
        if (!"PENDING".equals(acceptedBid.getStatus())) {
            throw new Exception("This bid is no longer pending");
        }

        // Project OPEN hona chahiye
        if (!"OPEN".equals(project.getStatus())) {
            throw new Exception("This project is no longer open");
        }

        // 1. Accepted bid update karo
        acceptedBid.setStatus("ACCEPTED");
        bidRepository.save(acceptedBid);

        // 2. Baaki saare bids reject karo
        List<Bid> allBids = bidRepository.findByProjectId(project.getId());
        for (Bid bid : allBids) {
            if (!bid.getId().equals(bidId) && "PENDING".equals(bid.getStatus())) {
                bid.setStatus("REJECTED");
                bidRepository.save(bid);
            }
        }

        // 3. Project status update karo
        project.setStatus("IN_PROGRESS");
        projectRepository.save(project);
    }

    /**
     * Ek bid reject karta hai.
     * Project OPEN hi rehta hai — client aur bids consider kar sakta hai.
     */
    public void rejectBid(Long bidId, Long clientId) throws Exception {

        Optional<Bid> bidOpt = bidRepository.findById(bidId);
        if (bidOpt.isEmpty()) {
            throw new Exception("Bid not found");
        }
        Bid bid = bidOpt.get();

        // Verify: ye bid is client ke project ka hai
        if (!bid.getProject().getClient().getId().equals(clientId)) {
            throw new Exception("You can only manage bids on your own projects");
        }

        // Bid PENDING hona chahiye
        if (!"PENDING".equals(bid.getStatus())) {
            throw new Exception("This bid is no longer pending");
        }

        bid.setStatus("REJECTED");
        bidRepository.save(bid);
    }
    
}