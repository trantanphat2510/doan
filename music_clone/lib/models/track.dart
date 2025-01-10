class Track {
  final String id;
  final String name;
  final List<String> artists;
  final String? imageUrl;

  Track({
    required this.id,
    required this.name,
    required this.artists,
    this.imageUrl,
  });

  factory Track.fromJson(Map<String, dynamic> json) {
    return Track(
      id: json['id'],
      name: json['name'],
      artists: (json['artists'] as List)
          .map((artist) => artist['name'] as String)
          .toList(),
      imageUrl: json['album']?['images'] != null &&
              (json['album']['images'] as List).isNotEmpty
          ? (json['album']['images'] as List)[0]['url']
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artists': artists,
      'imageUrl': imageUrl,
    };
  }

  @override
  String toString() {
    return 'Track{id: $id, name: $name, artists: $artists,  imageUrl: $imageUrl}';
  }
}
