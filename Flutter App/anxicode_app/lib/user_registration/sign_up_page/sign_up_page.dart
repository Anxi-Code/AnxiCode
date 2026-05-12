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
  final _fromkey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _userNameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final _finalPasswordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        BgGradient(),
        Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(

          backgroundColor: Colors.transparent,
          elevation: 0,
          iconTheme: const IconThemeData(color: Colors.white),
          leading: IconButton(
            onPressed: () {
              context.go('/');
            },
            icon: const Icon(Icons.arrow_back),
          ),
          titleTextStyle: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 20,
          ),
        ),

        body: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            color: Colors.transparent
          ),
          padding: const EdgeInsets.all(15),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                    height: 200,
                    width: 500,
                    child:Image.asset(
                      "assets/images/anxicode.png",
                      fit: BoxFit.fitWidth,
                    )
            
                ),
                Form(
                  key: _fromkey,
                  child: SingleChildScrollView(
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
                        const SizedBox(height: 30),
            
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            gradient: const LinearGradient(
                              colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
                            ),
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.cyanAccent.withValues(alpha: 0.3),
                                blurRadius: 12,
                                spreadRadius: 1,
                              ),
                            ],
                          ),
                          child: TextButton.icon(
                            onPressed: () async {
                              if (!_fromkey.currentState!.validate()) return;
            
                              if (_passwordController.text !=
                                  _finalPasswordController.text) {
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
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content: Text("Registration successful"),
                                  ),
                                );
            
                                await _db.registerUser(userInfo: user);
            

            
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
                            label: const Text(
                              'REGISTER',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 1,
                              ),
                            ),
                            icon: const Icon(
                              Icons.verified_outlined,
                              color: Colors.white,
                            ),
                          ),
<<<<<<< HEAD
                        ),
                      ],
=======
                        );

                        context.go('/login');
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
                    label: const Text(
                      'REGISTER',
                      style: TextStyle(
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        letterSpacing: 1,
                      ),
                    ),
                    icon: const Icon(
                      Icons.verified_outlined,
                      color: Colors.white,
>>>>>>> 558fbe7d (Improved Wrapper)
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]
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
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        labelText: type,
        labelStyle: const TextStyle(color: Colors.white70),
        hintText:
            type == "Confirm Password"
                ? "Confirm your Password"
                : "Enter your $type",
        hintStyle: const TextStyle(color: Colors.white54),
        filled: true,
        fillColor: const Color(0xFF1B1B3A),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.white24),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.cyanAccent, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(15),
          borderSide: const BorderSide(color: Colors.red, width: 2),
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
