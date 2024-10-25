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
  Duration _currentPosition = Duration.zero;
  Duration _totalDuration = Duration.zero;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;

    // Play the initial music
    _playMusic(widget.musics[currentIndex].url);

    // Listen for position changes
    _audioPlayer.onPositionChanged.listen((Duration position) {
      setState(() {
        _currentPosition = position;
      });
    });

    // Listen for duration changes
    _audioPlayer.onDurationChanged.listen((Duration duration) {
      setState(() {
        _totalDuration = duration;
      });
    });

    // Listen for state changes
    _audioPlayer.onPlayerStateChanged.listen((PlayerState state) {
      if (state == PlayerState.completed) {
        setState(() {
          // Reset the state when music completes
          _isPlaying = false;
          _currentPosition = Duration.zero;
          _totalDuration = Duration.zero;

          // Optional: Move to the next music or reset to the first music
          currentIndex = (currentIndex + 1) % widget.musics.length; // Loop back to the start
          _playMusic(widget.musics[currentIndex].url);
        });
      }
    });
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

  void _onSliderChanged(double value) {
    final newPosition = Duration(seconds: (value * _totalDuration.inSeconds).toInt());
    _audioPlayer.seek(newPosition);
  }

  @override
  void dispose() {
    _audioPlayer.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final currentMusic = widget.musics[currentIndex];
    
    // Calculate the slider value based on the current position and total duration
    double sliderValue = _totalDuration.inSeconds > 0
        ? _currentPosition.inSeconds / _totalDuration.inSeconds
        : 0.0;

    return Scaffold(
        appBar: AppBar(
        title: const Center(
          child: Text(
            'BOOM PLAY',
            style: TextStyle(
              color: Colors.white,
              fontSize: 50,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        toolbarHeight: 190,
        backgroundColor: const Color(0xffff735c),
        flexibleSpace: const Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 100),
            Center(
              child: Text(
                'Votre plateforme de musique préférée, amusez-vous librement !',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ],
        ),
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(
            bottom: Radius.circular(30),
          ),
        ),
      ),
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
                    image: NetworkImage(currentMusic.imageUrl),
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

              // Progress Bar
              Slider(
                value: sliderValue,
                onChanged: _onSliderChanged,
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
