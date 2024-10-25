import 'package:flutter/material.dart';
import 'package:frontend/Screens/test_video.dart';
import 'package:frontend/model/videos.dart';
import 'package:frontend/services/api_service.dart';

class VideoList extends StatelessWidget {
  final ApiService apiService = ApiService();

  VideoList({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Boomplay Videos'),
        backgroundColor: const Color(0xffff735c),
        actions: [
          ElevatedButton(
            child: const Text("Musics"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/musics');
            },
          ),
          ElevatedButton(
            child: const Text("Vidéos"),
            onPressed: () {
              Navigator.of(context).pushReplacementNamed('/videos');
            },
          ),
        ],
      ),
      body: FutureBuilder<List<Video>>(
        future: apiService.getVideos(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('No videos found.'));
          }

          List<Video> videos = snapshot.data!;

          return Column(
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 16.0, vertical: 20.0),
                child: Text(
                  'Vidéos',
                  style: TextStyle(
                    fontSize: 25,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: Text(
                  '${videos.length} videos',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return buildVideoItem(
                      videos[index],
                      context,
                      videos,
                      index,
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
          Navigator.pushReplacementNamed(context, '/add-video'); // Ajustez si vous avez une page pour ajouter des vidéos
        },
        backgroundColor: const Color(0xffff735c),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  Widget buildVideoItem(Video video, BuildContext context, List<Video> videos, int index) {
    return GestureDetector(
      onTap: () {
        // Passer toute la liste de vidéos et l'index à l'écran de lecture vidéo
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(videos: videos, initialIndex: index), // Remplacez par votre écran de vidéo
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black26,
              blurRadius: 4.0,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: ListTile(
          leading: const Icon(
            Icons.play_circle_fill,
            color: Colors.grey,
            size: 40,
          ),
          title: Text(
            video.title,
            style: const TextStyle(
              fontWeight: FontWeight.normal,
              fontSize: 18,
            ),
          ),
          subtitle: Text(video.category), // Vous pouvez changer cela selon votre modèle
          trailing: const Icon(
            Icons.favorite,
            color: Colors.grey,
          ),
          contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 16),
        ),
      ),
    );
  }
}
