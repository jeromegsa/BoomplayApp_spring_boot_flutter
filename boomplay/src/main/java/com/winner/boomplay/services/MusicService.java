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

    // Répertoires où les fichiers sont sauvegardés
    private final String audioDirectory = "C:\\Users\\jerome.gbossa\\Desktop\\Highfive-G4\\Developpement-web\\SPRING\\BoomplayApp\\boomplay\\src\\uploads\\musics";
    private final String imageDirectory = "C:\\Users\\jerome.gbossa\\Desktop\\Highfive-G4\\Developpement-web\\SPRING\\BoomplayApp\\boomplay\\src\\uploads\\musics\\images";

    // URL de base pour l'accès public
    private final String baseUrl = "http://localhost:8080"; // Remplacez par votre URL réelle si différent

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
        String audioUrl = saveFile(audio, audioDirectory, "/musics/");
        String imageUrl = saveFile(image, imageDirectory, "/musics/images/");

        // Création d'un nouvel objet Music
        Music music = new Music();
        music.setTitle(title);
        music.setArtist(artist);
        music.setCategory(category);
        music.setDuration(duration);
        music.setUrl(audioUrl); // URL publique du fichier audio
        music.setImageUrl(imageUrl); // URL publique de l'image

        // Sauvegarde de l'objet Music
        return musicRepository.save(music);
    }

    private String saveFile(MultipartFile file, String directory, String publicPath) throws IOException {
        // Vérification si le fichier est vide
        if (file.isEmpty()) {
            throw new IOException("Le fichier est vide.");
        }
        
        // Récupération du nom de fichier original et de l'extension
        String originalFilename = file.getOriginalFilename();
        if (originalFilename == null || originalFilename.isEmpty()) {
            throw new IOException("Le nom du fichier est invalide.");
        }
        
        // Extraction de l'extension
        String extension = originalFilename.substring(originalFilename.lastIndexOf("."));
        
        // Création d'un nouveau nom de fichier avec l'extension
        String fileName = System.currentTimeMillis() + "_" + originalFilename;
        Path filePath = Paths.get(directory, fileName);
        
        Files.createDirectories(filePath.getParent()); // Crée les dossiers si nécessaire
        Files.write(filePath, file.getBytes());
    
        // Retourne une URL publique basée sur la configuration
        return baseUrl + publicPath + fileName;
    }
    
    

    public void delete(Long id) {
        musicRepository.deleteById(id);
    }
}
