import 'dart:ui';
import 'package:flutter/material.dart';

class Glassmorphism extends StatelessWidget {
  final double blur; // Background blur intensity
  final double opacity; // Overlay opacity (0.0 to 1.0)
  final Widget child; // Content inside glass card
  final Color borderColor; // Border color of the card
  final BorderRadius borderRadius; // Border radius

  const Glassmorphism({
    super.key,
    this.blur = 12,
    this.opacity = 0.2,
    required this.child,
    this.borderColor = Colors.white,
    this.borderRadius = const BorderRadius.all(Radius.circular(20)),
  });

  @override
  Widget build(BuildContext context) {
    // Clamp opacity between 0.0 and 1.0
    final o = opacity.clamp(0.0, 1.0);

    return ClipRRect(
      borderRadius: borderRadius,
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: borderRadius,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.white.withValues(alpha: o),
                Colors.white.withValues(alpha: (o * 0.5)),
              ],
            ),
            border: Border.all(
              color: borderColor.withValues(alpha: (o + 0.2).clamp(0.0, 1.0)),
              width: 1.5,
            ),
          ),
          child: child,
        ),
      ),
    );
  }
}
