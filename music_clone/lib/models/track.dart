class Track {
  final String id;
  final String name;
  final List<String> artists;
  final String? imageUrl;
  final String? previewUrl; // Add previewUrl property

  Track({
    required this.id,
    required this.name,
    required this.artists,
    this.imageUrl,
    this.previewUrl, // Add previewUrl to the constructor
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
      previewUrl: json['preview_url'], // Extract previewUrl from JSON
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artists': artists,
      'imageUrl': imageUrl,
      'previewUrl': previewUrl,
    };
  }

  @override
  String toString() {
    return 'Track{id: $id, name: $name, artists: $artists,  imageUrl: $imageUrl, previewUrl: $previewUrl}';
  }
}
