import 'package:frontend/services/api_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthService {

    final ApiService apiService = ApiService();
  Future<bool> login(String email, String password) async {
    ApiService apiService = ApiService();
    List<dynamic> users = await apiService.getUsers();    

    for (var user in users) {
      if (user['email'] == email && user['password'] == password) {
        // Si l'utilisateur est authentifié, on sauvegarde l'état de connexion
        await saveLoginState();
        return true;
      }
    }
    return false; 
  }

  // Fonction pour sauvegarder l'état de connexion
  Future<void> saveLoginState() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool(
        'isLoggedIn', true); // Enregistrer l'état comme "connecté"
  }

  // Vérification de l'état de connexion
  Future<bool> isLoggedIn() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('isLoggedIn') ??
        false;
  }

  // Déconnexion
  Future<void> logout() async {
    try {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.remove('isLoggedIn'); // Supprimez l'état de connexion
    } catch (e) {
      print('Erreur lors de la déconnexion: $e');
    }
  }



  
}
