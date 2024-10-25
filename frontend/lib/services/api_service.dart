import 'dart:convert';
import 'package:frontend/model/music.dart';
import 'package:frontend/model/videos.dart';
import 'package:http/http.dart' as http;

class ApiService {
  final String baseUrl = 'http://127.0.0.1:8080/api';

  Future<Map<String, dynamic>> getAllData() async {
    final response = await http.get(Uri.parse('$baseUrl/data/all'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load data');
    }
  }

  Future<List<Music>> getMusics() async {
    final data = await getAllData();
    List<dynamic> jsonList = data['musics'];
    return jsonList.map((json) => Music.fromJson(json)).toList();
  }

  // Méthode pour récupérer toutes les vidéos
  Future<List<Video>> getVideos() async {
    final response = await http.get(Uri.parse('$baseUrl/videos'));

    if (response.statusCode == 200) {
      List<dynamic> jsonList = json.decode(response.body);
      return jsonList.map((json) => Video.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load videos');
    }
  }

  Future<List<dynamic>> getUsers() async {
    final response = await http.get(Uri.parse('$baseUrl/users'));

    if (response.statusCode == 200) {
      return json.decode(response.body);
    } else {
      throw Exception('Failed to load users');
    }
  }

  Future<void> addUser(Map<String, dynamic> user) async {
    final response = await http.post(
      Uri.parse('$baseUrl/users'),
      headers: {'Content-Type': 'application/json'},
      body: json.encode(user),
    );

    if (response.statusCode != 200 && response.statusCode != 201) {
      print('Response status: ${response.statusCode}');
      print('Response body: ${response.body}');
      throw Exception('Échec de l\'ajout de l\'utilisateur');
    } else {
      print('Utilisateur ajouté avec succès: ${response.body}');
    }
  }

  static Future<void> registerUser(String username, String email, String password) async {
    Map<String, dynamic> newUser = {
      'username': username,
      'email': email,
      'password': password,
    };

    ApiService apiService = ApiService();
    await apiService.addUser(newUser);
  }
}
