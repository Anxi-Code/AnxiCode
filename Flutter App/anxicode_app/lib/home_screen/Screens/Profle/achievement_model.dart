import 'package:flutter/material.dart';

class AchievementModel {
  final String id;
  final String title;
  final String description;
  final String points;
  final IconData icon;
  final Color color;
  bool unlocked;

  AchievementModel({
    required this.id,
    required this.title,
    required this.description,
    required this.points,
    required this.icon,
    required this.color,
    this.unlocked = false,
  });
}