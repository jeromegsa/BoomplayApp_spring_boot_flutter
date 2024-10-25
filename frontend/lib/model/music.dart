class Music {
  final int id;
  final String title;
  final String artist;
  final String category;
  final int duration;
  final String url;
  final String imageUrl;

  Music({
    required this.id,
    required this.title,
    required this.artist,
    required this.category,
    required this.duration,
    required this.url,
    required this.imageUrl,
  });

  // Factory method to create a Music instance from JSON
  factory Music.fromJson(Map<String, dynamic> json) {
    return Music(
      id: json['id'] ?? 0, // Utiliser 0 comme valeur par défaut si l'id est null
      title: json['title'] ?? 'No Title', // Utiliser 'No Title' si title est null
      artist: json['artist'] ?? 'Unknown Artist', // Utiliser 'Unknown Artist' si artist est null
      category: json['category'] ?? 'Unknown Category', // Valeur par défaut pour category
      duration: json['duration'] ?? 0, // Utiliser 0 si duration est null
      url: json['url'] ?? '', // Utiliser une chaîne vide si url est null
      imageUrl: json['imageUrl'] ?? '', // Utiliser une chaîne vide si url est null
    );
  }
}
