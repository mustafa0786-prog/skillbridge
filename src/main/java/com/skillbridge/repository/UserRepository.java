package com.skillbridge.repository;

import java.util.List;
import java.util.Optional;

import org.springframework.data.jpa.repository.JpaRepository;
import org.springframework.stereotype.Repository;

import com.skillbridge.entity.Role;
import com.skillbridge.entity.User;

@Repository
public interface UserRepository extends JpaRepository<User, Long> {

    Optional<User> findByEmail(String email);

    List<User> findByRole(Role role);
    
    // Name ya email me search (freelancer role ke andar)
    List<User> findByRoleAndNameContainingIgnoreCase(Role role, String name);

    boolean existsByEmail(String email);
}