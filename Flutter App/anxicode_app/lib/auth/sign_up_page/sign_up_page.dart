import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
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
        hintText: type == "Confirm Password"
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
      validator: (value) =>
      (value == null || value.isEmpty)
          ? "Please Enter the $type"
          : null,
    );
  }
}