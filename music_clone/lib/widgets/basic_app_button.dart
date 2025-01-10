import 'package:flutter/material.dart';

class BasicAppButton extends StatelessWidget {
  final String title;
  final double height;
  final VoidCallback onPressed;
  const BasicAppButton(
      {super.key,
      required this.title,
      required this.onPressed,
      required this.height});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width - 100,
      height: height,
      child: ElevatedButton(
        onPressed: onPressed,
        child: Text(
          title,
          style: TextStyle(
              fontSize: 22, color: Colors.white, fontWeight: FontWeight.bold),
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: Color(0xFF1DB954),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(22),
          ),
        ),
      ),
    );
  }
}
