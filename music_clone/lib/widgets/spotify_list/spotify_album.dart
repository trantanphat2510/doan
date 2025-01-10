import 'package:flutter/material.dart';
import 'package:music_clone/models/album.dart';
import 'package:music_clone/service/spotify_service.dart';
import 'package:music_clone/screens/album_details_screen.dart';

class SpotifyAlbumList extends StatelessWidget {
  const SpotifyAlbumList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Khởi tạo một instance của SpotifyService để gọi API
    final SpotifyService spotifyService = SpotifyService();

    return FutureBuilder<List<Album>>(
      // Future.wait được sử dụng để gọi nhiều API song song, ở đây là lấy thông tin của hai album.
      future: Future.wait([
        spotifyService.getAlbum('2UZre9rniPNke0bwRs1SMf'),
        spotifyService.getAlbum('03ZYR4zwCrkSsXTROnK2d0'),
        spotifyService.getAlbum('4faMbTZifuYsBllYHZsFKJ'),
        spotifyService.getAlbum('1AaxmI2e1HRhbwe9XJGPnT'),
      ]),
      builder: (context, snapshot) {
        // Kiểm tra trạng thái kết nối
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Hiển thị loading indicator trong lúc chờ dữ liệu trả về
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Hiển thị thông báo lỗi nếu có
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (snapshot.hasData) {
          // Nếu có dữ liệu, hiển thị danh sách album
          return SizedBox(
            height: 270, // Chiều cao của ListView
            child: ListView.builder(
              scrollDirection: Axis.horizontal, // Hiển thị theo chiều ngang
              itemCount: snapshot.data!.length, // Số lượng album
              itemBuilder: (context, index) {
                final album = snapshot.data![index]; // Lấy album tại index
                return SizedBox(
                  width: 210, // Chiều rộng của mỗi card album
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
                          borderRadius:
                              BorderRadius.circular(10.0), // Độ cong của card
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              child: album.imageUrl != null
                                  ? Image.network(
                                      album.imageUrl!, // Hiển thị ảnh album
                                      fit:
                                          BoxFit.cover, // Ảnh vừa với container
                                      width: double.infinity,
                                    )
                                  : Container(
                                      color: Colors
                                          .grey), // Placeholder nếu không có ảnh
                            ),
                            Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        album.name, // Tên album
                                        style: const TextStyle(
                                          fontWeight: FontWeight.bold,
                                          fontSize: 18,
                                          color: Colors.white,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      Text(
                                        album.artists.join(', '), // Tên nghệ sĩ
                                        style: const TextStyle(
                                          fontSize: 14,
                                          color: Colors.white60,
                                        ),
                                        maxLines: 1,
                                        overflow: TextOverflow
                                            .ellipsis, // Để tránh tràn chữ
                                      ),
                                    ])),
                          ],
                        ),
                      )),
                );
              },
            ),
          );
        } else {
          // Hiển thị thông báo nếu không tìm thấy album nào
          return const Center(child: Text('No Albums Found'));
        }
      },
    );
  }
}
