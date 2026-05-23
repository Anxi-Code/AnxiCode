import 'package:anxicode_app/Models/user_info.dart';
import 'package:anxicode_app/Services/supabase_db.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RegisterButton extends StatelessWidget {
  const RegisterButton({
    super.key,
    required GlobalKey<FormState> formKey,
    required TextEditingController passwordController,
    required TextEditingController confirmPasswordController,
    required TextEditingController nameController,
    required TextEditingController userNameController,
    required TextEditingController emailController,
    required SupabaseAuthService db,
  }) : _formKey = formKey,
       _passwordController = passwordController,
       _confirmPasswordController = confirmPasswordController,
       _nameController = nameController,
       _userNameController = userNameController,
       _emailController = emailController,
       _db = db;

  final GlobalKey<FormState> _formKey;
  final TextEditingController _passwordController;
  final TextEditingController _confirmPasswordController;
  final TextEditingController _nameController;
  final TextEditingController _userNameController;
  final TextEditingController _emailController;
  final SupabaseAuthService _db;

  @override
  Widget build(BuildContext context) {
    return Container(
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

          if (_passwordController.text != _confirmPasswordController.text) {
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
              const SnackBar(content: Text("Registration successful")),
            );

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
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          padding: const EdgeInsets.symmetric(vertical: 15),
        ),
        child: const Text(
          "REGISTER",
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
