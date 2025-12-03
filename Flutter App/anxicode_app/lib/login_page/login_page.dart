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
      appBar: AppBar(title: Text('Log-In Page'), centerTitle: true),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _fromkey,
          child: Column(
            children: [
              _inputField(_emailController, type: 'Email'),
              SizedBox(height: 20),
              _inputField(_passwordController, type: 'Password'),
              SizedBox(height: 20),
              // Meesum Start here
              // by this we login to app
              ElevatedButton(
                onPressed: () {
                  // no function as you said
                },
                child: Text("Login"),
              ),
              SizedBox(height: 20),

              // Sign Up Navigation Text
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Not registered? "),

                  GestureDetector(
                    onTap: () {
                      context.go('/signup'); // Navigate to SignUp page
                    },
                    child: Text(
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

  //input function
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
        border: OutlineInputBorder(),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.grey),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.red, width: 2),
        ),
      ),
      validator:
          (value) =>
              (value == null || value.isEmpty)
                  ? "Please Enter the $type "
                  : null,
    );
  }
}
