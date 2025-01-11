class Track {
  final String id;
  final String name;
  final List<String> artists;
  final String? imageUrl;
  final String? previewUrl;
  final int? duration; // Thời lượng bài hát (ms)
  final String uri;

  Track({
    required this.id,
    required this.name,
    required this.artists,
    this.imageUrl,
    this.previewUrl,
    this.duration,
    required this.uri,
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
      previewUrl: json['preview_url'],
      duration: json['duration_ms'], // Thời lượng từ API (ms)
      uri: json['uri'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'artists': artists,
      'imageUrl': imageUrl,
      'previewUrl': previewUrl,
      'duration': duration,
      'uri': uri,
    };
  }

  @override
  String toString() {
    return 'Track{id: $id, name: $name, artists: $artists, imageUrl: $imageUrl, previewUrl: $previewUrl, duration: $duration, uri: $uri}';
  }
}
