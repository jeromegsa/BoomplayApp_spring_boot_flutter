import 'package:flutter/material.dart';
import 'package:frontend/Screens/play_music.dart';
import 'package:frontend/model/music.dart';
import 'package:frontend/services/api_service.dart';

class MusicList extends StatefulWidget {
  final ApiService apiService = ApiService();

  MusicList({super.key});

  @override
  _MusicListState createState() => _MusicListState();
}

class _MusicListState extends State<MusicList> {
  List<Music> allMusics = [];
  List<Music> filteredMusics = [];
  String searchQuery = "";

  @override
  void initState() {
    super.initState();
    fetchMusics();
  }

  Future<void> fetchMusics() async {
    allMusics = await widget.apiService.getMusics();
    setState(() {
      filteredMusics = allMusics;
    });
  }

  void filterMusic(String query) {
    setState(() {
      searchQuery = query;
      filteredMusics = allMusics
          .where((music) =>
              music.title.toLowerCase().contains(query.toLowerCase()) ||
              music.artist.toLowerCase().contains(query.toLowerCase()))
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Boomplay Home',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: const Color(0xffff735c),
        actions: [
          ElevatedButton(
              child: const Text("Musics"),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/musics');
              }),
          ElevatedButton(
              child: const Text("Vidéos"),
              onPressed: () {
                Navigator.of(context).pushReplacementNamed('/videos');
              }),
        ],
      ),
      body: Column(
        children: [
          // Formulaire de filtrage
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 10.0),
            child: TextField(
              onChanged: filterMusic,
              decoration: InputDecoration(
                labelText: 'Search Music',
                prefixIcon: const Icon(Icons.search),
                filled: true,
                fillColor: Colors.grey.shade200,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
          ),
          const SizedBox(height: 10),
          // Afficher la liste des musiques filtrées
          Expanded(
            child: filteredMusics.isEmpty
                ? const Center(child: Text('No music found.'))
                : ListView.builder(
                    itemCount: filteredMusics.length,
                    itemBuilder: (context, index) {
                      return buildPlaylistItem(
                        filteredMusics[index],
                        context,
                        filteredMusics,
                        index,
                      );
                    },
                  ),
          ),
        ],
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
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AudioPlayerScreen(musics: musics, initialIndex: index),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 16),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: isPlaying ? Colors.blueGrey.shade50 : Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.3),
              blurRadius: 4.0,
              offset: const Offset(0, 2),
            ),
          ],
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
            Icons.favorite_border,
            color: Colors.grey,
          ),
        ),
      ),
    );
  }
}
