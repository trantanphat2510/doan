import 'package:flutter/material.dart';

class SearchBox extends StatefulWidget {
  final Function(String) onSearch;

  const SearchBox({Key? key, required this.onSearch}) : super(key: key);

  @override
  State<SearchBox> createState() => _SearchBoxState();
}

class _SearchBoxState extends State<SearchBox> {
  TextEditingController _controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        widget
            .onSearch(_controller.text); // Truyền từ khóa tìm kiếm vào callback
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8.0),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
          child: Row(
            children: [
              Icon(Icons.search, color: Colors.black54),
              SizedBox(width: 8),
              Expanded(
                child: TextField(
                  controller: _controller,
                  decoration: const InputDecoration(
                    hintText: 'Bạn muốn nghe gì?',
                    hintStyle: TextStyle(color: Colors.black54),
                    border: InputBorder.none,
                  ),
                  style: const TextStyle(color: Colors.black54),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
