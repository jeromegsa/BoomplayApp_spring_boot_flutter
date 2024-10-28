import 'package:flutter/material.dart';
import 'package:frontend/model/videos.dart';
import 'package:video_player/video_player.dart';

class VideoPlayerScreen extends StatefulWidget {
  final List<Video> videos;
  final int initialIndex;

  const VideoPlayerScreen({
    Key? key,
    required this.videos,
    required this.initialIndex,
  }) : super(key: key);

  @override
  _VideoPlayerScreenState createState() => _VideoPlayerScreenState();
}

class _VideoPlayerScreenState extends State<VideoPlayerScreen> {
  late VideoPlayerController _videoController;
  late int currentIndex;
  bool _isPlaying = false;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.initialIndex;
    _initializeVideoController();
  }

  void _initializeVideoController() {
    String videoUrl = widget.videos[currentIndex].url;

    _videoController = VideoPlayerController.networkUrl(Uri.parse(videoUrl))
      ..initialize().then((_) {
        if (mounted) {
          setState(() {});
          _playVideo();
        }
      }).catchError((error) {
        print("Error initializing video: $error");
      });

    _videoController.addListener(() {
      if (mounted) {
        setState(() {
          _isPlaying = _videoController.value.isPlaying;
        });
      }
    });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  void _playVideo() {
    _videoController.play();
  }

  void _pauseVideo() {
    _videoController.pause();
  }

  void _nextVideo() {
    if (currentIndex < widget.videos.length - 1) {
      setState(() {
        currentIndex++;
        _videoController.dispose();
        _initializeVideoController();
      });
    }
  }

  void _previousVideo() {
    if (currentIndex > 0) {
      setState(() {
        currentIndex--;
        _videoController.dispose();
        _initializeVideoController();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F2F2),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Video Player
                Stack(
                  alignment: Alignment.center,
                  children: [
                    _videoController.value.isInitialized
                        ? Container(
                            width: 5000, 
                            height:1000, 
                            child: AspectRatio(
                              aspectRatio: _videoController.value.aspectRatio,
                              child: VideoPlayer(_videoController),
                            ),
                          )
                        : const Center(child: CircularProgressIndicator()),

                    // Playback Controls Overlay
                    if (_videoController.value.isInitialized) ...[
                      Positioned(
                        bottom: 50,
                        left: 0,
                        right: 0,
                        child: Column(
                          children: [
                            // Progress Bar
                            ValueListenableBuilder<VideoPlayerValue>(
                              valueListenable: _videoController,
                              builder: (context, value, child) {
                                return Column(
                                  children: [
                                    Slider(
                                      min: 0.0,
                                      max: value.duration.inSeconds.toDouble(),
                                      value: value.position.inSeconds.toDouble(),
                                      onChanged: (newValue) {
                                        _videoController.seekTo(Duration(seconds: newValue.toInt()));
                                      },
                                    ),
                                    Text(
                                      "${value.position.inMinutes}:${(value.position.inSeconds.remainder(60)).toString().padLeft(2, '0')} / ${value.duration.inMinutes}:${(value.duration.inSeconds.remainder(60)).toString().padLeft(2, '0')}",
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 10),
                            // Playback Controls
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                IconButton(
                                  icon: const Icon(Icons.skip_previous, size: 36),
                                  onPressed: _previousVideo,
                                ),
                                IconButton(
                                  icon: Icon(
                                    _isPlaying ? Icons.pause : Icons.play_arrow,
                                    size: 64,
                                    color: Colors.red,
                                  ),
                                  onPressed: _isPlaying ? _pauseVideo : _playVideo,
                                ),
                                IconButton(
                                  icon: const Icon(Icons.skip_next, size: 36),
                                  onPressed: _nextVideo,
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ],
                ),

                const SizedBox(height: 20),

                // Video Title
                Text(
                  widget.videos[currentIndex].title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  widget.videos[currentIndex].category,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
