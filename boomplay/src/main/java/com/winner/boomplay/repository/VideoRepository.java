package com.winner.boomplay.repository;

import org.springframework.data.jpa.repository.JpaRepository;

import com.winner.boomplay.models.Video;

public interface VideoRepository extends JpaRepository<Video, Long> {}
