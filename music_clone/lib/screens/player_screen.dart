import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:marquee/marquee.dart';
import 'package:music_clone/models/track.dart';
import 'package:music_clone/service/spotify_service.dart';
import 'package:youtube_explode_dart/youtube_explode_dart.dart';

class PlayerScreen extends StatefulWidget {
  final Track track;
  final String? imageUrl;

  const PlayerScreen({Key? key, required this.track, this.imageUrl})
      : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool isLiked = false;
  final _player = AudioPlayer();
  final SpotifyService _spotifyService = SpotifyService(); // Dịch vụ Spotify
  String? _deviceId;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _player.dispose();
  }

  void initState() {
    super.initState();
    final track = widget.track;
    // Khởi tạo SpotifyService
    final spotifyService = SpotifyService();
    // Lấy thông tin track từ Spotify bằng trackId
    spotifyService.getTrack(widget.track.id).then((track) async {
      String tempSongName = track.name;
      if (tempSongName.isNotEmpty) {
        // Cập nhật thông tin bài hát
        String songName = track.name;
        String artistName = track.artists.isNotEmpty ? track.artists.first : "";
        String? songImage = track.imageUrl;
        String? artistImage =
            track.artists.isNotEmpty ? track.artists.first : null;
        // Tìm kiếm video trên YouTube với tên bài hát và nghệ sĩ
        final yt = YoutubeExplode();
        final video =
            (await yt.search.search("$tempSongName $artistName")).first;
        final videoId = video.id.value;
        // Lấy thời lượng video
        Duration? duration = video.duration;
        setState(() {});
        // Lấy manifest của video và stream audio
        var manifest = await yt.videos.streamsClient.getManifest(videoId);
        var audioUrl = manifest.audioOnly.last.url;
        // Phát nhạc
        _player.play(UrlSource(audioUrl.toString()));
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.of(context).pop(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30, vertical: 0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 50,
              ),
              Center(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(8),
                    image: DecorationImage(
                      image: NetworkImage(widget.imageUrl ?? ""),
                      fit: BoxFit.fill,
                    ),
                  ),
                  width: 350,
                  height: 350,
                ),
              ),
              const SizedBox(height: 70),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30, // Đảm bảo chiều cao cố định cho marquee
                          child: Marquee(
                            text: widget.track.name,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              fontWeight: FontWeight.bold,
                            ),
                            scrollAxis: Axis.horizontal,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            blankSpace: 50.0,
                            velocity: 30.0,
                            pauseAfterRound: const Duration(seconds: 1),
                            startPadding: 10.0,
                            accelerationDuration: const Duration(seconds: 1),
                            accelerationCurve: Curves.easeIn,
                            decelerationDuration:
                                const Duration(milliseconds: 500),
                            decelerationCurve: Curves.easeOut,
                          ),
                        ),
                        Text(
                          widget.track.artists.join(', '),
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 18,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 30,
                  ),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        isLiked = !isLiked;
                      });
                    },
                    child: Icon(
                      isLiked
                          ? CupertinoIcons.heart_fill
                          : CupertinoIcons.heart,
                      color: isLiked ? Color(0xFF1DB954) : Colors.white54,
                      size: 40,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),
              StreamBuilder(
                  stream: _player.onPositionChanged,
                  builder: (context, data) {
                    return ProgressBar(
                      progress: data.data ?? const Duration(seconds: 0),
                      total: Duration(milliseconds: widget.track.duration ?? 0),
                      bufferedBarColor: Colors.white30,
                      baseBarColor: Colors.white30,
                      thumbColor: Colors.white,
                      timeLabelTextStyle: const TextStyle(color: Colors.white),
                      progressBarColor: Colors.white,
                      onSeek: (duration) {
                        _player.seek(duration);
                      },
                    );
                  }),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.shuffle_medium,
                        color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_previous,
                      color: Colors.white,
                      size: 50,
                    ),
                  ),
                  IconButton(
                      onPressed: () async {
                        if (_player.state == PlayerState.playing) {
                          await _player.pause();
                        } else {
                          await _player.resume();
                        }
                        setState(() {});
                      },
                      icon: Icon(
                        _player.state == PlayerState.playing
                            ? Icons.pause_circle
                            : Icons.play_circle,
                        color: Color(0xFF1DB954),
                        size: 70,
                      )),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.skip_next,
                      color: Colors.white,
                      size: 60,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(
                      Icons.repeat_one_outlined,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.list, color: Colors.white),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: const Icon(CupertinoIcons.share, color: Colors.white),
                  ),
                ],
              ),
              const SizedBox(height: 16),
            ],
          ),
        ),
      ),
    );
  }
}
