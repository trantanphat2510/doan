import 'package:flutter/material.dart';
import 'package:music_clone/models/artist.dart';
import 'package:music_clone/service/spotify_service.dart';
import 'package:music_clone/screens/artist_details_screen.dart';

class SpotifyArtistList extends StatelessWidget {
  final List<String> artistIds; // Tham số nhận danh sách ID nghệ sĩ

  const SpotifyArtistList({Key? key, required this.artistIds})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpotifyService spotifyService = SpotifyService();

    return FutureBuilder<List<Artist>>(
      future: Future.wait(artistIds.map(
          (id) => spotifyService.getArtist(id))), // Lấy danh sách nghệ sĩ từ ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 270, // Chiều cao của ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final artist = snapshot.data![index];
                return SizedBox(
                  width: 210, // Chiều rộng của mỗi card nghệ sĩ
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) =>
                              ArtistDetailsScreen(artistId: artist.id),
                        ),
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
                            child: artist.imageUrl != null
                                ? Image.network(
                                    artist.imageUrl!,
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
                                  artist.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
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
          return const Center(child: Text('No Artists Found'));
        }
      },
    );
  }
}
