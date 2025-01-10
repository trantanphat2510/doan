import 'package:flutter/material.dart';
import 'package:music_clone/models/artist.dart';
import 'package:music_clone/service/spotify_service.dart';

class SpotifyArtistList extends StatelessWidget {
  const SpotifyArtistList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpotifyService spotifyService = SpotifyService();

    return FutureBuilder<List<Artist>>(
      future: Future.wait([
        spotifyService.getArtist(
            '5dfZ5uSmzR7VQK0udbAVpf'), // Replace with real artist IDs if you want.
        spotifyService.getArtist('0ZbgKh0FgPYeFP38nVaEGp'),
        spotifyService.getArtist('4KPyQxL1zqEiBcTwW6c9HE'),
      ]),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 300, // Adjust the height as needed
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final artist = snapshot.data![index];
                return SizedBox(
                  width: 210, // Adjust the width as needed
                  child: Card(
                    color: Colors.transparent,
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(8.0), // Adjust corner rounding
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Expanded(
                          child: artist.imageUrl != null
                              ? Image.network(
                                  artist.imageUrl!,
                                  fit: BoxFit.cover,
                                  width: double.infinity,
                                )
                              : Container(
                                  color:
                                      Colors.grey), // Placeholder if no image
                        ),
                        Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    artist.name,
                                    style: const TextStyle(
                                      fontWeight: FontWeight.bold,
                                      fontSize: 18,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Text(
                                    artist.genres.join(', '),
                                    style: const TextStyle(
                                      fontSize: 14,
                                      color: Colors.white60,
                                    ),
                                    maxLines: 1,
                                    overflow: TextOverflow
                                        .ellipsis, // to avoid overflow
                                  ),
                                ])),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        } else {
          return const Center(child: Text('No Artists Found'));
        }
      },
    );
  }
}
