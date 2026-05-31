class SyntaxChallenge {
  final String topic;
  final String taskDescription;
  final String hint;
  final List<String> templateParts; // e.g. ["for(int i=0; ", " ; ", " )"]
  final List<String> correctAnswers; // one per blank

  const SyntaxChallenge({
    required this.topic,
    required this.taskDescription,
    required this.hint,
    required this.templateParts,
    required this.correctAnswers,
  });
}
