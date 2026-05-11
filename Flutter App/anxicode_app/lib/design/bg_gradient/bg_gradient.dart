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
                Color(0xFF050816), // deep space
                Color(0xFF140B2D), // dark galaxy purple
                Color(0xFF2E1A5E), // indigo nebula
                Color(0xFF6B2C6E), // cosmic purple
                Color(0xFFB5179E), // pink nebula glow
              ],

              stops: [
                0.05 + (_controller.value * 0.15),
                0.25 + (_controller.value * 0.15),
                0.50 + (_controller.value * 0.15),
                0.75 + (_controller.value * 0.15),
                1.0,
              ],
            ),
          ),
        );
      },
    );
  }
}
