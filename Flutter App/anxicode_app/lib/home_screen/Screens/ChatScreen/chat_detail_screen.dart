import 'package:flutter/material.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';

class ChatDetailScreen extends StatelessWidget {
  final String userName;

  const ChatDetailScreen({
    super.key,
    required this.userName,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BgGradient(),

        Scaffold(
          backgroundColor: Colors.transparent,

          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            title: Text(
              userName,
              style: const TextStyle(color: Colors.white),
            ),
          ),

          body: const Center(
            child: Text(
              "Ongoing Chat Here",
              style: TextStyle(color: Colors.white),
            ),
          ),
        ),
      ],
    );
  }
}