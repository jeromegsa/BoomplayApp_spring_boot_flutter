package com.winner.boomplay.controllers;

import java.io.IOException;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.DeleteMapping;
import org.springframework.web.bind.annotation.GetMapping;
import org.springframework.web.bind.annotation.PathVariable;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.PutMapping;
import org.springframework.web.bind.annotation.RequestBody;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;
import org.springframework.web.multipart.MultipartFile;

import com.winner.boomplay.models.Video;
import com.winner.boomplay.services.VideoService;

@RestController
@RequestMapping("/api/videos")
public class VideoController {
    @Autowired
    private VideoService videoService;

    @GetMapping
    public List<Video> getAllVideos() {
        return videoService.findAll();
    }

    @PostMapping("/upload")
    public ResponseEntity<String> uploadVideo(@RequestParam("title") String title,
            @RequestParam("category") String category,
            @RequestParam("duration") Integer duration,
            @RequestParam("video") MultipartFile video_,
            @RequestParam("image") MultipartFile image) {
        try {
            // Appel à la méthode du service pour enregistrer les fichiers et les données
            Video video = videoService.saveVideoWithFiles(video_, image, title, category, duration);
            return ResponseEntity.ok("video ajoutée avec succès : " + video.getTitle());
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Erreur lors de l'ajout de la video : " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                    .body("Erreur inattendue : " + e.getMessage());
        }
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
}
