import 'package:flutter/material.dart';
import 'package:music_clone/models/track.dart';

class PlayerScreen extends StatefulWidget {
  final Track track;
  final String? imageUrl;

  const PlayerScreen({Key? key, required this.track, this.imageUrl})
      : super(key: key);

  @override
  _PlayerScreenState createState() => _PlayerScreenState();
}

class _PlayerScreenState extends State<PlayerScreen> {
  bool _isPlaying = false;

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
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(8),
                  image: DecorationImage(
                      image: NetworkImage(widget.imageUrl ?? ""),
                      fit: BoxFit.cover)),
              width: double.infinity,
              height: 300,
            ),
            const SizedBox(height: 20),
            Text(
              widget.track.name,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              widget.track.artists.join(', '),
              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),
            const Spacer(),
            Slider(
              value: 0.3, // Mock value for slider
              onChanged: (value) {},
              activeColor: Colors.white,
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text(
                  "0:04",
                  style: TextStyle(color: Colors.white70),
                ),
                Text("-3:16", style: TextStyle(color: Colors.white70))
              ],
            ),
            const SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.shuffle, color: Colors.white)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_previous, color: Colors.white)),
                IconButton(
                  icon: Icon(
                    _isPlaying ? Icons.pause_circle : Icons.play_circle,
                    size: 60,
                    color: Colors.white,
                  ),
                  onPressed: () {
                    setState(() {
                      _isPlaying = !_isPlaying;
                    });
                  },
                ),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.skip_next, color: Colors.white)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.access_time, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.list, color: Colors.white)),
                IconButton(
                    onPressed: () {},
                    icon: const Icon(Icons.share, color: Colors.white)),
              ],
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
