package com.winner.boomplay.controllers;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.http.ResponseEntity;
import org.springframework.web.bind.annotation.*;

import com.winner.boomplay.models.Music;
import com.winner.boomplay.services.MusicService;

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

    @PostMapping
    public Music createMusic(@RequestBody Music music ) {
        return musicService.save(music);
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
