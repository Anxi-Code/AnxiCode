class Part2Topic {
  final String topicName;
  final int topicOrder;
  final String explainFile;
  final String quizFile;

  Part2Topic({
    required this.topicName,
    required this.topicOrder,
    required this.explainFile,
    required this.quizFile,
  });

  Part2Topic copyWith({
    String? topicName,
    int? topicOrder,
    String? explainFile,
    String? quizFile,
  }) {
    return Part2Topic(
      topicName: topicName ?? this.topicName,
      topicOrder: topicOrder ?? this.topicOrder,
      explainFile: explainFile ?? this.explainFile,
      quizFile: quizFile ?? this.quizFile,
    );
  }

  factory Part2Topic.fromJson(Map<String, dynamic> json) {
    return Part2Topic(
      topicName: json['topic_name'],
      topicOrder: json['topic_order'],
      explainFile: json['explain_file'],
      quizFile: json['quiz_file'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'topic_name': topicName,
      'topic_order': topicOrder,
      'explain_file': explainFile,
      'quiz_file': quizFile,
    };
  }
}