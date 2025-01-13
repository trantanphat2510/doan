import 'package:flutter/material.dart';
import 'package:music_clone/models/playlist.dart';
import 'package:music_clone/service/spotify_service.dart';
import 'package:music_clone/screens/playlist_details_screen.dart';

class SpotifyPlaylistList extends StatelessWidget {
  final List<String> playlistIds; // List of playlist IDs

  const SpotifyPlaylistList({Key? key, required this.playlistIds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpotifyService spotifyService = SpotifyService();

    return FutureBuilder<List<Playlist>>(
      future: Future.wait(playlistIds.map(
          (id) => spotifyService.getPlaylist(id))), // Fetch playlists from IDs
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 270, // Height of the ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final playlist = snapshot.data![index];
                return SizedBox(
                  width: 210, // Width of each playlist card
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                            builder: (context) =>
                                PlaylistDetailsScreen(playlistId: playlist.id)),
                      );
                    },
                    child: Card(
                      color: Colors.transparent,
                      clipBehavior: Clip.antiAlias,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: playlist.imageUrl != null
                                ? Image.network(
                                    playlist.imageUrl!,
                                    fit: BoxFit.cover,
                                    width: double.infinity,
                                  )
                                : Container(color: Colors.grey),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  playlist.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                                Text(
                                  '${playlist.numberOfTracks} Tracks',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white70,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No Playlists Found'));
        }
      },
    );
  }
}
