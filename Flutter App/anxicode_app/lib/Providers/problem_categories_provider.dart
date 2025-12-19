import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'problem_categories_provider.g.dart';

final List<String> problemCategories = [
  "Fundamentals",
  "Data Structures",
  "Algorithms",
  "Recursion & Backtracking",
  "Trees & Graphs",
  "Dynamic Programming",
  "Bit Manipulation",
  "Math & Logic",
  "Object-Oriented Programming",
  "System Design",
];
@riverpod
List<String> problemCategoriesList(ref) {
  return problemCategories;
}

