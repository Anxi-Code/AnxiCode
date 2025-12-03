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
      appBar: AppBar(
        title: Text('Sign-Up Page'),
        centerTitle: true,
        leading: IconButton(
          //back to lgin page
          onPressed: () {
            context.go('/');
          },
          icon: Icon(Icons.arrow_back),
        ),
      ),
      body: Container(
        padding: EdgeInsets.all(15),
        child: Form(
          key: _fromkey,
          child: Column(
            children: [
              _inputField(_nameController, type: 'Name'),
              SizedBox(height: 20),
              _inputField(_userNameController, type: 'User Name'),
              SizedBox(height: 20),
              _inputField(_emailController, type: 'Email'),
              SizedBox(height: 20),
              _inputField(_passwordController, type: 'Password'),
              SizedBox(height: 20),
              _inputField(_finalPasswordController, type: 'Confirm Password'),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }

  //input function
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
