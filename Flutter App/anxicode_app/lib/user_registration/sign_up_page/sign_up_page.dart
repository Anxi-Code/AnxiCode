import 'package:anxicode_app/Models/user_info.dart';
import 'package:anxicode_app/Services/supabase_db.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
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

                    _inputField(_confirmPasswordController, type: 'Confirm Password'),

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

                          if (_passwordController.text !=
                              _confirmPasswordController.text) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Passwords do not match"),
                              ),
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

                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Registration successful"),
                              ),
                            );

                            context.go('/');
                          } on AuthException catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(content: Text(e.message)),
                            );
                          } catch (e) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Something went wrong"),
                              ),
                            );
                          }
                        },
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
      validator: (value) =>
      value == null || value.isEmpty ? "Please Enter $type" : null,
    );
  }
}