package com.winner.boomplay.services;

import java.util.List;

import org.springframework.stereotype.Service;

import com.winner.boomplay.models.DataDTO;
import com.winner.boomplay.models.Music;
import com.winner.boomplay.models.User;
import com.winner.boomplay.models.Video;
import com.winner.boomplay.repository.MusicRepository;
import com.winner.boomplay.repository.UserRepository;
import com.winner.boomplay.repository.VideoRepository;

@Service
public class DataService {

    private final MusicRepository musicRepository;
    private final UserRepository userRepository;
    private final VideoRepository videoRepository;

    public DataService(MusicRepository musicRepository, UserRepository userRepository, VideoRepository videoRepository) {
        this.musicRepository = musicRepository;
        this.userRepository = userRepository;
        this.videoRepository = videoRepository;
    }

    public DataDTO getAllData() {
        List<Music> musics = musicRepository.findAll();
        List<User> users = userRepository.findAll();
        List<Video> videos = videoRepository.findAll();
        
        return new DataDTO(musics, users, videos);
    }
}
