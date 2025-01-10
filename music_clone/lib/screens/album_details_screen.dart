import 'package:flutter/material.dart';
import 'package:music_clone/models/album.dart';
import 'package:music_clone/models/track.dart';
import 'package:music_clone/service/spotify_service.dart';

class AlbumDetailsScreen extends StatefulWidget {
  final String albumId;

  const AlbumDetailsScreen({Key? key, required this.albumId}) : super(key: key);

  @override
  _AlbumDetailsScreenState createState() => _AlbumDetailsScreenState();
}

class _AlbumDetailsScreenState extends State<AlbumDetailsScreen> {
  late Future<Album> _albumFuture;
  late Future<List<Track>> _tracksFuture;
  final SpotifyService spotifyService = SpotifyService();

  @override
  void initState() {
    super.initState();
    _albumFuture = spotifyService.getAlbum(widget.albumId);
    _tracksFuture = spotifyService.getTracksFromAlbum(widget.albumId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        iconTheme: const IconThemeData(color: Colors.white),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: FutureBuilder<Album>(
        future: _albumFuture,
        builder: (context, albumSnapshot) {
          if (albumSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (albumSnapshot.hasError) {
            return Center(child: Text('Error: ${albumSnapshot.error}'));
          } else if (albumSnapshot.hasData) {
            final album = albumSnapshot.data!;
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 150,
                        height: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8),
                          image: DecorationImage(
                              image: NetworkImage(album.imageUrl ?? ""),
                              fit: BoxFit.cover),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(album.name,
                                style: const TextStyle(
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold,
                                    color: Colors.white)),
                            Text(
                              album.artists.join(', '),
                              style: const TextStyle(
                                  fontSize: 16,
                                  color: Colors.white60,
                                  fontWeight: FontWeight.w500),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  const Text(
                    "Bài hát",
                    style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white),
                  ),
                  const SizedBox(height: 10),
                  Expanded(
                    child: FutureBuilder<List<Track>>(
                      future: _tracksFuture,
                      builder: (context, trackSnapshot) {
                        if (trackSnapshot.connectionState ==
                            ConnectionState.waiting) {
                          return const Center(
                              child: CircularProgressIndicator());
                        } else if (trackSnapshot.hasError) {
                          return Center(
                              child: Text('Error: ${trackSnapshot.error}'));
                        } else if (trackSnapshot.hasData) {
                          final tracks = trackSnapshot.data!;
                          return ListView.builder(
                            itemCount: tracks.length,
                            itemBuilder: (context, index) {
                              final track = tracks[index];
                              return ListTile(
                                leading: Text(
                                  '${index + 1}',
                                  style: const TextStyle(
                                      color: Colors.white70,
                                      fontWeight: FontWeight.w600),
                                ),
                                title: Text(
                                  track.name,
                                  style: const TextStyle(color: Colors.white),
                                ),
                                subtitle: Text(
                                  track.artists.join(', '),
                                  style: const TextStyle(color: Colors.white60),
                                ),
                              );
                            },
                          );
                        } else {
                          return const Center(
                              child: Text('No tracks in this album'));
                        }
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: Text('No Album Data'));
          }
        },
      ),
    );
  }
}
