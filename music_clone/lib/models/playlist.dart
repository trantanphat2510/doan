class Playlist {
  final String id;
  final String name;
  final String description;
  final String? imageUrl;
  final int numberOfTracks;

  Playlist({
    required this.id,
    required this.name,
    required this.description,
    this.imageUrl,
    required this.numberOfTracks,
  });

  factory Playlist.fromJson(Map<String, dynamic> json) {
    return Playlist(
      id: json['id'],
      name: json['name'],
      description: json['description'] ?? 'No description available',
      imageUrl: json['images'].isNotEmpty ? json['images'][0]['url'] : null,
      numberOfTracks: json['tracks']['total'],
    );
  }
}
