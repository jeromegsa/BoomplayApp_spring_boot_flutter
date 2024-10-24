import 'package:flutter/material.dart';

class MusicListPage extends StatelessWidget {
    const MusicListPage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> musicList = [
      {
        'title': 'Song 1',
        'artist': 'Artist 1',
      },
      {
        'title': 'Song 2',
        'artist': 'Artist 2',
      },
      {
        'title': 'Song 3',
        'artist': 'Artist 3',
      },
      {
        'title': 'Song 4',
        'artist': 'Artist 4',
      },
    ];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Liste des Musiques'),
        backgroundColor: const Color(0xffff735c),
      ),
      body: ListView.builder(
        itemCount: musicList.length,
        itemBuilder: (context, index) {
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: ListTile(
              contentPadding: const EdgeInsets.all(16.0),
              title: Text(
                musicList[index]['title']!,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              subtitle: Text(
                musicList[index]['artist']!,
                style: const TextStyle(fontSize: 16),
              ),
              trailing: IconButton(
                icon: const Icon(Icons.play_arrow),
                onPressed: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text('Lecture de ${musicList[index]['title']}')),
                  );
                },
              ),
            ),
          );
        },
      ),
    );
  }
}
