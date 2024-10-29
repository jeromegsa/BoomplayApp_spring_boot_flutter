// services/music_service.dart
import 'dart:async';
import 'dart:html' as html;
import 'package:http/http.dart' as http;

class MusicService {
  Future<String> uploadMusic({
    required String title,
    required String artist,
    required String category,
    required int duration,
    required html.File audioFile,
    required html.File imageFile,
  }) async {
    final uri = Uri.parse('http://127.0.0.1:8080/api/music/upload'); 
    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = title
      ..fields['artist'] = artist
      ..fields['category'] = category
      ..fields['duration'] = duration.toString();

    try {
      // Read audio file as bytes
      final audioBytes = await _readFileAsBytes(audioFile);
      request.files.add(http.MultipartFile.fromBytes('audio', audioBytes, filename: audioFile.name));

      // Read image file as bytes
      final imageBytes = await _readFileAsBytes(imageFile);
      request.files.add(http.MultipartFile.fromBytes('image', imageBytes, filename: imageFile.name));

      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        return responseData; // Return the response data
      } else {
        throw Exception('Error adding music');
      }
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }

  Future<List<int>> _readFileAsBytes(html.File file) async {
    final completer = Completer<List<int>>();
    final reader = html.FileReader();

    reader.onLoadEnd.listen((e) {
      completer.complete(reader.result as List<int>);
    });

    reader.readAsArrayBuffer(file);
    return completer.future;
  }

  



















  
}
