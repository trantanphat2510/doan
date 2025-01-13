import 'package:flutter/material.dart';
import 'package:music_clone/models/playlist.dart';
import 'package:music_clone/models/track.dart';
import 'package:music_clone/screens/player_screen.dart';
import 'package:music_clone/service/spotify_service.dart';

class PlaylistDetailsScreen extends StatefulWidget {
  final String playlistId;

  const PlaylistDetailsScreen({Key? key, required this.playlistId})
      : super(key: key);

  @override
  _PlaylistDetailsScreenState createState() => _PlaylistDetailsScreenState();
}

class _PlaylistDetailsScreenState extends State<PlaylistDetailsScreen> {
  late Future<Playlist> _playlistFuture;
  late Future<List<Track>> _tracksFuture;
  late SpotifyService _spotifyService;

  @override
  void initState() {
    super.initState();
    _spotifyService = SpotifyService();
    _playlistFuture = _spotifyService.getPlaylist(widget.playlistId);
    _tracksFuture = _spotifyService.getTracksFromPlaylist(widget.playlistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Playlist>(
        future: _playlistFuture,
        builder: (context, playlistSnapshot) {
          if (playlistSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (playlistSnapshot.hasError) {
            return Center(child: Text('Error: ${playlistSnapshot.error}'));
          } else if (playlistSnapshot.hasData) {
            final playlist = playlistSnapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: playlist.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(10.0),
                              child: Image.network(
                                playlist.imageUrl!,
                                fit: BoxFit.cover,
                                width: 250,
                                height: 250,
                              ),
                            )
                          : Container(
                              color: Colors.grey,
                              width: 200,
                              height: 200,
                            ),
                    ),
                    const SizedBox(height: 16),
                    Center(
                      child: Text(
                        playlist.name,
                        style: const TextStyle(
                            // overflow: TextOverflow.ellipsis,
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Danh sách bài hát',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.white),
                    ),
                    const SizedBox(height: 16),
                    FutureBuilder<List<Track>>(
                      future: _tracksFuture,
                      builder: (context, tracksSnapshot) {
                        if (tracksSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (tracksSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${tracksSnapshot.error}'));
                        } else if (tracksSnapshot.hasData) {
                          final tracks = tracksSnapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: tracks.length,
                            itemBuilder: (context, index) {
                              final track = tracks[index];
                              return ListTile(
                                title: Text(
                                  track.name,
                                  style: const TextStyle(color: Colors.white),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                subtitle: Text(
                                  track.artists.join(', '),
                                  style: const TextStyle(color: Colors.white70),
                                  overflow: TextOverflow.ellipsis,
                                ),
                                leading: track.imageUrl != null
                                    ? Image.network(
                                        track.imageUrl!,
                                        width: 60,
                                        height: 60,
                                        fit: BoxFit.cover,
                                      )
                                    : const Icon(Icons.music_note,
                                        color: Colors.white),
                                onTap: () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => PlayerScreen(
                                          track: track,
                                          imageUrl: track.imageUrl),
                                    ),
                                  );
                                },
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: Text('Không tìm thấy bài hát nào'));
                        }
                      },
                    )
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('Không có dữ liệu playlist'));
          }
        },
      ),
    );
  }
}
