import 'package:flutter/material.dart';
import 'package:music_clone/models/album.dart';
import 'package:music_clone/service/spotify_service.dart';
import 'package:music_clone/screens/album_details_screen.dart';

class SpotifyAlbumList extends StatelessWidget {
  final List<String> albumIds; // Tham số nhận danh sách ID album

  const SpotifyAlbumList({Key? key, required this.albumIds}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final SpotifyService spotifyService = SpotifyService();

    return FutureBuilder<List<Album>>(
      future: Future.wait(albumIds.map(
          (id) => spotifyService.getAlbum(id))), // Lấy danh sách album từ ID
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          return SizedBox(
            height: 270,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                final album = snapshot.data![index];
                return SizedBox(
                  width: 210,
                  child: InkWell(
                    onTap: () {
                      Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) =>
                            AlbumDetailsScreen(albumId: album.id),
                      ));
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
                            child: album.imageUrl != null
                                ? Image.network(
                                    album.imageUrl!,
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
                                  album.name,
                                  style: const TextStyle(
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                    color: Colors.white,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
                                ),
                                Text(
                                  album.artists.join(', '),
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.white60,
                                  ),
                                  maxLines: 1,
                                  overflow: TextOverflow.ellipsis,
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
          return const Center(child: Text('No Albums Found'));
        }
      },
    );
  }
}
