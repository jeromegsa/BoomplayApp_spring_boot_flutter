import 'package:flutter/material.dart';

class MusicList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: Padding(
          padding: const EdgeInsets.all(8.0),
          child: CircleAvatar(
            backgroundImage: AssetImage('assets/images/profile.jpg'), // Votre image ici
          ),
        ),
        title: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Lovestruck',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              'Jane Doe feat Dolor',
              style: TextStyle(
                color: Colors.grey,
                fontSize: 14,
              ),
            ),
          ],
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu, color: Colors.black),
            onPressed: () {},
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: ListView(
                children: [
                  const SizedBox(height: 20),
                  Text(
                    'Your Playlist',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '34 songs - 125 min',
                    style: TextStyle(
                      fontSize: 15,
                      color: Colors.grey,
                    ),
                  ),
                  const SizedBox(height: 20),
                  buildPlaylistItem('Sweet Caroline', 'Lorem feat Ipsum', true),
                  buildPlaylistItem('Devil', 'Lorem rock band', false, isPlaying: true),
                  buildPlaylistItem('Heartbeat', 'Lorem feat D.A.', false),
                  buildPlaylistItem('Sweet Caroline', 'Lorem feat Ipsum', true),
                  buildPlaylistItem('Devil', 'Lorem rock band', false),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 15.0),
              decoration: BoxDecoration(
                color: Colors.redAccent,
                borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  'NOW PLAYING',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: Colors.pinkAccent,
        child: Icon(Icons.pause, size: 30),
      ),
    );
  }

  Widget buildPlaylistItem(String title, String subtitle, bool isFavorite, {bool isPlaying = false}) {
    return ListTile(
      leading: Icon(
        Icons.play_circle_fill,
        color: isPlaying ? Colors.pinkAccent : Colors.grey,
        size: 40,
      ),
      title: Text(
        title,
        style: TextStyle(
          fontWeight: isPlaying ? FontWeight.bold : FontWeight.normal,
          fontSize: 18,
        ),
      ),
      subtitle: Text(subtitle),
      trailing: Icon(
        isFavorite ? Icons.favorite : Icons.favorite_border,
        color: isFavorite ? Colors.pinkAccent : Colors.grey,
      ),
      tileColor: isPlaying ? Colors.blueGrey.shade50 : Colors.transparent,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
      ),
      contentPadding: EdgeInsets.symmetric(vertical: 5, horizontal: 16),
    );
  }
}
