import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class LogIn extends StatefulWidget {
  const LogIn({super.key});

  @override
  State<LogIn> createState() => _LogInState();
}

class _LogInState extends State<LogIn> {
  final _fromkey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,

      appBar: AppBar(
        title: const Text('Log-In Page'),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100, // ✅ same as background
        elevation: 0,
      ),

      body: Container(
        padding: const EdgeInsets.all(15),
        child: Form(
          key: _fromkey,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _inputField(_emailController, type: 'Email'),
              const SizedBox(height: 20),
              _inputField(_passwordController, type: 'Password'),
              const SizedBox(height: 20),

              ElevatedButton(
                onPressed: () {
                  context.go('/home');
                },
                child: const Text("Login"),
              ),

              const SizedBox(height: 20),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text("Not registered? "),
                  GestureDetector(
                    onTap: () {
                      context.go('/signup');
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.bold,
                        decoration: TextDecoration.underline,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  TextFormField _inputField(
      TextEditingController controller, {
        String type = 'text',
      }) {
    return TextFormField(
      controller: controller,
      keyboardType:
      type == "Email" ? TextInputType.emailAddress : TextInputType.text,
      decoration: InputDecoration(
        hintText: "Enter your $type",
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