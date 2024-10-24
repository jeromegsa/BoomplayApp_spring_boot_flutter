package com.winner.boomplay.services;
import com.winner.boomplay.models.Music;
import com.winner.boomplay.models.User;
import com.winner.boomplay.models.Video;
import com.winner.boomplay.repository.MusicRepository;
import com.winner.boomplay.repository.UserRepository;
import com.winner.boomplay.repository.VideoRepository;
import com.github.javafaker.Faker;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.time.LocalDateTime;
import java.util.ArrayList;
import java.util.List;

@Service
public class DataGeneratorService {

    @Autowired
    private UserRepository userRepository;

    @Autowired
    private MusicRepository musicRepository;

    @Autowired
    private VideoRepository videoRepository;

    private final Faker faker = new Faker();

    public void generateFakeData(int userCount, int musicCount, int videoCount) {
        List<User> users = new ArrayList<>();
        List<Music> musicList = new ArrayList<>();
        List<Video> videoList = new ArrayList<>();

        //creations des users  
        for (int i = 0; i < userCount; i++) {
            User user = new User();
            user.setUsername(faker.name().username());
            user.setEmail(faker.internet().emailAddress());
            user.setPassword(faker.internet().password());
            user.setCreatedAt(LocalDateTime.now());
            user.setUpdatedAt(LocalDateTime.now());
            users.add(user);
        }
        userRepository.saveAll(users);

        for (User user : users) {
            //generations des siques
            for (int j = 0; j < musicCount; j++) {
                Music music = new Music();
               
                music.setTitle(faker.book().title()); 

                music.setArtist(faker.artist().name());
                music.setCategory(faker.music().genre());
                music.setDuration(faker.number().numberBetween(180, 300)); 
                music.setUrl(faker.internet().url());
                music.setUser(user);
                music.setCreatedAt(LocalDateTime.now());
                music.setUpdatedAt(LocalDateTime.now());
                musicList.add(music);
            }
        }
        musicRepository.saveAll(musicList);
                      //GENERATION DES DEOS
        for (User user : users) {
            for (int k = 0; k < videoCount; k++) {
                Video video = new Video();
                video.setTitle(faker.book().title()); 
                video.setUrl(faker.internet().url());
                video.setCategory(faker.company().bs());
                video.setDuration(faker.number().numberBetween(300, 900)); 
                video.setUser(user);
                video.setCreatedAt(LocalDateTime.now());
                video.setUpdatedAt(LocalDateTime.now());
                videoList.add(video);
            }
        }
        videoRepository.saveAll(videoList);
    }
}
