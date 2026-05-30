import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/monokai-sublime.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight/highlight_core.dart';

class DebugCodeEditor extends StatefulWidget {
  final String buggyCode;
  final Mode language;
  final VoidCallback onRun;
  final VoidCallback? onExpand;

  const DebugCodeEditor({
    super.key,
    required this.buggyCode,
    required this.language,
    required this.onRun,
    this.onExpand,
  });

  @override
  State<DebugCodeEditor> createState() => _DebugCodeEditorState();
}

class _DebugCodeEditorState extends State<DebugCodeEditor> {
  late CodeController _controller;

  final LinearGradient buttonGradient = const LinearGradient(
    colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
  );

  @override
  void initState() {
    super.initState();

    _controller = CodeController(
      text: widget.buggyCode,
      language: widget.language,
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final keyboardOpen = MediaQuery.of(context).viewInsets.bottom > 0;

    return Column(
      children: [
        //--------------------------------------------------
        // EDITOR
        //--------------------------------------------------
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.25),
              ),
              gradient: RadialGradient(
                radius: 4,
                colors: [
                  Colors.cyanAccent.withValues(alpha: 0.06),
                  Colors.white.withValues(alpha: 0.05),
                ],
              ),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.15),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              children: [
                //--------------------------------------------------
                // HEADER
                //--------------------------------------------------
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 14,
                    vertical: 10,
                  ),
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),
                  ),
                  child: Row(
                    children: [
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.greenAccent,
                      ),

                      const SizedBox(width: 8),

                      Text(
                        "Connected",
                        style: GoogleFonts.orbitron(
                          color: Colors.greenAccent,
                          fontSize: 11,
                        ),
                      ),

                      const Spacer(),

                      if (widget.onExpand != null)
                        IconButton(
                          onPressed: widget.onExpand,
                          icon: const Icon(
                            Icons.fullscreen,
                            color: Colors.cyanAccent,
                          ),
                        ),

                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 10,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          gradient: buttonGradient,
                        ),
                        child: Text(
                          _getLanguageLabel(widget.language),
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: 11,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),

                //--------------------------------------------------
                // CODE AREA
                //--------------------------------------------------
                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(15),
                      bottomRight: Radius.circular(15),
                    ),
                    child: CodeTheme(
                      data: CodeThemeData(styles: monokaiSublimeTheme),
                      child: CodeField(
                        controller: _controller,
                        expands: true,
                        textStyle: const TextStyle(fontSize: 14),
                        gutterStyle: const GutterStyle(
                          showLineNumbers: true,
                          showErrors: false,
                          showFoldingHandles: false,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

        //--------------------------------------------------
        // RUN BUTTON
        //--------------------------------------------------
        if (!keyboardOpen) ...[
          const SizedBox(height: 10),

          SizedBox(
            height: 48,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: buttonGradient,
                borderRadius: BorderRadius.circular(15),
              ),
              child: ElevatedButton.icon(
                onPressed: widget.onRun,
                icon: const Icon(Icons.play_arrow_rounded, color: Colors.white),
                label: Text(
                  "RUN & VERIFY",
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  String _getLanguageLabel(dynamic lang) {
    if (lang.toString().contains("cpp")) return "C++";
    if (lang.toString().contains("python")) return "Python";
    if (lang.toString().contains("java")) return "Java";
    if (lang.toString().contains("javascript")) return "JS";
    return "CODE";
  }
}
