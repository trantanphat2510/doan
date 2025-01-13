import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; // Add this import

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseFirestore _firestore =
      FirebaseFirestore.instance; // Add this line

  Future<User?> signUpWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.createUserWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Lỗi khi đăng ký: $e");
    }
    return null;
  }

  Future<User?> signInWithEmailAndPassword(
      String email, String password) async {
    try {
      UserCredential credential = await _auth.signInWithEmailAndPassword(
          email: email, password: password);
      return credential.user;
    } catch (e) {
      print("Lỗi khi đăng nhập: $e");
    }
    return null;
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } catch (e) {
      print("Error signing out: $e");
    }
  }

  Future<void> updateUserProfile({
    required String displayName,
    String? phoneNumber, // Nếu cần lưu thông tin số điện thoại
  }) async {
    User? user = _auth.currentUser;

    if (user != null) {
      await user.updateDisplayName(displayName);
      // Nếu cần thêm các logic cập nhật khác, xử lý tại đây.
      await user.reload(); // Tải lại thông tin người dùng
    } else {
      throw Exception("No user is signed in");
    }
  }
}
