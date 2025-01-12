import 'package:flutter/material.dart';
import 'package:music_clone/screens/signin_screen.dart';
import 'package:music_clone/screens/signup_screen.dart';
import 'package:music_clone/widgets/widget_basic/app_bar.dart';
import 'package:music_clone/widgets/widget_basic/basic_app_button.dart';

class SigninOrSignup extends StatelessWidget {
  const SigninOrSignup({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Align(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(width: 180, height: 180, "assets/logo_chu.png"),
              const Text(
                "Thưởng thức âm nhạc",
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 26,
                    color: Colors.white),
              ),
              const SizedBox(
                height: 10,
              ),
              const Text(
                "Spotify là nền tảng phát trực tuyến âm nhạc nổi tiếng, cung cấp trải nghiệm nghe nhạc đa dạng và chất lượng cao toàn cầu.",
                style: TextStyle(
                  fontWeight: FontWeight.w500,
                  color: Color.fromARGB(255, 207, 201, 201),
                  fontSize: 14,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(
                height: 70,
              ),
              Row(
                children: [
                  Expanded(
                    flex: 1,
                    child: BasicAppButton(
                        height: 70,
                        title: "Đăng nhập",
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (BuildContext context) => SigninScreen(),
                            ),
                          );
                        }),
                  ),
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                    flex: 1,
                    child: TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) => SignupScreen(),
                          ),
                        );
                      },
                      child: Text(
                        "Đăng ký",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 20,
                            color: Colors.white),
                      ),
                    ),
                  )
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
