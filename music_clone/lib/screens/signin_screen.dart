import 'package:flutter/material.dart';
import 'package:music_clone/screens/home_screen.dart';
import 'package:music_clone/screens/signup_screen.dart';
import 'package:music_clone/widgets/app_bar.dart';
import 'package:music_clone/widgets/basic_app_button.dart';
import 'package:music_clone/widgets/text_field.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SigninScreen extends StatefulWidget {
  const SigninScreen({super.key});

  @override
  State<SigninScreen> createState() => _SigninScreenState();
}

class _SigninScreenState extends State<SigninScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  // Hàm hiển thị thông báo lỗi hoặc thành công
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Hàm xử lý đăng nhập
  void _signIn() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    // Kiểm tra xem email và mật khẩu có trống không
    if (email.isEmpty || password.isEmpty) {
      _showError("Vui lòng điền đầy đủ thông tin!");
      return;
    }

    try {
      // Thực hiện đăng nhập
      UserCredential userCredential = await _auth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Kiểm tra nếu đăng nhập thành công
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Đăng nhập thành công!")), // Thông báo thành công
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const HomeScreen()), // Chuyển đến màn hình chính
        );
      } else {
        _showError("Đăng nhập thất bại. Vui lòng thử lại.");
      }
    } catch (e) {
      _showError("Lỗi khi đăng nhập: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      bottomNavigationBar: _signText(context),
      appBar: BasicAppBar(),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 30),
          child: Center(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset("assets/spotify_logo.png", width: 100, height: 100),
                const Text(
                  "Hàng triệu bài hát.",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const Text(
                  "Miễn phí trên Spotify.",
                  style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Colors.white),
                ),
                const SizedBox(height: 30),
                TextFieldInput(controller: _emailController, hintText: "Email"),
                const SizedBox(height: 10),
                TextFieldInput(
                    controller: _passwordController,
                    hintText: "Mật khẩu",
                    isPassword: true),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 0, vertical: 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      TextButton(
                        onPressed: () {},
                        child: const Text("Quên mật khẩu?",
                            style: TextStyle(color: Colors.grey)),
                      ),
                    ],
                  ),
                ),
                BasicAppButton(
                  height: 50,
                  title: "Đăng nhập",
                  onPressed: _signIn, // Xử lý đăng nhập khi nhấn nút
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // Widget này dùng để hiển thị thông tin chuyển đến màn hình đăng ký
  Widget _signText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 30),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text("Bạn không có tài khoản?",
              style: TextStyle(color: Colors.white)),
          TextButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SignupScreen()),
              );
            },
            child: const Text(
              "Đăng ký",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF1DB954)),
            ),
          ),
        ],
      ),
    );
  }
}
