import 'package:flutter/material.dart';

class FavoritePage extends StatelessWidget {
  const FavoritePage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: ListView(
        children: const [
          ListTile(
            leading: CircleAvatar(
              backgroundColor: Colors.purpleAccent,
              child: Icon(
                Icons.favorite,
                color: Colors.white,
                size: 30,
              ),
            ),
            title: Text(
              'Bài hát ưa thích',
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white),
            ),
            subtitle: Text(
              'Danh sách phát • 0 bài hát',
              style: TextStyle(color: Colors.white60),
            ),
          ),
        ],
      ),
    );
  }
}
