import 'package:anxicode_app/Models/user_info.dart';
import 'package:anxicode_app/Services/supabase_db.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SupabaseAuthService _db = SupabaseAuthService();
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _nameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            iconTheme: const IconThemeData(color: Colors.white),
            leading: IconButton(
              onPressed: () {
                context.go('/login');
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Form(
                key: _formKey,
                child: Column(
                  children: [
                    const SizedBox(height: 20),

                    SizedBox(
                      height: 200,
                      child: Image.asset(
                        "assets/images/anxicode.png",
                        fit: BoxFit.contain,
                      ),
                    ),

                    const SizedBox(height: 20),

                    _inputField(_nameController, type: 'Name'),
                    const SizedBox(height: 15),

                    _inputField(_userNameController, type: 'User Name'),
                    const SizedBox(height: 15),

                    _inputField(_emailController, type: 'Email'),
                    const SizedBox(height: 15),

                    _inputField(_passwordController, type: 'Password'),
                    const SizedBox(height: 15),

                    _inputField(
                      _confirmPasswordController,
                      type: 'Confirm Password',
                    ),

                    const SizedBox(height: 30),

                    Container(
                      width: double.infinity,
                      decoration: BoxDecoration(
                        gradient: const LinearGradient(
                          colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
                        ),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: ElevatedButton(
                        onPressed: _registerUser,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.transparent,
                          shadowColor: Colors.transparent,
                          padding: const EdgeInsets.symmetric(vertical: 15),
                        ),
                        child: const Text(
                          "REGISTER",
                          style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  Future<void> _registerUser() async {
    if (!_formKey.currentState!.validate()) return;

    if (_passwordController.text != _confirmPasswordController.text) {
      _showSnackBar(
        title: 'Error',
        message: 'Passwords do not match',
        contentType: ContentType.failure,
      );
      return;
    }

    try {
      final user = UserInfo(
        name: _nameController.text.trim(),
        userName: _userNameController.text.trim(),
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      await _db.registerUser(userInfo: user);

      if (!mounted) return;

      _showSnackBar(
        title: 'Success',
        message: 'Registration successful',
        contentType: ContentType.success,
      );

      context.go('/');
    } on AuthException catch (e) {
      if (!mounted) return;

      _showSnackBar(
        title: 'Auth Error',
        message: e.message,
        contentType: ContentType.failure,
      );
    } catch (e) {
      if (!mounted) return;

      _showSnackBar(
        title: 'Error',
        message: 'Something went wrong',
        contentType: ContentType.failure,
      );
    }
  }

  void _showSnackBar({
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 3),
      content: AwesomeSnackbarContent(
        title: title,
        message: message,
        contentType: contentType,
        color: Colors.cyan,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  TextFormField _inputField(
    TextEditingController controller, {
    String type = 'text',
  }) {
    return TextFormField(
      controller: controller,
      obscureText: type.toLowerCase().contains("password"),
      keyboardType:
          type == "Email" ? TextInputType.emailAddress : TextInputType.text,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        hintText: "Enter your $type",
        filled: true,
        fillColor: const Color(0xFF1B1B3A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
      ),
      validator: (value) => validate(value: value ?? '', type: type),
    );
  }

  String? validate({required String value, required String type}) {
    final v = value.trim();

    // NAME
    if (type == 'Name') {
      if (v.isEmpty) return "Name is required";
      if (v.length < 3) return "Name must be at least 3 characters";
    }

    // USERNAME
    if (type == 'User Name') {
      if (v.isEmpty) return 'Username is required';
      if (v.length < 3) return 'Username must be at least 3 characters';
      if (v.contains(' ')) return 'Username cannot contain spaces';

      if (!RegExp(r'^[a-zA-Z0-9_]+$').hasMatch(v)) {
        return 'Only letters, numbers and underscore allowed';
      }
    }

    // EMAIL
    if (type == 'Email') {
      if (v.isEmpty) return 'Email is required';

      if (!RegExp(r'^[^@]+@[^@]+\.[^@]+').hasMatch(v)) {
        return 'Enter a valid email';
      }
    }

    // PASSWORD
    if (type == 'Password') {
      if (v.isEmpty) return 'Password is required';
      if (v.length < 6) {
        return 'Password must be at least 6 characters';
      }
    }

    return null;
  }
}
