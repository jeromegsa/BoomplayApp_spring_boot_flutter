package com.winner.boomplay.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.winner.boomplay.models.Music;

public interface MusicRepository extends JpaRepository<Music, Long> {}
