import 'package:anxicode_app/Services/supabase_db.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
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
          body: SingleChildScrollView(
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
                        onPressed: () async {
                          if (!_formKey.currentState!.validate()) return;

                          try {
                            await _db.loginUser(
                              email: _emailController.text.trim(),
                              password: _passwordController.text.trim(),
                            );

                            final session =
                                Supabase.instance.client.auth.currentSession;

                            if (session != null) {
                              _emailController.clear();
                              _passwordController.clear();
                              context.go('/home');
                            }
                          } on AuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message)),
                            );
                          }
                        },
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
        ),
      ],
    );
  }

  TextFormField _inputField(
      TextEditingController controller, {
        String type = 'text',
      }) {
    return TextFormField(
      controller: controller,
      obscureText: type == "Password",
      keyboardType: type == "Email"
          ? TextInputType.emailAddress
          : TextInputType.text,
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
      validator: (value) =>
      value == null || value.isEmpty ? "Please Enter the $type" : null,
    );
  }
}