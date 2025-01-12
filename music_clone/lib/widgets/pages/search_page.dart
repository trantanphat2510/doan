import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildSearchBox(),
              const SizedBox(height: 24),
              const Text(
                'Khám phá nội dung mới mẻ',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildCategoryGrid(),
              const SizedBox(height: 24),
              const Text(
                'Duyệt tìm tất cả',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 16),
              _buildBrowseGrid(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSearchBox() {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: const Padding(
        padding: EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        child: Row(
          children: [
            Icon(Icons.search, color: Colors.black54),
            SizedBox(width: 8),
            Text(
              'Bạn muốn nghe gì?',
              style: TextStyle(color: Colors.black54),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCategoryGrid() {
    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          _CategoryCard(
            imageUrl:
                'https://afamilycdn.com/150157425591193600/2024/11/25/chrome-capture-2024-11-25-1732503556552-1732503556799584310359.gif',
            title: '#mtp',
          ),
          SizedBox(width: 12),
          _CategoryCard(
            imageUrl:
                'https://phunuso.mediacdn.vn/thumb_w/660/603486343963435008/2024/12/10/videochuaattenuoctaobangclipchamp83-ezgifcom-video-to-gif-converter-17338079719781257715961.gif',
            title: '#hieuthuhai',
          ),
          SizedBox(width: 12),
          _CategoryCard(
            imageUrl:
                'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXh3OTU2cDFvemtxb3JpOTNjNzFieWIya20zMmh4dWE1cjgwbmhrciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/e6RKl5gof6gTK/giphy.webp',
            title: '#rap',
          ),
        ],
      ),
    );
  }

  Widget _buildBrowseGrid() {
    return GridView.count(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      crossAxisCount: 2,
      crossAxisSpacing: 16,
      mainAxisSpacing: 16,
      childAspectRatio: 2 / 1,
      children: const [
        _BrowseCard(
          title: 'Nhạc',
          color: Color(0xFF29794F),
        ),
        _BrowseCard(
          title: 'Podcasts',
          color: Color(0xFF29794F),
        ),
        _BrowseCard(
          title: 'Sự kiện trực tiếp',
          color: Color(0xFF9D47DC),
        ),
        _BrowseCard(
          title: 'Nhạc trong năm\n2024',
          color: Color(0xFF196073),
        ),
        _BrowseCard(
          title: 'Dành cho bạn',
          color: Color.fromARGB(255, 23, 140, 194),
        ),
        _BrowseCard(
          title: 'Mới phát hành',
          color: Color.fromARGB(255, 180, 52, 52),
        ),
        _BrowseCard(
          title: 'Pop',
          color: Color.fromARGB(255, 141, 112, 161),
        ),
        _BrowseCard(
          title: 'K-Pop',
          color: Color.fromARGB(255, 29, 87, 68),
        ),
      ],
    );
  }
}

class _CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const _CategoryCard({
    required this.imageUrl,
    required this.title,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 130,
      child: Stack(
        alignment: Alignment.bottomLeft,
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(8.0),
            child: Image.network(
              imageUrl,
              fit: BoxFit.cover,
              width: double.infinity,
              height: double.infinity,
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _BrowseCard extends StatelessWidget {
  final String title;

  final Color color;

  const _BrowseCard({
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
