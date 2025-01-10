import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:music_clone/models/album.dart';
import 'package:music_clone/models/artist.dart';
import 'package:music_clone/models/track.dart'; // Import the Track model

class SpotifyService {
  final String clientId = '352bf371f0504729ac018c8516f2636f';
  final String clientSecret = 'd17120c44de240538428537363f6d719';
  String? _accessToken;

  Future<String> _getAccessToken() async {
    if (_accessToken != null) return _accessToken!;

    final response = await http.post(
      Uri.parse('https://accounts.spotify.com/api/token'),
      headers: {
        'Authorization':
            'Basic ${base64Encode(utf8.encode('$clientId:$clientSecret'))}',
        'Content-Type': 'application/x-www-form-urlencoded',
      },
      body: {'grant_type': 'client_credentials'},
    );

    if (response.statusCode == 200) {
      final data = json.decode(response.body);
      _accessToken = data['access_token'];
      return _accessToken!;
    } else {
      throw Exception('Failed to get access token');
    }
  }

  Future<Album> getAlbum(String id) async {
    final token = await _getAccessToken();
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/albums/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Album.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load album');
    }
  }

  Future<Artist> getArtist(String id) async {
    final token = await _getAccessToken();
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/artists/$id'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      return Artist.fromJson(json.decode(response.body));
    } else {
      throw Exception('Failed to load artist');
    }
  }

  Future<Track> getTrack(String trackId) async {
    final token = await _getAccessToken();
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/tracks/$trackId'),
      headers: {
        'Authorization':
            'Bearer $token', // Use the token obtained from _getAccessToken
      },
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);
      return Track.fromJson(data);
    } else {
      throw Exception('Failed to get track data');
    }
  }

  Future<List<Track>> getTracksFromAlbum(String albumId) async {
    final token = await _getAccessToken();
    final response = await http.get(
      Uri.parse('https://api.spotify.com/v1/albums/$albumId/tracks'),
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> items = data['items'];
      return items.map((item) => Track.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load tracks from album');
    }
  }

  Future<List<Track>> getArtistTopTracks(String artistId) async {
    final token = await _getAccessToken();
    final response = await http.get(
      Uri.parse(
          'https://api.spotify.com/v1/artists/$artistId/top-tracks?market=US'), // You can change the market as needed
      headers: {'Authorization': 'Bearer $token'},
    );

    if (response.statusCode == 200) {
      final Map<String, dynamic> data = jsonDecode(response.body);
      final List<dynamic> items = data['tracks'];
      return items.map((item) => Track.fromJson(item)).toList();
    } else {
      throw Exception('Failed to load top tracks for artist');
    }
  }
}
