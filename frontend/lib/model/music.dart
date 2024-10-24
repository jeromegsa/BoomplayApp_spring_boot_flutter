class Music {
  final int id;
  final String title;
  final String artist;
  final String category;
  final int duration;
  final String url;

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.category,
    required this.duration,
    required this.url,
  });

  // Factory method to create a Music instance from JSON
  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'],
      title: json['title'],
      artist: json['artist'],
      category: json['category'],
      duration: json['duration'],
      url: json['url'],
    );
  }
}
