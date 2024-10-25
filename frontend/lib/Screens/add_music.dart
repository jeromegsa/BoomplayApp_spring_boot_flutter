// ignore: avoid_web_libraries_in_flutter
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:frontend/services/music_service.dart'; // Assurez-vous d'importer le service

class UploadMusicScreen extends StatefulWidget {
  @override
  _UploadMusicScreenState createState() => _UploadMusicScreenState();
}

class _UploadMusicScreenState extends State<UploadMusicScreen> {
  final _formKey = GlobalKey<FormState>();
  String? title;
  String? artist;
  String? category;
  int? duration;
  html.File? audioFile;
  html.File? imageFile;
  final MusicService _musicService = MusicService(); // Instanciation du service

  Future<void> _uploadMusic() async {
    if (_formKey.currentState!.validate() && audioFile != null && imageFile != null) {
      try {
        final responseData = await _musicService.uploadMusic(
          title: title!,
          artist: artist!,
          category: category!,
          duration: duration!,
          audioFile: audioFile!,
          imageFile: imageFile!,
        );

        // Affichage du message de succès
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData)));

        // Vider les champs
        _clearForm();
      } catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(e.toString())));
      }
    }
  }

  void _clearForm() {
    setState(() {
      title = null;
      artist = null;
      category = null;
      duration = null;
      audioFile = null;
      imageFile = null;
    });
    _formKey.currentState?.reset(); // Réinitialiser le formulaire
  }

  void _pickAudioFile() {
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

  void _pickImageFile() {
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Upload Music')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) => value!.isEmpty ? 'Please enter a title' : null,
                onChanged: (value) => title = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Artist'),
                validator: (value) => value!.isEmpty ? 'Please enter an artist' : null,
                onChanged: (value) => artist = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Category'),
                validator: (value) => value!.isEmpty ? 'Please enter a category' : null,
                onChanged: (value) => category = value,
              ),
              TextFormField(
                decoration: const InputDecoration(labelText: 'Duration (in seconds)'),
                validator: (value) => value!.isEmpty ? 'Please enter a duration' : null,
                keyboardType: TextInputType.number,
                onChanged: (value) => duration = int.tryParse(value),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _pickAudioFile,
                child: const Text('Pick Audio File'),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: _pickImageFile,
                child: const Text('Pick Image File'),
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                onPressed: _uploadMusic,
                child: const Text('Upload Music'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
