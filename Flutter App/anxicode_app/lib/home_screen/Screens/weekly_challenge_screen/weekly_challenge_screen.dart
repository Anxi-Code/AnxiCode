import 'package:flutter/material.dart';

class WeeklyChallengeScreen extends StatefulWidget {
  const WeeklyChallengeScreen({super.key});

  @override
  State<WeeklyChallengeScreen> createState() => _WeeklyChallengeScreenState();
}

class _WeeklyChallengeScreenState extends State<WeeklyChallengeScreen> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Text(
        'Weekly Challenge Screen',
        style: TextStyle(color: Colors.white),
      ),
    );
  }
}
