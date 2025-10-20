import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:highlight/languages/dart.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/python.dart';
import 'package:highlight/languages/java.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Code Editor Demo',
      theme: ThemeData.dark(),
      home: const CodeEditorPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CodeEditorPage extends StatefulWidget {
  const CodeEditorPage({Key? key}) : super(key: key);

  @override
  State<CodeEditorPage> createState() => _CodeEditorPageState();
}

class _CodeEditorPageState extends State<CodeEditorPage> {
  late CodeController _controller;
  String _currentLanguage = 'JavaScript';

  final Map<String, dynamic> _languages = {
    'JavaScript': javascript,
    'Dart': dart,
    'Python': python,
    'Java': java,
  };

  @override
  void initState() {
    super.initState();

    _controller = CodeController(
      text: '''// Write your code here
function greet(name) {
  console.log("Hello, " + name + "!");
}

greet("World");''',
      language: javascript,
    );
  }

  void _changeLanguage(String language) {
    setState(() {
      _currentLanguage = language;
    });

    _controller.language = _languages[language];
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Code Editor'),
        actions: [
          // Language selector
          PopupMenuButton<String>(
            icon: const Icon(Icons.code),
            tooltip: 'Select Language',
            onSelected: _changeLanguage,
            itemBuilder: (context) => [
              const PopupMenuItem(value: 'JavaScript', child: Text('JavaScript')),
              const PopupMenuItem(value: 'Dart', child: Text('Dart')),
              const PopupMenuItem(value: 'Python', child: Text('Python')),
              const PopupMenuItem(value: 'Java', child: Text('Java')),
            ],
          ),
          // Run button
          IconButton(
            icon: const Icon(Icons.play_arrow),
            tooltip: 'Run Code',
            onPressed: () {
              final code = _controller.text;
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text('Code length: ${code.length} characters'),
                ),
              );
              print('Code:\n$code');
            },
          ),
          // Clear button
          IconButton(
            icon: const Icon(Icons.clear),
            tooltip: 'Clear',
            onPressed: () {
              _controller.clear();
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Editor
          Expanded(
            child: CodeTheme(
              data: CodeThemeData(styles: monokaiSublimeTheme),
              child: SingleChildScrollView(
                child: CodeField(
                  controller: _controller,
                  textStyle: const TextStyle(
                    fontFamily: 'SourceCode',
                    fontSize: 14,
                  ),
                ),
              ),
            ),
          ),
          // Status bar
          Container(
            height: 40,
            color: Colors.grey[900],
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Row(
              children: [
                Text('Language: $_currentLanguage'),
                const SizedBox(width: 24),
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    return Text('Lines: ${_controller.text.split('\n').length}');
                  },
                ),
                const SizedBox(width: 24),
                ValueListenableBuilder(
                  valueListenable: _controller,
                  builder: (context, value, child) {
                    return Text('Characters: ${_controller.text.length}');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}