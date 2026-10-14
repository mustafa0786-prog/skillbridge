package com.skillbridge.service;

import java.time.LocalDate;
import java.util.List;
import java.util.Optional;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.skillbridge.entity.Category;
import com.skillbridge.entity.Project;
import com.skillbridge.entity.User;
import com.skillbridge.repository.CategoryRepository;
import com.skillbridge.repository.ProjectRepository;

@Service
public class ProjectService {

    @Autowired
    private ProjectRepository projectRepository;

    @Autowired
    private CategoryRepository categoryRepository;

    /**
     * Naya project post karta hai.
     */
    public Project postProject(User client, Long categoryId, String title,
                                String description, Double budget, LocalDate deadline)
                                throws Exception {

        // Validation
        if (title == null || title.trim().isEmpty()) {
            throw new Exception("Project title is required");
        }
        if (budget == null || budget <= 0) {
            throw new Exception("Budget must be greater than 0");
        }
        if (deadline == null || deadline.isBefore(LocalDate.now())) {
            throw new Exception("Deadline must be a future date");
        }

        // Category dhundho
        Category category = null;
        if (categoryId != null) {
            Optional<Category> catOpt = categoryRepository.findById(categoryId);
            if (catOpt.isPresent()) {
                category = catOpt.get();
            }
        }

        // Naya project banao
        Project project = new Project();
        project.setClient(client);
        project.setCategory(category);
        project.setTitle(title);
        project.setDescription(description);
        project.setBudget(budget);
        project.setDeadline(deadline);
        project.setStatus("OPEN");

        return projectRepository.save(project);
    }

    /**
     * Client ke saare projects laao.
     */
    public List<Project> getProjectsByClient(User client) {
        return projectRepository.findByClient(client);
    }

    /**
     * Client ID se projects laao.
     */
    public List<Project> getProjectsByClientId(Long clientId) {
        return projectRepository.findByClientId(clientId);
    }

    /**
     * Saare projects laao (freelancers ke liye).
     */
    public List<Project> getAllProjects() {
        return projectRepository.findAll();
    }

    /**
     * Sirf OPEN projects laao.
     */
    public List<Project> getOpenProjects() {
        return projectRepository.findByStatus("OPEN");
    }

    /**
     * Search + filter ke saath projects laao.
     *
     * @param keyword     - title me search text (null/empty = saare)
     * @param categoryId  - category filter (null = saari)
     * @return            - matching OPEN projects
     */
    public List<Project> searchProjects(String keyword, Long categoryId) {
        boolean hasKeyword = keyword != null && !keyword.trim().isEmpty();
        boolean hasCategory = categoryId != null;

        if (hasKeyword && hasCategory) {
            return projectRepository.findByTitleContainingIgnoreCaseAndCategoryIdAndStatus(
                keyword.trim(), categoryId, "OPEN");
        } else if (hasKeyword) {
            return projectRepository.findByTitleContainingIgnoreCaseAndStatus(
                keyword.trim(), "OPEN");
        } else if (hasCategory) {
            return projectRepository.findByCategoryIdAndStatus(categoryId, "OPEN");
        } else {
            return projectRepository.findByStatusOrderByCreatedAtDesc("OPEN");
        }
    }

    /**
     * Project ID se dhundho.
     */
    public Optional<Project> findById(Long id) {
        return projectRepository.findById(id);
    }

    /**
     * Client ke saare categories laao.
     */
    public List<Category> getAllCategories() {
        return categoryRepository.findAll();
    }

    /**
     * Client ke stats.
     */
    public long countByClientId(Long clientId) {
        return projectRepository.countByClientId(clientId);
    }

    public long countByClientIdAndStatus(Long clientId, String status) {
        return projectRepository.countByClientIdAndStatus(clientId, status);
    }

    /**
     * Project ko COMPLETED mark karta hai.
     * Sirf client apne project ko complete kar sakta hai.
     */
    public void completeProject(Long projectId, Long clientId) throws Exception {
        Optional<Project> projectOpt = projectRepository.findById(projectId);
        if (projectOpt.isEmpty()) {
            throw new Exception("Project not found");
        }
        Project project = projectOpt.get();

        // Verify: ye is client ka project hai
        if (!project.getClient().getId().equals(clientId)) {
            throw new Exception("You can only complete your own projects");
        }

        // Project IN_PROGRESS hona chahiye
        if (!"IN_PROGRESS".equals(project.getStatus())) {
            throw new Exception("Only IN_PROGRESS projects can be marked as completed");
        }

        project.setStatus("COMPLETED");
        projectRepository.save(project);
    }
}