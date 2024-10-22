package com.winner.boomplay.services;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.winner.boomplay.models.Video;
import com.winner.boomplay.repository.VideoRepository;

import java.util.List;

@Service
public class VideoService {
    @Autowired
    private VideoRepository videoRepository;

    public List<Video> findAll() {
        return videoRepository.findAll();
    }

    public Video findById(Long id) {
        return videoRepository.findById(id).orElse(null);
    }

    public Video save(Video video) {
        return videoRepository.save(video);
    }

    public void delete(Long id) {
        videoRepository.deleteById(id);
    }
}
