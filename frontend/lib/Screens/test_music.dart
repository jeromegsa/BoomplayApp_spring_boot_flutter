import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:frontend/model/music.dart';

class AudioPlayerScreen extends StatefulWidget {
  final List<Music> musics;
  final int initialIndex;

  const AudioPlayerScreen({super.key, required this.musics, required this.initialIndex});

  @override
  _AudioPlayerScreenState createState() => _AudioPlayerScreenState();
}

class _AudioPlayerScreenState extends State<AudioPlayerScreen> {
  final AudioPlayer _audioPlayer = AudioPlayer();
  late int currentIndex;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _playMusic(widget.musics[currentIndex].url);
  }

  void _playMusic(String url) async {
    await _audioPlayer.play(UrlSource(url));
    setState(() {
      _isPlaying = true;
    });
  }

  void _pauseMusic() async {
    await _audioPlayer.pause();
    setState(() {
      _isPlaying = false;
    });
  }

  void _nextMusic() {
    if (currentIndex < widget.musics.length - 1) {
      setState(() {
        currentIndex++;
        _playMusic(widget.musics[currentIndex].url);
      });
    }
  }

  void _previousMusic() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _playMusic(widget.musics[currentIndex].url);
      });
    }
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentMusic = widget.musics[currentIndex];
    
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // Album Art
              Container(
                width: 250,
                height: 250,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  image: DecorationImage(
                    image: NetworkImage(currentMusic.url), // Replace with album cover URL
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              const SizedBox(height: 30),
              
              // Song Title & Artist
              Text(
                currentMusic.title,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                currentMusic.artist,
                style: TextStyle(
                  fontSize: 18,
                  color: Colors.grey[600],
                ),
              ),
              const SizedBox(height: 30),

              // Progress Bar (This can be updated to show actual progress)
              Slider(
                value: 0.0, // You can integrate this with the current playing position
                onChanged: (value) {},
                activeColor: Colors.red,
                inactiveColor: Colors.grey[300],
              ),

              // Playback Controls
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton(
                    icon: const Icon(Icons.skip_previous, size: 36),
                    onPressed: _previousMusic,
                  ),
                  IconButton(
                    icon: Icon(
                      _isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
                      size: 64,
                      color: Colors.red,
                    ),
                    onPressed: _isPlaying ? _pauseMusic : () => _playMusic(currentMusic.url),
                  ),
                  IconButton(
                    icon: const Icon(Icons.skip_next, size: 36),
                    onPressed: _nextMusic,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
