import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String imageUrl;
  final String title;

  const CategoryCard({
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

class CategoryGrid extends StatelessWidget {
  const CategoryGrid({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 250,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: const [
          CategoryCard(
            imageUrl:
                'https://afamilycdn.com/150157425591193600/2024/11/25/chrome-capture-2024-11-25-1732503556552-1732503556799584310359.gif',
            title: '#mtp',
          ),
          SizedBox(width: 12),
          CategoryCard(
            imageUrl:
                'https://phunuso.mediacdn.vn/thumb_w/660/603486343963435008/2024/12/10/videochuaattenuoctaobangclipchamp83-ezgifcom-video-to-gif-converter-17338079719781257715961.gif',
            title: '#hieuthuhai',
          ),
          SizedBox(width: 12),
          CategoryCard(
            imageUrl:
                'https://media1.giphy.com/media/v1.Y2lkPTc5MGI3NjExbXh3OTU2cDFvemtxb3JpOTNjNzFieWIya20zMmh4dWE1cjgwbmhrciZlcD12MV9pbnRlcm5hbF9naWZfYnlfaWQmY3Q9Zw/e6RKl5gof6gTK/giphy.webp',
            title: '#rap',
          ),
        ],
      ),
    );
  }
}
