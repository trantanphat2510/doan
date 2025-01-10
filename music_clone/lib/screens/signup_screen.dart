import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:music_clone/screens/home_screen.dart';
import 'package:music_clone/screens/signin_screen.dart';
import 'package:music_clone/widgets/app_bar.dart';
import 'package:music_clone/widgets/basic_app_button.dart';
import 'package:music_clone/widgets/text_field.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  TextEditingController _usernameController = TextEditingController();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();
  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  // Hàm hiển thị thông báo lỗi hoặc thành công
  void _showError(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  // Kiểm tra xem email có hợp lệ không
  bool _isValidEmail(String email) {
    final RegExp regex = RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
    return regex.hasMatch(email);
  }

  // Hàm xử lý đăng ký
  void _signUp() async {
    String username = _usernameController.text.trim();
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();
    String confirmPassword = _confirmPasswordController.text.trim();

    if (username.isEmpty || email.isEmpty || password.isEmpty) {
      _showError("Vui lòng điền đầy đủ thông tin!");
      return;
    }

    if (!_isValidEmail(email)) {
      _showError("Email không hợp lệ!");
      return;
    }

    if (password != confirmPassword) {
      _showError("Mật khẩu không khớp!");
      return;
    }

    try {
      // Thực hiện đăng ký
      UserCredential userCredential =
          await _auth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );

      User? user = userCredential.user;

      // Kiểm tra nếu đăng ký thành công
      if (user != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content: Text("Đăng ký thành công!")), // Thông báo thành công
        );
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) =>
                  const HomeScreen()), // Chuyển đến màn hình chính
        );
      } else {
        _showError("Đăng ký thất bại. Vui lòng thử lại.");
      }
    } catch (e) {
      _showError("Lỗi khi đăng ký: $e");
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
          padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 40),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Image.asset("assets/logo_chu.png", width: 200, height: 200),
              TextFieldInput(
                  controller: _usernameController, hintText: "Họ và tên"),
              const SizedBox(height: 10),
              TextFieldInput(controller: _emailController, hintText: "Email"),
              const SizedBox(height: 10),
              TextFieldInput(
                  controller: _passwordController,
                  hintText: "Mật khẩu",
                  isPassword: true),
              const SizedBox(height: 10),
              TextFieldInput(
                  controller: _confirmPasswordController,
                  hintText: "Nhập lại mật khẩu",
                  isPassword: true),
              const SizedBox(height: 20),
              BasicAppButton(
                height: 50,
                title: "Đăng ký",
                onPressed: _signUp, // Xử lý đăng ký khi nhấn nút
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Widget này dùng để hiển thị thông tin chuyển đến màn hình đăng nhập
  Widget _signText(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            "Bạn đã có tài khoản?",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
          ),
          TextButton(
            onPressed: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                    builder: (BuildContext context) => const SigninScreen()),
              );
            },
            child: const Text(
              "Đăng nhập",
              style: TextStyle(
                  fontWeight: FontWeight.bold, color: Color(0xFF1DB954)),
            ),
          ),
        ],
      ),
    );
  }
}
