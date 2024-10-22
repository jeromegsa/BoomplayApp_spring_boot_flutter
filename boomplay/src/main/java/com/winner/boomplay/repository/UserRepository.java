
package com.winner.boomplay.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.winner.boomplay.model.User;

public interface UserRepository extends JpaRepository<User, Long> {
    User findByUsername(String username);
}
