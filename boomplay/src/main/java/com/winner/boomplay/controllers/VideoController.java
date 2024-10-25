package com.winner.boomplay.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.core.io.FileSystemResource;
import org.springframework.core.io.Resource;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.winner.boomplay.models.Video;
import com.winner.boomplay.services.VideoService;

import java.io.File;
import java.util.List;

@CrossOrigin
@RequestMapping("/api/videos")
@RestController
public class VideoController {
    @Autowired
    private VideoService videoService;

    @GetMapping
    public List<Video> getAllVideos() {
        return videoService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Video> getVideoById(@PathVariable Long id) {
        Video video = videoService.findById(id);
        return video != null ? ResponseEntity.ok(video) : ResponseEntity.notFound().build();
    }

    @PostMapping
    public Video createVideo(@RequestBody Video video) {
        return videoService.save(video);
    }

    @PutMapping("/{id}")
    public ResponseEntity<Video> updateVideo(@PathVariable Long id, @RequestBody Video videoDetails) {
        Video video = videoService.findById(id);
        if (video == null) {
            return ResponseEntity.notFound().build();
        }
        video.setTitle(videoDetails.getTitle());
        video.setUrl(videoDetails.getUrl());
        video.setCategory(videoDetails.getCategory());
        video.setDuration(videoDetails.getDuration());
        return ResponseEntity.ok(videoService.save(video));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteVideo(@PathVariable Long id) {
        videoService.delete(id);
        return ResponseEntity.noContent().build();
    }

    // Nouvelle méthode pour servir les fichiers vidéo
    @GetMapping("/files/{filename:.+}")
    public ResponseEntity<Resource> serveVideo(@PathVariable String filename) {
        File file = new File("C:/Users/beni.sonkpian/Documents/BoomplayApp_spring_boot_flutter/boomplay/src/uploads/videos/" + filename);
        if (file.exists()) {
            Resource resource = new FileSystemResource(file);
            return ResponseEntity.ok(resource);
        } else {
            return ResponseEntity.notFound().build();
        }
    }
}
