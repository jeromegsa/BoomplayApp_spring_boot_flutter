package com.winner.boomplay.repository;

import org.springframework.data.jpa.repository.JpaRepository;
import com.winner.boomplay.models.User;

public interface UserRepository extends JpaRepository<User, Long> {
    
}
