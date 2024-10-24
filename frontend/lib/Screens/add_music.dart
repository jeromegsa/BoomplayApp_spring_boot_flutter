import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:frontend/services/music_service.dart';

class AddMusicScreen extends StatefulWidget {
  @override
  _AddMusicScreenState createState() => _AddMusicScreenState();
}

class _AddMusicScreenState extends State<AddMusicScreen> {
  final MusicService _musicService = MusicService();
  Uint8List? _selectedMusicBytes;
  Uint8List? _selectedImageBytes;
  bool _isLoading = false;

  final TextEditingController _titleController = TextEditingController();
  final TextEditingController _artistController = TextEditingController();
  final TextEditingController _categoryController = TextEditingController();
  final TextEditingController _durationController = TextEditingController();

  Future<void> _pickMusic() async {
    try {
      Uint8List? bytes = await _musicService.pickMusicFile();
      setState(() {
        _selectedMusicBytes = bytes;
      });
    } catch (e) {
      print('Erreur lors de la sélection du fichier de musique: $e');
    }
  }

  Future<void> _pickImage() async {
    try {
      Uint8List? bytes = await _musicService.pickImageFile();
      setState(() {
        _selectedImageBytes = bytes;
      });
    } catch (e) {
      print('Erreur lors de la sélection de l\'image: $e');
    }
  }

  Future<void> _addMusic() async {
    if (_selectedMusicBytes != null && _selectedImageBytes != null) {
      setState(() {
        _isLoading = true; // Démarrer le chargement
      });

      String musicFileName = '${_titleController.text}.mp3'; // Change l'extension selon le fichier
      String imageFileName = '${_titleController.text}_image.png'; // Change l'extension selon le fichier

      try {
        // Appeler la fonction pour ajouter la musique en base de données
        await _musicService.addMusic(
          title: _titleController.text,
          artist: _artistController.text,
          category: _categoryController.text,
          duration: int.parse(_durationController.text),
          musicFileName: musicFileName,
          imageFileName: imageFileName,
        );

        // Gérer le stockage local des fichiers si nécessaire

        // Optionnel : Afficher un message de succès
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Musique ajoutée avec succès')));
      } catch (e) {
        print('Erreur lors de l\'ajout de la musique: $e');
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Erreur lors de l\'ajout de la musique')));
      } finally {
        setState(() {
          _isLoading = false; // Arrêter le chargement
        });
      }
    } else {
      print('Sélectionnez un fichier de musique et une image');
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Veuillez sélectionner un fichier de musique et une image')));
    }
  }

  @override
  void dispose() {
    // Fermer les contrôleurs pour éviter les fuites de mémoire
    _titleController.dispose();
    _artistController.dispose();
    _categoryController.dispose();
    _durationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ajouter une musique'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _titleController,
              decoration: InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              controller: _artistController,
              decoration: InputDecoration(labelText: 'Artiste'),
            ),
            TextField(
              controller: _categoryController,
              decoration: InputDecoration(labelText: 'Catégorie'),
            ),
            TextField(
              controller: _durationController,
              decoration: InputDecoration(labelText: 'Durée (secondes)'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _pickMusic,
              child: Text('Sélectionner fichier musique'),
            ),
            ElevatedButton(
              onPressed: _pickImage,
              child: Text('Sélectionner image'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _isLoading ? null : _addMusic, // Désactiver le bouton pendant le chargement
              child: _isLoading
                  ? CircularProgressIndicator() // Afficher un indicateur de chargement
                  : Text('Ajouter musique'),
            ),
          ],
        ),
      ),
    );
  }
}
