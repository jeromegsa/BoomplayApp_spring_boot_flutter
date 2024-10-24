
import 'dart:convert';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;


class MusicService {
  final String _baseUrl = 'http://127.0.0.1:8080';

// Function to add music
  Future<void> addMusic({
    required String title,
    required String artist,
    required String category,
    required int duration,
    required String musicFileName,
    required String imageFileName,
  }) async {
    var uri = Uri.parse('$_baseUrl/api/music');

    // Créer un objet JSON à partir des données
    var jsonBody = json.encode({
      'title': title,
      'artist': artist,
      'category': category,
      'duration': duration,
      'url': 'assets/musics/$musicFileName', // Chemin vers le fichier de musique
      'image_url': 'assets/musics/images/$imageFileName', // Chemin vers l'image
    });

    // Envoyer la requête avec l'en-tête approprié
    var response = await http.post(
      uri,
      headers: {
        'Content-Type': 'application/json', // Assurez-vous que le type de contenu est JSON
      },
      body: jsonBody,
    );

    if (response.statusCode == 200) {
      print('Musique ajoutée avec succès');
    } else {
      print('Erreur lors de l\'ajout de la musique : ${response.statusCode}');
    }
  }

  // Function to select a music file
  Future<Uint8List?> pickMusicFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['mp3', 'wav'],
    );

    if (result != null) {
      return result.files.single.bytes; // Utilise les octets du fichier
    }
    return null; // Return null if no file is selected
  }

  // Function to select an image file
  Future<Uint8List?> pickImageFile() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.image,
    );

    if (result != null) {
      return result.files.single.bytes; // Utilise les octets du fichier
    }
    return null; // Return null if no file is selected
  }
}
