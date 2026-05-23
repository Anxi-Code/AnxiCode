// import 'package:flutter/material.dart';

// TextFormField inputField(
//   TextEditingController controller, {
//   String type = 'text',
//   IconData? icon,
//   Function(String)? onChanged,
//   String? externalError,
// }) {
//   return TextFormField(
//     controller: controller,

//     // hide text for  passwords
//     obscureText: type == "Password" || type == "Confirm Password",

//     // type of keyboard
//     keyboardType:
//         type == "Email" ? TextInputType.emailAddress : TextInputType.text,
//     style: const TextStyle(color: Colors.white),

//     // checks the username
//     onChanged: onChanged,

//     //decorations
//     decoration: InputDecoration(
//       hintText: "Enter your $type",
//       errorText: externalError,
//       filled: true,
//       prefixIcon: icon != null ? Icon(icon, color: Colors.white) : null,
//       fillColor: const Color(0xFF1B1B3A),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide.none,
//       ),
//     ),

//     //validation
//     validator: (value) => validate(value: value ?? "", type: type),
//   );
// }

// TextFormField nameInput({required TextEditingController controller}) {
//   return TextFormField(
//     controller: controller,
//     keyboardType: TextInputType.text,
//     style: const TextStyle(color: Colors.white),
//     decoration: InputDecoration(
//       hintText: "Enter your name",
//       filled: true,
//       fillColor: const Color(0xFF1B1B3A),
//       border: OutlineInputBorder(
//         borderRadius: BorderRadius.circular(15),
//         borderSide: BorderSide.none,
//       ),
//     ),
//     validator: (value) {
//       if (value == null || value.trim().isEmpty) {
//         return "value cannot be empty";
//       }
//       if (value.trim().length < 3) {
//         return "Name must be at least 3 characters";
//       }
//       return null;
//     },
//   );
// }
