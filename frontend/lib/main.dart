import 'package:flutter/material.dart';
import 'package:frontend/Screens/form_page.dart';
import 'package:frontend/Screens/list_musique.dart';
import 'package:frontend/Screens/register.dart';
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
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mon Application',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(), 
        '/login': (context) => const MyForm(),
        '/register': (context) => const Register(),
        '/music-list':(context)=> const MusicListPage()
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