import 'package:flutter/material.dart';
import 'package:frontend/Screens/my_form.dart';

import 'Screens/form_page.dart';
import 'Screens/home.dart';
// import 'Screens/signup.dart';
// import 'Screens/music_list.dart';
// import 'Screens/video_list.dart';
// import 'Screens/play_music.dart';
// import 'Screens/play_video.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Boomplay',
      theme: ThemeData(
        primarySwatch: Colors.orange,
      ),
      initialRoute: '/',
      routes: {
        '/': (context) => const Home(),
        '/login': (context) => const MyForm(),
        // '/signup': (context) => const SignupPage(),
        // '/musics': (context) => const MusicListPage(),
        // '/videos': (context) => const VideoListPage(),
        // '/play-music': (context) => const PlayMusicPage(),
        // '/play-video': (context) => const PlayVideoPage(),
      },
    );
  }
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boomplay Home'),
        backgroundColor: const Color(0xffff735c),
      ),
    );
}
}