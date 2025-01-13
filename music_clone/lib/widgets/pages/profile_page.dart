import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import FirebaseAuth
import 'package:music_clone/service/auth_service.dart';
import 'package:music_clone/widgets/pages/edit_profile.dart';
import 'package:music_clone/widgets/widget_basic/basic_app_button.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  _ProfilePageState createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  User? _user;
  String? _email;
  String? _displayName;
  bool _loading = true; // Add a loading state
  final AuthService _authService = AuthService();

  @override
  void initState() {
    super.initState();
    _loadUserData();
  }

  Future<void> _loadUserData() async {
    setState(() {
      _loading = true;
    });
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        setState(() {
          _user = user;
          _email = user.email;
          _displayName = user.displayName;
        });
      } else {
        // Handle the case where the user is not logged in.
        print("User not logged in");
      }
    } catch (e) {
      print("Error loading user data: $e");
    } finally {
      setState(() {
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? const Center(child: CircularProgressIndicator())
        : Container(
            child: Center(
              child: Column(
                children: [
                  const SizedBox(height: 20),
                  const CircleAvatar(
                    radius: 60,
                    backgroundImage: AssetImage('assets/spotify_logo.png'),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    _displayName ?? 'No Display Name',
                    style: const TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  Text(
                    _email ?? 'No Email', // Use the fetched email
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 24),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => EditProfile()));
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white70,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 40, vertical: 12),
                    ),
                    child: const Text(
                      'Chỉnh sửa hồ sơ',
                      style: TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 350,
                  ),
                  BasicAppButton(
                    title: "Đăng xuất",
                    onPressed: () async {
                      await _authService.signOut();
                      Navigator.of(context).pop();
                    },
                    height: 50,
                  )
                ],
              ),
            ),
          );
  }
}
