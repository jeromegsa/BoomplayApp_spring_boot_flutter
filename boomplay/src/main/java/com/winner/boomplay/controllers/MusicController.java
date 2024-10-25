package com.winner.boomplay.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.HttpStatus;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;
import org.springframework.web.multipart.MultipartFile;

import com.winner.boomplay.models.Music;
import com.winner.boomplay.services.MusicService;

import java.io.IOException;
import java.util.List;

@RestController
@RequestMapping("/api/music")
@CrossOrigin
public class MusicController {
    @Autowired
    private MusicService musicService;

    @GetMapping
    public List<Music> getAllMusic() {
        return musicService.findAll();
    }

    @GetMapping("/{id}")
    public ResponseEntity<Music> getMusicById(@PathVariable Long id) {
        Music music = musicService.findById(id);
        return music != null ? ResponseEntity.ok(music) : ResponseEntity.notFound().build();
    }

    @PostMapping("/upload")
    public ResponseEntity<String> uploadMusic(@RequestParam("title") String title,
                                              @RequestParam("artist") String artist,
                                              @RequestParam("category") String category,
                                              @RequestParam("duration") Integer duration,
                                              @RequestParam("audio") MultipartFile audio,
                                              @RequestParam("image") MultipartFile image) {
        try {
            // Appel à la méthode du service pour enregistrer les fichiers et les données
            Music music = musicService.saveMusicWithFiles(audio, image, title, artist, category, duration);
            return ResponseEntity.ok("Musique ajoutée avec succès : " + music.getTitle());
        } catch (IOException e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("Erreur lors de l'ajout de la musique : " + e.getMessage());
        } catch (Exception e) {
            e.printStackTrace();
            return ResponseEntity.status(HttpStatus.INTERNAL_SERVER_ERROR)
                                 .body("Erreur inattendue : " + e.getMessage());
        }
    }

   

    @PutMapping("/{id}")
    public ResponseEntity<Music> updateMusic(@PathVariable Long id, @RequestBody Music musicDetails) {
        Music music = musicService.findById(id);
        if (music == null) {
            return ResponseEntity.notFound().build();
        }
        music.setTitle(musicDetails.getTitle());
        music.setArtist(musicDetails.getArtist());
        music.setCategory(musicDetails.getCategory());
        music.setDuration(musicDetails.getDuration());
        music.setUrl(musicDetails.getUrl());
        return ResponseEntity.ok(musicService.save(music));
    }

    @DeleteMapping("/{id}")
    public ResponseEntity<Void> deleteMusic(@PathVariable Long id) {
        musicService.delete(id);
        return ResponseEntity.noContent().build();
    }
}
