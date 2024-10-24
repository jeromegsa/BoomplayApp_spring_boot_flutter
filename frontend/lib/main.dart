import 'package:flutter/material.dart';
import 'package:frontend/Screens/music_list.dart';
import 'package:frontend/services/auth_service.dart';

import 'Screens/form_page.dart';
import 'Screens/home.dart';

void main() {
  runApp(MyApp());
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
        '/musics': (context) =>  AuthGuard(child: MusicList()),
      },
    );
  }
}

class AuthGuard extends StatelessWidget {
  final Widget child;

  const AuthGuard({Key? key, required this.child}) : super(key: key);

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
