import 'package:flutter/material.dart';
import 'package:music_clone/screens/results_screen.dart';
import 'package:music_clone/widgets/widget_basic/browse_card.dart';
import 'package:music_clone/widgets/widget_basic/category_card.dart';
import 'package:music_clone/widgets/widget_basic/search_box.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  void _onSearch(String query) {
    if (query.isNotEmpty) {
      // Chuyển đến màn hình kết quả tìm kiếm khi có từ khóa
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => ResultsScreen(query: query),
        ),
      );
    }
  }

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
              SearchBox(
                onSearch: _onSearch,
              ),
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
              const CategoryGrid(),
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
              const BrowseGrid(),
            ],
          ),
        ),
      ),
    );
  }
}
