package com.winner.boomplay.services;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.winner.boomplay.models.Music;
import com.winner.boomplay.repository.MusicRepository;

@Service
public class MusicService {
    @Autowired
    private MusicRepository musicRepository;

    private final String audioDirectory = "C:\\Users\\jerome.gbossa\\Documents\\BoomplayApp_spring_boot_flutter\\boomplay\\src\\uploads\\musics"; // Chemin absolu
    private final String imageDirectory = "C:\\Users\\jerome.gbossa\\Documents\\BoomplayApp_spring_boot_flutter\\boomplay\\src\\uploads\\musics\\images"; // Chemin absolu

    public List<Music> findAll() {
        return musicRepository.findAll();
    }

    public Music findById(Long id) {
        return musicRepository.findById(id).orElse(null);
    }

    public Music save(Music music) {
        return musicRepository.save(music);
    }

    public Music saveMusicWithFiles(MultipartFile audio, MultipartFile image, String title, String artist, String category, Integer duration) throws IOException {
        // Sauvegarde des fichiers
        String audioPath = saveFile(audio, audioDirectory);
        String imagePath = saveFile(image, imageDirectory);

        // Création d'un nouvel objet Music
        Music music = new Music();
        music.setTitle(title);
        music.setArtist(artist);
        music.setCategory(category);
        music.setDuration(duration);
        music.setUrl(audioPath); // URL du fichier audio
        music.setImageUrl(imagePath); // URL de l'image

        // Sauvegarde de l'objet Music
        return musicRepository.save(music);
    }

    private String saveFile(MultipartFile file, String directory) throws IOException {
        String fileName = System.currentTimeMillis() + "_" + file.getOriginalFilename();
        Path filePath = Paths.get(directory, fileName);
        Files.createDirectories(filePath.getParent()); // Crée les dossiers si nécessaire
        Files.write(filePath, file.getBytes());
        return filePath.toString(); // Retourne le chemin absolu du fichier sauvegardé
    }

    public void delete(Long id) {
        musicRepository.deleteById(id);
    }
}
