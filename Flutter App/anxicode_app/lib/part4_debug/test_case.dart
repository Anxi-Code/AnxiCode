class TestCase {
  final String input;
  final String expectedOutput;

  TestCase({
    required this.input,
    required this.expectedOutput,
  });

  factory TestCase.fromJson(Map<String, dynamic> json) {
    return TestCase(
      input: json['input'] ?? '',
      expectedOutput: json['expected_output'] ?? '',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'input': input,
      'expected_output': expectedOutput,
    };
  }
}