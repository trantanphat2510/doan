import 'package:flutter/material.dart';
import 'package:music_clone/screens/signin_or_signup.dart';
import 'package:music_clone/screens/signin_screen.dart';
import 'package:music_clone/widgets/basic_app_button.dart';

class GetstartedScreen extends StatelessWidget {
  const GetstartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background image with gradient overlay
          Container(
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage("assets/background_getstarted.png"),
              ),
            ),
            child: Container(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.3),
                  ],
                  begin: Alignment.bottomCenter,
                  end: Alignment.topCenter,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 0),
            child: Column(
              children: [
                // Logo
                Align(
                  alignment: Alignment.topCenter,
                  child: Image.asset(
                    "assets/logo_chu.png",
                    width: 180,
                    height: 180,
                  ),
                ),
                const Spacer(),
                // Title
                const Text(
                  'Thưởng thức nghe nhạc',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 26,
                    letterSpacing: 1.2,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 16),
                // Description
                const Text(
                  'Hãy tận hưởng từng khoảnh khắc, tập trung vào công việc và chấp nhận những niềm đau để đạt được điều tốt đẹp.',
                  style: TextStyle(
                    fontWeight: FontWeight.w400,
                    color: Color.fromARGB(255, 207, 201, 201),
                    fontSize: 14,
                  ),
                  textAlign: TextAlign.center,
                ),
                const SizedBox(height: 20),
                // Button
                BasicAppButton(
                    height: 80,
                    title: "Bắt đầu",
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (BuildContext context) =>
                                  SigninOrSignup()));
                    }),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
