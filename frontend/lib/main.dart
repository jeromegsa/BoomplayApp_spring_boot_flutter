import 'package:flutter/material.dart';

import 'Screens/form_page.dart';
import 'Screens/home.dart';
// import 'Screens/signup.dart';
// import 'Screens/music_list.dart';
// import 'Screens/video_list.dart';
// import 'Screens/play_music.dart';
// import 'Screens/play_video.dart';

void main() {
  runApp( MyApp());
}


class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(), // Remplacez par votre widget de démarrage
        '/login': (context) => const MyForm(),
      },
    );
  }
}

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Boomplay Home'),
//         backgroundColor: const Color(0xffff735c),
//       ),
//     );
// }
// }