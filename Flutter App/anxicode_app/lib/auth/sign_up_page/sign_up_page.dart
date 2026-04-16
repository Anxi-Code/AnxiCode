import 'package:anxicode_app/Models/user_info.dart';
import 'package:anxicode_app/Services/supabase_db.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final SupabaseDb _db = SupabaseDb();
  final _fromkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _finalPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,

      appBar: AppBar(
        title: const Text('Sign-Up Page'),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100, // same theme
        elevation: 0,
        leading: IconButton(
          onPressed: () {
            context.go('/');
          },
          icon: const Icon(Icons.arrow_back),
        ),
      ),

      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _fromkey,
          child: Column(
            children: [
              _inputField(_nameController, type: 'Name'),
              const SizedBox(height: 20),
              _inputField(_userNameController, type: 'User Name'),
              const SizedBox(height: 20),
              _inputField(_emailController, type: 'Email'),
              const SizedBox(height: 20),
              _inputField(_passwordController, type: 'Password'),
              const SizedBox(height: 20),
              _inputField(_finalPasswordController, type: 'Confirm Password'),
              const SizedBox(height: 20),
              Container(
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.blue),
                ),
                child: TextButton.icon(
                  onPressed: () async {
                    if (!_fromkey.currentState!.validate()) return;

                    if (_passwordController.text !=
                        _finalPasswordController.text) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Passwords do not match")),
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
                      //to login page
                      context.go('/');
                    } on AuthException catch (e) {
                      ScaffoldMessenger.of(
                        context,
                      ).showSnackBar(SnackBar(content: Text(e.message)));
                    } catch (e) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text("Something went wrong")),
                      );
                    }
                  },
                  label: Text(
                    'Register',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  icon: Icon(Icons.verified_outlined),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _inputField(
    TextEditingController controller, {
    String type = 'Name',
  }) {
    return TextFormField(
      controller: controller,
      keyboardType:
          type == "Email" ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        labelText: type,
        hintText:
            type == "Confirm Password"
                ? "Confirm your Password"
                : "Enter your $type",
        border: const OutlineInputBorder(),
        enabledBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: const OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator:
          (value) =>
              (value == null || value.isEmpty)
                  ? "Please Enter the $type"
                  : null,
    );
  }
}
