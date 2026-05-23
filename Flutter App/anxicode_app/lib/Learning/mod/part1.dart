class Part1Topic {
  final String topicName;
  final int topicOrder;
  final String simpleExplainFile;
  final String simpleQuizFile;
  final String easyExplainFile;
  final String easyQuizFile;

  Part1Topic({
    required this.topicName,
    required this.topicOrder,
    required this.simpleExplainFile,
    required this.simpleQuizFile,
    required this.easyExplainFile,
    required this.easyQuizFile,
  });

  Part1Topic copyWith({
    String? topicName,
    int? topicOrder,
    String? simpleExplainFile,
    String? simpleQuizFile,
    String? easyExplainFile,
    String? easyQuizFile,
  }) {
    return Part1Topic(
      topicName: topicName ?? this.topicName,
      topicOrder: topicOrder ?? this.topicOrder,
      simpleExplainFile: simpleExplainFile ?? this.simpleExplainFile,
      simpleQuizFile: simpleQuizFile ?? this.simpleQuizFile,
      easyExplainFile: easyExplainFile ?? this.easyExplainFile,
      easyQuizFile: easyQuizFile ?? this.easyQuizFile,
    );
  }

  factory Part1Topic.fromJson(Map<String, dynamic> json) {
    return Part1Topic(
      topicName: json['topic_name'],
      topicOrder: json['topic_order'],
      simpleExplainFile: json['simple_explain_file'],
      simpleQuizFile: json['simple_quiz_file'],
      easyExplainFile: json['easy_explain_file'],
      easyQuizFile: json['easy_quiz_file'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic_name': topicName,
      'topic_order': topicOrder,
      'simple_explain_file': simpleExplainFile,
      'simple_quiz_file': simpleQuizFile,
      'easy_explain_file': easyExplainFile,
      'easy_quiz_file': easyQuizFile,
    };
  }
}