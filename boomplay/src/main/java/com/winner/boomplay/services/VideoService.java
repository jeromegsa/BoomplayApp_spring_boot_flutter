package com.winner.boomplay.services;

import java.io.IOException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.List;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.web.multipart.MultipartFile;

import com.winner.boomplay.models.Video;
import com.winner.boomplay.repository.VideoRepository;

@Service
public class VideoService {
    @Autowired
    private VideoRepository videoRepository;
    // Répertoires où les fichiers sont sauvegardés
    private final String videoDirectory = "C:\\Users\\jerome.gbossa\\Desktop\\Highfive-G4\\Developpement-web\\SPRING\\BoomplayApp\\boomplay\\src\\uploads\\videos";
    private final String imageDirectory = "C:\\Users\\jerome.gbossa\\Desktop\\Highfive-G4\\Developpement-web\\SPRING\\BoomplayApp\\boomplay\\src\\uploads\\videos\\images";

    // URL de base pour l'accès public
    private final String baseUrl = "http://localhost:8080"; 

    public List<Video> findAll() {
        return videoRepository.findAll();
    }

    public Video saveVideoWithFiles(MultipartFile video, MultipartFile image, String title,
            String category) throws IOException {
        // Sauvegarde des fichiers
        String videoUrl = saveFile(video, videoDirectory, "/videos/");
        String image_url = saveFile(image, imageDirectory, "/videos/images/");

        // Création d'un nouvel objet video
        Video video_ = new Video();
        video_.setTitle(title);
        video_.setCategory(category);
        // video_.setDuration(duration);
        video_.setUrl(videoUrl); // URL publique du fichier video
        video_.setImage_url(image_url); // URL publique de l'image

        // Sauvegarde de l'objet video
        return videoRepository.save(video_);
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


        // Création d'un nouveau nom de fichier avec l'extension
        
        String fileName = System.currentTimeMillis() + "_" + originalFilename;
        Path filePath = Paths.get(directory, fileName);

        Files.createDirectories(filePath.getParent()); // Crée les dossiers si nécessaire
        Files.write(filePath, file.getBytes());

        // Retourne une URL publique basée sur la configuration
        return baseUrl + publicPath + fileName;
    }

    public Video findById(Long id) {
        return videoRepository.findById(id).orElse(null);
    }

    public Video save(Video video) {
        return videoRepository.save(video);
    }

    public void delete(Long id) {
        videoRepository.deleteById(id);
    }
}
