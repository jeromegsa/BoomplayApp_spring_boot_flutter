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
                  '${videos.length} vidéos',
                  style: const TextStyle(
                    fontSize: 15,
                    color: Colors.grey,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3,
                    childAspectRatio: 1, // Change aspect ratio to be square
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: videos.length,
                  itemBuilder: (context, index) {
                    return buildVideoCard(videos[index], context, videos, index);
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushReplacementNamed(context, '/add-video');
        },
        backgroundColor: const Color(0xffff735c),
        child: const Icon(Icons.add, size: 30, color: Colors.white),
      ),
    );
  }

  Widget buildVideoCard(Video video, BuildContext context, List<Video> videos, int index) {
    // Imprimer l'URL de l'image
    print('Image URL: ${video.imageUrl}');

    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => VideoPlayerScreen(videos: videos, initialIndex: index),
          ),
        );
      },
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
        elevation: 0, // Remove shadow
        child: Stack(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                video.imageUrl,
                width: double.infinity,
                height: double.infinity, // Take the full height
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) {
                  return const Center(child: Icon(Icons.error));
                },
              ),
            ),
            Positioned(
              left: 0,
              right: 0,
              top: 0,
              bottom: 0,
              child: Center(
                child: IconButton(
                  icon: const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 60,
                  ),
                  onPressed: () {
                    // Ajouter une action si nécessaire
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => VideoPlayerScreen(videos: videos, initialIndex: index),
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
