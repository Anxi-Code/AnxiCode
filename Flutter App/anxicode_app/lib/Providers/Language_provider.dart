import 'package:anxicode_app/Models/Languages.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'Language_provider.g.dart';


List<Languages> languages=[
  Languages(languageName: "Python", imagePath: "assets/images/python.png"),
  Languages(languageName: "Java", imagePath: "assets/images/java.png"),
  Languages(languageName: "JavaScript", imagePath: "assets/images/js.png"),
  Languages(languageName: "C++", imagePath: "assets/images/cpp.png"),

];

@riverpod
List<Languages> languagesList(ref) {
  return languages;
}
