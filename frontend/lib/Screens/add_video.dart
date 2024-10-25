import 'dart:io';
import 'dart:typed_data';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart' show kIsWeb; // For web detection
import 'package:flutter/material.dart';
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
          // For web, use bytes
          videoBytes = result.files.single.bytes;
        } else {
          // For mobile/desktop, use path
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
          // For web, use bytes
          imageBytes = result.files.single.bytes;
        } else {
          // For mobile/desktop, use path
          imageFile = File(result.files.single.path!);
        }
      });
    }
  }

  Future<void> uploadVideo() async {
    if ((videoFile == null && videoBytes == null) || (imageFile == null && imageBytes == null)) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Veuillez sélectionner les fichiers vidéo et image')),
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
      appBar: AppBar(title: Text('Upload Video')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Titre'),
            ),
            TextField(
              controller: categoryController,
              decoration: InputDecoration(labelText: 'Catégorie'),
            ),
            TextField(
              controller: durationController,
              decoration: InputDecoration(labelText: 'Durée en secondes'),
              keyboardType: TextInputType.number,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: pickVideoFile,
              child: Text(videoFile == null && videoBytes == null
                  ? 'Sélectionner le fichier vidéo'
                  : 'Vidéo sélectionnée'),
            ),
            ElevatedButton(
              onPressed: pickImageFile,
              child: Text(imageFile == null && imageBytes == null
                  ? 'Sélectionner le fichier image'
                  : 'Image sélectionnée'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: uploadVideo,
              child: Text('Télécharger la vidéo'),
            ),
          ],
        ),
      ),
    );
  }
}
