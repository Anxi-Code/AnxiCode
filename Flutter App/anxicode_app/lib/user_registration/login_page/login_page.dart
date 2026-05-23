import 'package:anxicode_app/Services/supabase_db.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final SupabaseAuthService _db = SupabaseAuthService();

  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _isLoading = false;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
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
          ),

          body: Stack(
            children: [
              SingleChildScrollView(
                child: Padding(
                  padding: const EdgeInsets.all(15),

                  child: Form(
                    key: _formKey,

                    child: Column(
                      children: [
                        const SizedBox(height: 30),

                        SizedBox(
                          height: 200,
                          width: 300,
                          child: Image.asset(
                            "assets/images/anxicode.png",
                            fit: BoxFit.contain,
                          ),
                        ),

                        const SizedBox(height: 20),

                        _inputField(_emailController, type: 'Email'),

                        const SizedBox(height: 20),

                        _inputField(_passwordController, type: 'Password'),

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
                            onPressed: _isLoading ? null : _loginUser,

                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent,
                              padding: const EdgeInsets.symmetric(vertical: 15),
                            ),

                            child: const Text(
                              "LOGIN",

                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,

                          children: [
                            const Text(
                              "Not registered? ",

                              style: TextStyle(color: Colors.white70),
                            ),

                            GestureDetector(
                              onTap: () => context.go('/signup'),

                              child: const Text(
                                "Sign Up",

                                style: TextStyle(
                                  color: Colors.cyanAccent,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),

              if (_isLoading)
                Container(
                  color: Colors.black.withValues(alpha: 0.2),

                  child: Center(
                    child: SpinKitChasingDots(
                      color: Colors.cyanAccent.withValues(alpha: 0.3),
                      size: 60,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ],
    );
  }

  Future<void> _loginUser() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() {
      _isLoading = true;
    });

    try {
      await _db.loginUser(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      final session = Supabase.instance.client.auth.currentSession;

      if (session != null) {
        _emailController.clear();
        _passwordController.clear();

        if (!mounted) return;

        context.go('/');
      }
    } on AuthException catch (e) {
      if (!mounted) return;

      _showSnackBar(
        title: 'Login Failed',
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
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  void _showSnackBar({
    required String title,
    required String message,
    required ContentType contentType,
  }) {
    final snackBar = SnackBar(
      elevation: 0,
      backgroundColor: Colors.transparent,
      behavior: SnackBarBehavior.floating,

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

      obscureText: type == "Password",

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
