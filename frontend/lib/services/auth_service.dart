import 'package:frontend/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {
  Future<bool> login(String email, String password) async {
    ApiService apiService = ApiService();
    try {
      List<dynamic> users = await apiService.getUsers();

      for (var user in users) {
        if (user['email'] == email && user['password'] == password) {
          await saveLoginState(user['id'].toString());
          return true;
        }
      }
    } catch (e) {
      print("Erreur lors de l'authentification: $e");
      // Gérer l'erreur ou renvoyer false
    }
    return false;
  }

  // Fonction pour sauvegarder l'état de connexion
  Future<void> saveLoginState(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isLoggedIn', true); // Enregistrer l'état comme "connecté"
    await prefs.setString('userId', userId); // Enregistrer l'identifiant
  }

  // Méthode pour obtenir l'identifiant de l'utilisateur connecté
  Future<String?> getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('userId'); // Obtenir l'identifiant de l'utilisateur
  }

  // Vérification de l'état de connexion
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ??
        false; // Vérifier si l'utilisateur est connecté
  }

  // Déconnexion
  Future<void> logout() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.remove('isLoggedIn'); // Supprimer l'état de connexion
    await prefs.remove('userId'); // Supprimer l'identifiant
  }
}
