// import 'package:anxicode_app/user_registration/sign_up_page/helper_functions.dart';
// import 'package:flutter/material.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';

// class AccountInfo extends StatefulWidget {
//   final VoidCallback onNext;
//   const AccountInfo({super.key, required this.onNext});

//   @override
//   State<AccountInfo> createState() => _AccountInfoState();
// }

// class _AccountInfoState extends State<AccountInfo> {
//   final _formKey = GlobalKey<FormState>();

//   final _nameController = TextEditingController();
//   final _userNameController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _passwordController = TextEditingController();
//   final _confirmPasswordController = TextEditingController();

//   String? usernameErr;
//   bool isCheckingUsername = false;

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       padding: EdgeInsets.all(15),
//       child: Form(
//         key: _formKey,
//         child: Column(
//           children: [
//             const SizedBox(height: 20),

//             inputField(
//               _nameController,
//               type: 'Name',
//               icon: Icons.person_outline,
//             ),
//             const SizedBox(height: 15),

//             inputField(
//               _userNameController,
//               type: 'User Name',
//               icon: Icons.account_circle_outlined,
//               onChanged: _validateUserName,
//             ),
//             const SizedBox(height: 15),

//             inputField(
//               _emailController,
//               type: 'Email',
//               icon: Icons.mail_outlined,
//             ),
//             const SizedBox(height: 15),

//             inputField(
//               _passwordController,
//               type: 'Password',
//               icon: Icons.password_outlined,
//             ),
//             const SizedBox(height: 15),

//             inputField(
//               _confirmPasswordController,
//               type: 'Confirm Password',
//               icon: Icons.password_outlined,
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Future<void> _validateUserName(String value) async {
//     final v = value.trim();

//     if (v.isEmpty) {
//       setState(() {
//         usernameErr = "Username is required";
//       });
//       return;
//     }

//     setState(() {
//       isCheckingUsername = true;
//       usernameErr = null;
//     });

//     final supabase = Supabase.instance.client;

//     final result =
//         await supabase
//             .from('profiles')
//             .select('id')
//             .eq('user_name', v)
//             .maybeSingle();

//     final exists = result != null;

//     setState(() {
//       isCheckingUsername = false;
//       usernameErr = exists ? "Username already exists" : null;
//     });
//   }
// }
