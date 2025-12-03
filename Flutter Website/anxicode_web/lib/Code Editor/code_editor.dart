import 'package:flutter/material.dart';
import 'package:flutter_highlight/themes/atom-one-dark.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:highlight/languages/python.dart';

class AnxiCodeEditor extends StatefulWidget {
  const AnxiCodeEditor({super.key});

  @override
  State<AnxiCodeEditor> createState() => _CodeEditorState();
}

class _CodeEditorState extends State<AnxiCodeEditor> {
  late final CodeController _controller;

  @override
  void initState() {
    _controller = CodeController(
      text: '''
        numbers = [1, 2, 3, 4, 5]
        for num in numbers:
          if num % 2 == 0:
            print(f"{num} is even")
          else:
            print(f"{num} is odd")

        print("Loop finished!")
        print("All numbers processed.")

''',
      language: python,
    );

    super.initState();
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
        title: Text('AnxiCode', style: TextStyle(color: Colors.black)),
        centerTitle: true,
        backgroundColor: Colors.white,
      ),
      body: Row(
        children: [
          Expanded(
            flex: 4,
            child: CodeTheme(
              data: CodeThemeData(styles: atomOneDarkTheme),
              child: SingleChildScrollView(
                child: CodeField(
                  controller: _controller,
                  minLines: 30,
                  textStyle: TextStyle(fontSize: 16),
                  gutterStyle: GutterStyle(
                    errorPopupTextStyle: TextStyle(color: Colors.red),
                    showLineNumbers: true,
                    width: 70,
                  ),
                ),
              ),
            ),
          ),

          SizedBox(width: 2),

          Expanded(
            flex: 3,
            child: Container(color: Colors.grey.withValues(alpha: 0.1)),
          ),
        ],
      ),
    );
  }
}
