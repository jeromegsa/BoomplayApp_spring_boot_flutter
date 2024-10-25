import 'package:flutter/material.dart';
import 'package:frontend/Screens/add_music.dart';
import 'package:frontend/Screens/add_video.dart';
import 'package:frontend/Screens/music_list.dart';
import 'package:frontend/Screens/register.dart';
import 'package:frontend/services/auth_service.dart';

import 'Screens/form_page.dart';
import 'Screens/home.dart';

void main() {
   WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'BoomPlay',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const MyForm(),
        '/': (context) => const AuthGuard(child: Home()),
        '/musics': (context) => AuthGuard(child: MusicList()),
        '/add-music': (context) => AuthGuard(child: UploadMusicScreen()),
        '/add-video': (context) => AuthGuard(child: VideoUploadScreen()),
        '/register':(context)=> const Register()
        // '/add-music': (context) => AuthGuard(child: AddMusicScreen()),
      },
    );
  }
}

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: AuthService().isLoggedIn(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        if (snapshot.hasData && snapshot.data == true) {
          // L'utilisateur est connecté, continuer
          return child;
        } else {
          // Redirection après que la frame actuelle a été dessinée
          WidgetsBinding.instance.addPostFrameCallback((_) {
            // Vérifier que nous ne sommes pas déjà sur la page de connexion
            if (ModalRoute.of(context)?.settings.name != '/login') {
              Navigator.of(context).pushReplacementNamed('/login');
            }
          });
          return const Center(child: CircularProgressIndicator());
        }
      },
    );
  }
}
