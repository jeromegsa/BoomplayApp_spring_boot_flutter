import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:frontend/Screens/delayedAnimation.dart';
import 'package:frontend/services/video_service.dart';

class VideoUploadScreen extends StatefulWidget {
  @override
  _VideoUploadScreenState createState() => _VideoUploadScreenState();
}

class _VideoUploadScreenState extends State<VideoUploadScreen> {
  final VideoService _videoService = VideoService();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController categoryController = TextEditingController();
  final TextEditingController durationController = TextEditingController();

  File? videoFile;
  File? imageFile;
  Uint8List? videoBytes;
  Uint8List? imageBytes;

  Future<void> pickVideoFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.video);
    if (result != null) {
      setState(() {
        if (kIsWeb) {
          videoBytes = result.files.single.bytes;
        } else {
          videoFile = File(result.files.single.path!);
        }
      });
    }
  }

  Future<void> pickImageFile() async {
    final result = await FilePicker.platform.pickFiles(type: FileType.image);
    if (result != null) {
      setState(() {
        if (kIsWeb) {
          imageBytes = result.files.single.bytes;
        } else {
          imageFile = File(result.files.single.path!);
        }
      });
    }
  }

  Future<void> uploadVideo() async {
    if ((videoFile == null && videoBytes == null) ||
        (imageFile == null && imageBytes == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
            content: Text('Veuillez sélectionner les fichiers vidéo et image')),
      );
      return;
    }

    try {
      final response = await _videoService.uploadVideo(
        title: titleController.text,
        category: categoryController.text,
        duration: int.parse(durationController.text),
        videoFile: videoFile,
        videoBytes: videoBytes,
        imageFile: imageFile,
        imageBytes: imageBytes,
      );

      // Clear input fields after successful upload
      titleController.clear();
      categoryController.clear();
      durationController.clear();
      videoFile = null;
      imageFile = null;
      videoBytes = null;
      imageBytes = null;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Vidéo téléchargée avec succès : $response')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erreur lors du téléchargement : $e')),
      );
    }
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
                      'Télécharger Vidéo',
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
                          borderSide: const BorderSide(
                              color: Color(0xffff735c), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xffff735c), width: 2),
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
                      controller: categoryController,
                      decoration: InputDecoration(
                        labelText: 'Catégorie',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xffff735c), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xffff735c), width: 2),
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
                      controller: durationController,
                      decoration: InputDecoration(
                        labelText: 'Durée en secondes',
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xffff735c), width: 2),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                              color: Color(0xffff735c), width: 2),
                        ),
                        filled: true,
                        fillColor: Colors.white,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    delay: 2000,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.video_file, color: Colors.white),
                      label: Text(
                          videoFile == null && videoBytes == null
                              ? 'Sélectionner le fichier vidéo'
                              : 'Vidéo sélectionnée',
                          style: const TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffff735c),
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: pickVideoFile,
                    ),
                  ),
                  const SizedBox(height: 10),
                  DelayedAnimation(
                    delay: 2500,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.image, color: Colors.white),
                      label: Text(
                          imageFile == null && imageBytes == null
                              ? 'Sélectionner le fichier image'
                              : 'Image sélectionnée',
                          style: const TextStyle(color: Colors.white)),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffff735c),
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: pickImageFile,
                    ),
                  ),
                  const SizedBox(height: 20),
                  DelayedAnimation(
                    delay: 3000,
                    child: ElevatedButton.icon(
                      icon: const Icon(Icons.file_upload, color: Colors.white),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xffff735c),
                        minimumSize: const Size(300, 50),
                      ),
                      onPressed: uploadVideo,
                      label: const Text('Télécharger la vidéo',
                          style: TextStyle(color: Colors.white)),
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
