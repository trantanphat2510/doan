class Artist {
  final String id;
  final String name;
  final List<String> genres;
  final int popularity;
  final String? imageUrl;

  Artist({
    required this.id,
    required this.name,
    required this.genres,
    required this.popularity,
    this.imageUrl,
  });

  factory Artist.fromJson(Map<String, dynamic> json) {
    return Artist(
      id: json['id'],
      name: json['name'],
      genres: List<String>.from(json['genres']),
      popularity: json['popularity'],
      imageUrl: json['images'].isNotEmpty ? json['images'][0]['url'] : null,
    );
  }
}