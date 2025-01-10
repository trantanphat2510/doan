class Album {
  final String id;
  final String name;
  final List<String> artists;
  final String releaseDate;
  final int totalTracks;
  final String? imageUrl;

  Album({
    required this.id,
    required this.name,
    required this.artists,
    required this.releaseDate,
    required this.totalTracks,
    this.imageUrl,
  });

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      artists: (json['artists'] as List)
          .map((artist) => artist['name'] as String)
          .toList(),
      releaseDate: json['release_date'],
      totalTracks: json['total_tracks'],
      imageUrl: json['images'].isNotEmpty ? json['images'][0]['url'] : null,
    );
  }
}
