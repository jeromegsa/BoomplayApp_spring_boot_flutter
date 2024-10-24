import 'package:frontend/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';


class AuthService {
  Future<bool> login(String email, String password) async {
    ApiService apiService = ApiService();
    try {
      List<dynamic> users = await apiService.getUsers();

      for (var user in users) {
        if (user['email'] == email && user['password'] == password) {
          // Sauvegarder l'état de connexion, l'identifiant et le nom d'utilisateur
          await saveLoginState(user['id'].toString(), user['username']);
          return true;
        }
      }
    } catch (e) {
      print("Erreur lors de l'authentification: $e");
    }
    return false;
  }

  // Fonction pour sauvegarder l'état de connexion
  Future<void> saveLoginState(String userId, String username) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('isLoggedIn', true); // Enregistrer l'état comme "connecté"
    await prefs.setString('userId', userId); // Enregistrer l'identifiant
    await prefs.setString('username', username); // Enregistrer le nom d'utilisateur
  }

  // Méthode pour obtenir le nom d'utilisateur
  Future<String?> getUsername() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('username'); // Obtenir le nom d'utilisateur
  }

  // Déconnexion
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn');
    await prefs.remove('userId');
    await prefs.remove('username'); // Supprimer le nom d'utilisateur
  }
  // Vérification de l'état de connexion
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ??
        false; // Vérifier si l'utilisateur est connecté
  }
}



