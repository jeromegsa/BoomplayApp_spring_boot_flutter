class Video {
  final int id;
  final String title;
  final String category;
  final int duration; 
  final String url;

  Video({
    required this.id,
    required this.title,
    required this.category,
    required this.duration,
    required this.url,
  });

  // Factory method to create a Video instance from JSON
  factory Video.fromJson(Map<String, dynamic> json) {
    return Video(
      id: json['id'] ?? 0, // Utiliser 0 comme valeur par défaut si l'id est null
      title: json['title'] ?? 'No Title', // Utiliser 'No Title' si title est null
      category: json['category'] ?? 'Unknown Category', // Valeur par défaut pour category
      duration: json['duration'] ?? 0, // Utiliser 0 si duration est null
      url: json['url'] ?? '', // Utiliser une chaîne vide si url est null
    );
  }
}
