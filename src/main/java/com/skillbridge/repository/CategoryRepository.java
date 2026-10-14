package com.skillbridge.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skillbridge.entity.Category;

@Repository
public interface CategoryRepository extends JpaRepository<Category, Long> {
    // Basic CRUD operations automatically milte hain
    // findAll(), findById(), save(), delete(), count()
}