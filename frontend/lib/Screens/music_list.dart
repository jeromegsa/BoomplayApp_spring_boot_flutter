import 'package:flutter/material.dart';
import 'package:frontend/Screens/play_music.dart';
import 'package:frontend/model/music.dart';
import 'package:frontend/services/api_service.dart';

class MusicList extends StatelessWidget {
  final ApiService apiService = ApiService();

  MusicList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:   AppBar(
        title: const Text('Boomplay Home',style: TextStyle(color: Colors.white),),
        backgroundColor: const Color(0xffff735c),

        actions:[
          ElevatedButton(child: const Text("Musics"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/musics');
                  }
          ),
           ElevatedButton(child: const Text("Vidéos"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/videos');
                  }
          )
        ]

      ),
      body: FutureBuilder<List<Music>>(
        future: apiService.getMusics(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No music found.'));
          }

          List<Music> musics = snapshot.data!;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Text(
                  'Musics',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${musics.length} songs - ${calculateTotalDuration(musics)} min',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: musics.length,
                  itemBuilder: (context, index) {
                    return buildPlaylistItem(
                      musics[index],
                      context,
                      musics,  // Passer toute la liste des musiques
                      index,   // Passer l'index de la musique sélectionnée
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/add-music');
        },
        backgroundColor: const Color(0xffff735c),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  Widget buildPlaylistItem(Music music, BuildContext context, List<Music> musics, int index, {bool isPlaying = false}) {
    return GestureDetector(
      onTap: () {
        // Passer toute la liste de musiques et l'index à AudioPlayerScreen
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AudioPlayerScreen(musics: musics, initialIndex: index),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isPlaying ? Colors.blueGrey.shade50 : Colors.white,
          boxShadow: isPlaying
              ? [
                  const BoxShadow(
                    color: Colors.black26,
                    blurRadius: 4.0,
                    offset: Offset(0, 2),
                  ),
                ]
              : [],
        ),
        child: ListTile(
          leading: Icon(
            Icons.play_circle_fill,
            color: isPlaying ? Colors.pinkAccent : Colors.grey,
            size: 40,
          ),
          title: Text(
            music.title,
            style: TextStyle(
              fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
              fontSize: 18,
            ),
          ),
          subtitle: Text(music.artist),
          trailing: const Icon(
             Icons.favorite ,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
      ),
    );
  }

  String calculateTotalDuration(List<Music> musics) {
    // Calculer la somme des durées
    int totalDuration = musics.fold(0, (sum, music) => sum + music.duration);
    return totalDuration.toString(); // Retourne la durée totale sous forme de chaîne
  }
}
