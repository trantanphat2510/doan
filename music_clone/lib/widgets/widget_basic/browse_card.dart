import 'package:flutter/material.dart';

class BrowseCard extends StatelessWidget {
  final String title;
  final Color color;

  const BrowseCard({
    required this.title,
    required this.color,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class BrowseGrid extends StatelessWidget {
  const BrowseGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2 / 1,
      children: const [
        BrowseCard(
          title: 'Nhạc',
          color: Color(0xFF29794F),
        ),
        BrowseCard(
          title: 'Podcasts',
          color: Color(0xFF29794F),
        ),
        BrowseCard(
          title: 'Sự kiện trực tiếp',
          color: Color(0xFF9D47DC),
        ),
        BrowseCard(
          title: 'Nhạc trong năm\n2024',
          color: Color(0xFF196073),
        ),
        BrowseCard(
          title: 'Dành cho bạn',
          color: Color.fromARGB(255, 23, 140, 194),
        ),
        BrowseCard(
          title: 'Mới phát hành',
          color: Color.fromARGB(255, 180, 52, 52),
        ),
        BrowseCard(
          title: 'Pop',
          color: Color.fromARGB(255, 141, 112, 161),
        ),
        BrowseCard(
          title: 'K-Pop',
          color: Color.fromARGB(255, 29, 87, 68),
        ),
      ],
    );
  }
}
