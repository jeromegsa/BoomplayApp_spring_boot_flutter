package com.winner.boomplay.services;


import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import com.winner.boomplay.models.Music;
import com.winner.boomplay.repository.MusicRepository;

import java.util.List;

@Service
public class MusicService {
    @Autowired
    private MusicRepository musicRepository;

    public List<Music> findAll() {
        return musicRepository.findAll();
    }

    public Music findById(Long id) {
        return musicRepository.findById(id).orElse(null);
    }

    public Music save(Music music) {
        return musicRepository.save(music);
    }

    public void delete(Long id) {
        musicRepository.deleteById(id);
    }
}
