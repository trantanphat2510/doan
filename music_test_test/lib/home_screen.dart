import 'package:flutter/material.dart';
import '../../music_clone/lib/widgets/spotify_album_list.dart'; // Import widget SpotifyAlbumList

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Spotify Albums'),
      ),
      body: const SpotifyAlbumList(),
    );
  }
}
