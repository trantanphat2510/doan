import 'package:flutter/material.dart';
import 'package:music_clone/service/auth_service.dart';
import 'package:music_clone/widgets/widget_basic/text_field.dart';

class EditProfile extends StatefulWidget {
  final String? initialName;
  final String? initialPhone;
  final String? initialEmail;

  const EditProfile(
      {Key? key, this.initialName, this.initialPhone, this.initialEmail})
      : super(key: key);

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<EditProfile> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late TextEditingController _phoneController;
  late TextEditingController _emailController;
  final AuthService _authService = AuthService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _nameController = TextEditingController(text: widget.initialName);
    _phoneController = TextEditingController(text: widget.initialPhone);
    _emailController = TextEditingController(text: widget.initialEmail);
  }

  @override
  void dispose() {
    _nameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        iconTheme: const IconThemeData(color: Colors.white),
      ),
      body: _isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      TextFieldInput(
                        controller: _nameController,
                        hintText: 'Display Name',
                      ),
                      const SizedBox(height: 16),
                      TextFieldInput(
                        controller: _emailController,
                        hintText: 'Email',
                      ),
                      const SizedBox(height: 16),
                      TextFieldInput(
                        controller: _phoneController,
                        hintText: 'Phone Number',
                      ),
                      const SizedBox(height: 24),
                      ElevatedButton(
                        onPressed: (){},
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.amber,
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        child: const Text(
                          'Save Changes',
                          style: TextStyle(fontSize: 16, color: Colors.black),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
    );
  }
}
