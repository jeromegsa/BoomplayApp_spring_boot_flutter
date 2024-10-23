import 'package:flutter/material.dart';
import 'package:frontend/services/auth_service.dart';
import 'Screens/form_page.dart';
import 'Screens/home.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BoomPlay',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/login',
      routes: {
        '/login': (context) => const MyForm(),
        '/': (context) => const AuthGuard(child: Home()),
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

        // Si l'utilisateur est connecté
        if (snapshot.hasData && snapshot.data == true) {
          return child; // Afficher la page protégée
        } else {
          // L'utilisateur n'est pas connecté
          WidgetsBinding.instance.addPostFrameCallback((_) {
            final route = ModalRoute.of(context)?.settings.name;

            // Rediriger vers la page de connexion si ce n'est pas déjà la page de connexion
            if (route != '/login') {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const MyForm()),
              );
            }
          });
          return const Center(
              child: Text('Accès refusé, redirection vers la connexion...'));
        }
      },
    );
  }
}