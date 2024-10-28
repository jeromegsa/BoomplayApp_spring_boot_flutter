import 'dart:html' as html;
import 'package:flutter/material.dart';
import 'package:frontend/Screens/delayedAnimation.dart';
import 'package:frontend/services/music_service.dart';

class UploadMusicScreen extends StatefulWidget {
  @override
  _UploadMusicScreenState createState() => _UploadMusicScreenState();
}

class _UploadMusicScreenState extends State<UploadMusicScreen> {
  final MusicService _musicService = MusicService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController artistController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  html.File? audioFile;
  html.File? imageFile;

  Future<void> _pickAudioFile() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'audio/*';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        setState(() {
          audioFile = files[0];
        });
      }
    });
  }

  Future<void> _pickImageFile() async {
    html.FileUploadInputElement uploadInput = html.FileUploadInputElement();
    uploadInput.accept = 'image/*';
    uploadInput.click();
    uploadInput.onChange.listen((e) {
      final files = uploadInput.files;
      if (files!.isNotEmpty) {
        setState(() {
          imageFile = files[0];
        });
      }
    });
  }

  Future<void> _uploadMusic() async {
    if (audioFile != null && imageFile != null) {
      try {
        final responseData = await _musicService.uploadMusic(
          title: titleController.text,
          artist: artistController.text,
          category: categoryController.text,
          duration: int.parse(durationController.text),
          audioFile: audioFile!,
          imageFile: imageFile!,
        );
        setState(() {
           Navigator.of(context).pushReplacementNamed('/musics');
        });
        

        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData)));

        // Redirection vers la liste des musiques après un téléchargement réussi
        Navigator.pushReplacementNamed(context, '/musics');

        _clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Veuillez sélectionner les fichiers audio et image')),
      );
    }
  }

  void _clearForm() {
    setState(() {
      titleController.clear();
      artistController.clear();
      categoryController.clear();
      durationController.clear();
      audioFile = null;
      imageFile = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Center(
          child: Text(
            'BOOM PLAY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        toolbarHeight: 190,
        backgroundColor: const Color(0xffff735c),
        flexibleSpace: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Center(
              child: Text(
                'Votre plateforme de musique préférée, connectez-vous et amusez-vous!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Center(
          child: SingleChildScrollView(
            child: SizedBox(
              width: 500,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const DelayedAnimation(
                    delay: 5000,
                    child: Text(
                      'Télécharger Musique',
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffff735c),
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    delay: 500,
                    child: TextField(
                      controller: titleController,
                      decoration: InputDecoration(
                        labelText: 'Titre',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xffff735c), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xffff735c), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DelayedAnimation(
                    delay: 1000,
                    child: TextField(
                      controller: artistController,
                      decoration: InputDecoration(
                        labelText: 'Artiste',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xffff735c), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xffff735c), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DelayedAnimation(
                    delay: 1500,
                    child: TextField(
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: 'Catégorie',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xffff735c), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xffff735c), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10),
                  DelayedAnimation(
                    delay: 2000,
                    child: TextField(
                      controller: durationController,
                      decoration: InputDecoration(
                        labelText: 'Durée (en secondes)',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xffff735c), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(color: Color(0xffff735c), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                      keyboardType: TextInputType.number,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    delay: 2500,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.audiotrack, color: Colors.white),
                      label: Text(
                        audioFile == null ? 'Sélectionner le fichier audio' : 'Audio sélectionné',
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffff735c),
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: _pickAudioFile,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DelayedAnimation(
                    delay: 3000,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.image, color: Colors.white),
                      label: Text(
                        imageFile == null ? 'Sélectionner le fichier image' : 'Image sélectionnée',
                        style: const TextStyle(color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffff735c),
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: _pickImageFile,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    delay: 3500,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.file_upload, color: Colors.white),
                      label: const Text('Télécharger Musique', style: TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffff735c),
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: _uploadMusic,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
