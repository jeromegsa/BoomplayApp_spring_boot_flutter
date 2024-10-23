package com.winner.boomplay.models;

// Importations des classes nécessaires
import java.util.List;


public class DataDTO {
    private List<Music> musics;
    private List<User> users;
    private List<Video> videos;

    // Constructeur
    public DataDTO(List<Music> musics, List<User> users, List<Video> videos) {
        this.musics = musics;
        this.users = users;
        this.videos = videos;
    }

    // Getters et Setters
    public List<Music> getMusics() {
        return musics;
    }

    public void setMusics(List<Music> musics) {
        this.musics = musics;
    }

    public List<User> getUsers() {
        return users;
    }

    public void setUsers(List<User> users) {
        this.users = users;
    }

    public List<Video> getVideos() {
        return videos;
    }

    public void setVideos(List<Video> videos) {
        this.videos = videos;
    }
}
