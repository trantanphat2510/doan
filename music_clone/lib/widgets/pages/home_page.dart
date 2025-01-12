import 'package:flutter/material.dart';
import 'package:music_clone/widgets/spotify_list/spotify_album.dart';
import 'package:music_clone/widgets/spotify_list/spotify_artist.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    const albumIds = [
      '2UZre9rniPNke0bwRs1SMf',
      '03ZYR4zwCrkSsXTROnK2d0',
      '4faMbTZifuYsBllYHZsFKJ',
      '1AaxmI2e1HRhbwe9XJGPnT',
      '7kFyd5oyJdVX2pIi6P4iHE',
      '5pSk3c3wVwnb2arb6ohCPU',
      '1wmnEWgcDdCcOujQpLwYxc',
    ];
    const albumhotIds = [
      '3jQb4fnTYtHAP90TNLaj3y',
      '19nGMLMd8gjMQwgh2aYmsx',
      '1UcLMdWtu9nmgZfDRNtdan',
      '1c4nTHI2hreFeF5P37wf4f',
      '0gkv4yJzOP4UG19rm8lumW',
      '10FLjwfpbxLmW8c25Xyc2N',
    ];
    const artistIds = [
      '5dfZ5uSmzR7VQK0udbAVpf',
      '57g2v7gJZepcwsuwssIfZs',
      '0ZbgKh0FgPYeFP38nVaEGp',
      '4KPyQxL1zqEiBcTwW6c9HE',
      '3Wj34lTDJnPp70u4YCl4jz',
      '6CGGvCBHWqQ4HXtn5aLhbh',
      '3JWIaDWHJq11w1xPqJStEv',
    ];

    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              "Gần đây",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 26,
              ),
            ),
            SpotifyAlbumList(albumIds: albumIds),
            const SizedBox(height: 20),
            const Text(
              "Nghệ sĩ",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 26,
              ),
            ),
            SpotifyArtistList(artistIds: artistIds),
            const SizedBox(height: 20),
            const Text(
              "Album và đĩa đơn nổi tiếng",
              style: TextStyle(
                fontWeight: FontWeight.bold,
                color: Colors.white,
                fontSize: 26,
              ),
            ),
            SpotifyAlbumList(albumIds: albumhotIds),
          ],
        ),
      ),
    );
  }
}
