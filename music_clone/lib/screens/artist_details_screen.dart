import 'package:flutter/material.dart';
import 'package:music_clone/models/artist.dart';
import 'package:music_clone/models/track.dart';
import 'package:music_clone/screens/player_screen.dart';
import 'package:music_clone/service/spotify_service.dart';

class ArtistDetailsScreen extends StatefulWidget {
  final String artistId;

  const ArtistDetailsScreen({Key? key, required this.artistId})
      : super(key: key);

  @override
  _ArtistDetailsScreenState createState() => _ArtistDetailsScreenState();
}

class _ArtistDetailsScreenState extends State<ArtistDetailsScreen> {
  late Future<Artist> _artistFuture;
  late Future<List<Track>> _tracksFuture;
  late SpotifyService _spotifyService;

  @override
  void initState() {
    super.initState();
    _spotifyService = SpotifyService();
    _artistFuture = _spotifyService.getArtist(widget.artistId);
    _tracksFuture = _spotifyService.getArtistTopTracks(widget.artistId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        // title:
        //     const Text('Artist Details', style: TextStyle(color: Colors.white)),
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: FutureBuilder<Artist>(
        future: _artistFuture,
        builder: (context, artistSnapshot) {
          if (artistSnapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (artistSnapshot.hasError) {
            return Center(child: Text('Error: ${artistSnapshot.error}'));
          } else if (artistSnapshot.hasData) {
            final artist = artistSnapshot.data!;
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: artist.imageUrl != null
                          ? ClipRRect(
                              borderRadius: BorderRadius.circular(
                                  10.0), // Rounded corners for image
                              child: Image.network(
                                artist.imageUrl!,
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
                        artist.name,
                        style: const TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                    const SizedBox(height: 32),
                    const Text(
                      'Phổ biến',
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
                              physics:
                                  const NeverScrollableScrollPhysics(), // Disable inner list scrolling
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
                                    style:
                                        const TextStyle(color: Colors.white70),
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
                                child: Text('No top tracks found'));
                          }
                        })
                  ],
                ),
              ),
            );
          } else {
            return const Center(child: Text('No artist data'));
          }
        },
      ),
    );
  }
}
