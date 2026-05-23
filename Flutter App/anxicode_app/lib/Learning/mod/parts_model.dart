import 'package:anxicode_app/Learning/mod/files_part.dart';
import 'package:anxicode_app/Learning/mod/part1.dart';
import 'package:anxicode_app/Learning/mod/part2.dart';

class PartsModel {
  final List<Part1Topic> part1Learning;
  final List<Part2Topic> part2Mastery;
  final FilePart part3SyntaxLearning;
  final FilePart part4Debugging;
  final FilePart part5ConfidenceTest;

  PartsModel({
    required this.part1Learning,
    required this.part2Mastery,
    required this.part3SyntaxLearning,
    required this.part4Debugging,
    required this.part5ConfidenceTest,
  });

  PartsModel copyWith({
    List<Part1Topic>? part1Learning,
    List<Part2Topic>? part2Mastery,
    FilePart? part3SyntaxLearning,
    FilePart? part4Debugging,
    FilePart? part5ConfidenceTest,
  }) {
    return PartsModel(
      part1Learning: part1Learning ?? this.part1Learning,
      part2Mastery: part2Mastery ?? this.part2Mastery,
      part3SyntaxLearning: part3SyntaxLearning ?? this.part3SyntaxLearning,
      part4Debugging: part4Debugging ?? this.part4Debugging,
      part5ConfidenceTest: part5ConfidenceTest ?? this.part5ConfidenceTest,
    );
  }

  factory PartsModel.fromJson(Map<String, dynamic> json) {
    return PartsModel(
      part1Learning: (json['part1_learning'] as List)
          .map((e) => Part1Topic.fromJson(e))
          .toList(),

      part2Mastery: (json['part2_mastery'] as List)
          .map((e) => Part2Topic.fromJson(e))
          .toList(),

      part3SyntaxLearning:
      FilePart.fromJson(json['part3_syntax_learning']),

      part4Debugging:
      FilePart.fromJson(json['part4_debugging']),

      part5ConfidenceTest:
      FilePart.fromJson(json['part5_confidence_test']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'part1_learning': part1Learning.map((e) => e.toJson()).toList(),
      'part2_mastery': part2Mastery.map((e) => e.toJson()).toList(),
      'part3_syntax_learning': part3SyntaxLearning.toJson(),
      'part4_debugging': part4Debugging.toJson(),
      'part5_confidence_test': part5ConfidenceTest.toJson(),
    };
  }
}