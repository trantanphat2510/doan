import 'package:flutter/material.dart';
import 'package:music_clone/models/album.dart';
import 'package:music_clone/service/spotify_api_service.dart';
import 'package:music_clone/widgets/album/album_card.dart';

class SpotifyAlbum extends StatefulWidget {
  @override
  State<SpotifyAlbum> createState() => _SpotifyAlbumState();
}

class _SpotifyAlbumState extends State<SpotifyAlbum> {
  final SpotifyService _spotifyService = SpotifyService();
  List<Album> _albums = [];

  @override
  void initState() {
    super.initState();
    _loadAlbums();
  }

  Future<void> _loadAlbums() async {
    try {
      final albums = await Future.wait([
        _spotifyService.getAlbum('03ZYR4zwCrkSsXTROnK2d0'),
        _spotifyService.getAlbum('2UZre9rniPNke0bwRs1SMf'),
      ]);
      setState(() {
        _albums = albums;
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to load albums: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.all(16.0),
          child: Text(
            "Album Hot",
            style: TextStyle(
              color: Colors.white,
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: _albums.length,
            itemBuilder: (context, index) {
              return AlbumCard(album: _albums[index]);
            },
          ),
        ),
      ],
    );
  }
}
