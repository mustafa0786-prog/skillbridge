package com.skillbridge.repository;

import java.util.List;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skillbridge.entity.Project;
import com.skillbridge.entity.User;

@Repository
public interface ProjectRepository extends JpaRepository<Project, Long> {

    // Client ke saare projects
    List<Project> findByClient(User client);

    // Client ID se projects
    List<Project> findByClientId(Long clientId);

    // Status ke hisaab se (OPEN, IN_PROGRESS, etc.)
    List<Project> findByStatus(String status);

    // Category ke hisaab se
    List<Project> findByCategoryId(Long categoryId);

    // Count - client ke kitne projects hain
    long countByClientId(Long clientId);

    // Count - status ke hisaab se
    long countByClientIdAndStatus(Long clientId, String status);

    // ============ SEARCH METHODS ============

    // Title me search (case-insensitive), OPEN projects me
    List<Project> findByTitleContainingIgnoreCaseAndStatus(String keyword, String status);

    // Category filter, OPEN projects me
    List<Project> findByCategoryIdAndStatus(Long categoryId, String status);

    // Title search + Category filter + OPEN
    List<Project> findByTitleContainingIgnoreCaseAndCategoryIdAndStatus(
        String keyword, Long categoryId, String status);

    // Latest projects pehle (createdAt descending)
    List<Project> findByStatusOrderByCreatedAtDesc(String status);
}