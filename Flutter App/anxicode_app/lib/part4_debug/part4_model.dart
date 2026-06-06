import 'package:anxicode_app/part4_debug/test_case.dart';

class DebuggingData {
  final String topic;
  final String language;
  final String part;
  final List<DebuggingTask> tasks;

  DebuggingData({
    required this.topic,
    required this.language,
    required this.part,
    required this.tasks,
  });

  factory DebuggingData.fromJson(Map<String, dynamic> json) {
    return DebuggingData(
      topic: json['topic'] ?? '',
      language: json['language'] ?? '',
      part: json['part'] ?? '',
      tasks: (json['tasks'] as List<dynamic>?)
          ?.map((e) => DebuggingTask.fromJson(e as Map<String, dynamic>))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic': topic,
      'language': language,
      'part': part,
      'tasks': tasks.map((e) => e.toJson()).toList(),
    };
  }
}
class DebuggingTask {
  final int id;
  final String title;
  final String description;
  final String code;
  final String expectedFix;
  final int timeout;
  final List<TestCase> testCases;

  DebuggingTask({
    required this.id,
    required this.title,
    required this.description,
    required this.code,
    required this.expectedFix,
    required this.timeout,
    required this.testCases,
  });

  factory DebuggingTask.fromJson(Map<String, dynamic> json) {
    return DebuggingTask(
      id: json['id'] ?? 0,
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      code: json['code'] ?? '',
      expectedFix: json['expected_fix'] ?? '',
      timeout: json['timeout'] ?? 0,
      testCases: (json['test_cases'] as List<dynamic>?)
          ?.map((e) => TestCase.fromJson(e))
          .toList() ??
          [],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'description': description,
      'code': code,
      'expected_fix': expectedFix,
      'timeout': timeout,
      'test_cases': testCases.map((e) => e.toJson()).toList(),
    };
  }
}