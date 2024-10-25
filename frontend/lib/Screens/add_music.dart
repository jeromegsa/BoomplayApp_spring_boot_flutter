import 'dart:async'; // Add this import
import 'dart:html' as html;

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

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

  Future<void> _uploadMusic() async {
    if (_formKey.currentState!.validate() && audioFile != null && imageFile != null) {
      final uri = Uri.parse('http://127.0.0.1:8080/api/music/upload'); 
      var request = http.MultipartRequest('POST', uri)
        ..fields['title'] = title!
        ..fields['artist'] = artist!
        ..fields['category'] = category!
        ..fields['duration'] = duration!.toString();

      try {
        // Read audio file as bytes
        final audioBytes = await _readFileAsBytes(audioFile!);
        request.files.add(http.MultipartFile.fromBytes('audio', audioBytes, filename: audioFile!.name));

        // Read image file as bytes
        final imageBytes = await _readFileAsBytes(imageFile!);
        request.files.add(http.MultipartFile.fromBytes('image', imageBytes, filename: imageFile!.name));

        final response = await request.send();
        if (response.statusCode == 200) {
          // Music added successfully
          final responseData = await response.stream.bytesToString();
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(responseData)));
        } else {
          // Error adding music
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Error adding music')));
        }
      } catch (e) {
        print(e);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Unexpected error: $e')));
      }
    }
  }

  Future<List<int>> _readFileAsBytes(html.File file) async {
    final completer = Completer<List<int>>(); // This should now be recognized
    final reader = html.FileReader();

    reader.onLoadEnd.listen((e) {
      completer.complete(reader.result as List<int>);
    });

    reader.readAsArrayBuffer(file);
    return completer.future;
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
