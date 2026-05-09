import 'dart:math';

import 'package:flutter/material.dart';

class BgGradient extends StatefulWidget {
  const BgGradient({super.key});

  @override
  State<BgGradient> createState() => _BgGradientState();
}

class _BgGradientState extends State<BgGradient>
    with SingleTickerProviderStateMixin {
  //animation
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 20),
    )..repeat(reverse: true);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomRight,
              transform: GradientRotation(_controller.value * 2 * pi),
              colors: [
                Color.fromARGB(255, 19, 19, 52),
                Color.fromARGB(255, 20, 20, 74),
                Color(0xFF2E1A5E),
                Color(0xFF6B2C6E),
              ],
              stops: [
                0.1 + (_controller.value * 0.2),
                0.3 + (_controller.value * 0.2),
                0.6 + (_controller.value * 0.2),
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}
