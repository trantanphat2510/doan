class Album {
  final String id;
  final String name;
  final String artist;
  final String imageUrl;

  Album(
      {required this.id,
      required this.name,
      required this.artist,
      required this.imageUrl});

  factory Album.fromJson(Map<String, dynamic> json) {
    return Album(
      id: json['id'],
      name: json['name'],
      artist: json['artists'][0]['name'],
      imageUrl: json['images'][0]['url'],
    );
  }
}
