import 'package:flutter/material.dart';
import 'package:music_clone/models/track.dart';
import 'package:music_clone/screens/player_screen.dart';
import 'package:music_clone/service/spotify_service.dart';

class ResultsScreen extends StatefulWidget {
  final String query;
  ResultsScreen({required this.query});

  @override
  _ResultsScreenState createState() => _ResultsScreenState();
}

class _ResultsScreenState extends State<ResultsScreen> {
  List<Track> _searchResults = [];

  @override
  void initState() {
    super.initState();
    _performSearch(widget.query);
  }

  // Gọi SpotifyService để lấy kết quả tìm kiếm
  Future<void> _performSearch(String query) async {
    try {
      final spotifyService = SpotifyService();
      final results = await spotifyService.searchTracks(query);
      setState(() {
        _searchResults = results.map((e) => Track.fromJson(e)).toList();
      });
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Lỗi khi tìm kiếm: $e'),
      ));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: IconThemeData(color: Colors.white),
      ),
      body: _searchResults.isEmpty
          ? Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final track = _searchResults[index];
                return ListTile(
                  title: Text(
                    track.name,
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 19,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  subtitle: Text(
                    track.artists.join(', '),
                    style: TextStyle(
                      color: Colors.white70,
                      fontSize: 16,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  leading: track.imageUrl != null
                      ? Image.network(track.imageUrl!)
                      : Container(),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => PlayerScreen(
                          track: track,
                          imageUrl: track.imageUrl,
                        ),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}
