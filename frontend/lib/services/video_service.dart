import 'dart:io';
import 'dart:typed_data';
import 'package:http/http.dart' as http;
import 'package:path/path.dart';

class VideoService {
  Future<String> uploadVideo({
    required String title,
    required String category,
    // required int duration,
    File? videoFile,
    Uint8List? videoBytes,
    File? imageFile,
    Uint8List? imageBytes,
  }) async {
    final uri = Uri.parse('http://127.0.0.1:8080/api/videos/upload'); 
    var request = http.MultipartRequest('POST', uri)
      ..fields['title'] = title
      ..fields['category'] = category;
      // ..fields['duration'] = duration.toString();

    // Ajouter le fichier vidéo ou les octets
    if (videoFile != null) {
      try {
        request.files.add(await http.MultipartFile.fromPath(
          'video',
          videoFile.path,
          filename: basename(videoFile.path),
        ));
      } catch (e) {
        throw Exception('Erreur lors de l\'ajout du fichier vidéo : $e');
      }
    } else if (videoBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'video',
        videoBytes,
        filename: 'video.mp4',
      ));
    }

    // Ajouter le fichier image ou les octets
    if (imageFile != null) {
      try {
        request.files.add(await http.MultipartFile.fromPath(
          'image',
          imageFile.path,
          filename: basename(imageFile.path),
        ));
      } catch (e) {
        throw Exception('Erreur lors de l\'ajout du fichier image : $e');
      }
    } else if (imageBytes != null) {
      request.files.add(http.MultipartFile.fromBytes(
        'image',
        imageBytes,
        filename: 'image.jpg',
      ));
    }

    // Envoyer la requête
    try {
      final response = await request.send();
      if (response.statusCode == 200) {
        final responseData = await response.stream.bytesToString();
        return responseData;
      } else {
        final responseData = await response.stream.bytesToString();
        throw Exception('Erreur lors de l\'ajout de la vidéo : ${response.statusCode} - $responseData');
      }
    } catch (e) {
      throw Exception('Erreur lors de l\'envoi de la requête : $e');
    }
  }
}
