import 'package:flutter/material.dart';
import 'package:flutter_code_editor/flutter_code_editor.dart';
import 'package:flutter_highlight/themes/vs2015.dart'; // IMPORTED VS CODE THEME
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight/highlight_core.dart';

class DebugCodeEditor extends StatefulWidget {
  final String buggyCode;
  final Mode language;
  final VoidCallback onRun;
  final VoidCallback? onExpand;
  final ValueChanged<String> onCodeChanged;

  final bool isCompiling;
  final bool? evaluationPassed;
  final VoidCallback onNextProblem;
  final bool isFullscreen;
  final VoidCallback? onCloseFullscreen;

  const DebugCodeEditor({
    super.key,
    required this.buggyCode,
    required this.language,
    required this.onRun,
    required this.onCodeChanged,
    required this.isCompiling,
    required this.onNextProblem,
    required this.isFullscreen,
    required this.evaluationPassed,
    this.onExpand,
    this.onCloseFullscreen,
  });

  @override
  State<DebugCodeEditor> createState() => _DebugCodeEditorState();
}

class _DebugCodeEditorState extends State<DebugCodeEditor> {
  late CodeController _controller;

  final LinearGradient actionGradient = const LinearGradient(
    colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
  );

  @override
  void initState() {
    super.initState();
    _controller = CodeController(
      text: widget.buggyCode,
      language: widget.language,
    );

    _controller.addListener(() {
      widget.onCodeChanged(_controller.text);
    });
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
        Expanded(
          child: Container(
            decoration: BoxDecoration(
              color: const Color(0xFF1E1E1E),
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.4)),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.08),
                  blurRadius: 15,
                ),
              ],
            ),
            child: Column(
              children: [
                 Container(
                  padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
                  decoration: BoxDecoration(
                    color: Colors.black.withValues(alpha: 0.25),
                    borderRadius: const BorderRadius.only(topLeft: Radius.circular(18), topRight: Radius.circular(18)),
                    border: Border(bottom: BorderSide(color: Colors.white.withValues(alpha: 0.08))),
                  ),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: Colors.cyanAccent.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.2)),
                        ),
                        child: Text(
                          _getLanguageLabel(widget.language),
                          style: GoogleFonts.orbitron(color: Colors.cyanAccent, fontSize: 11, fontWeight: FontWeight.bold),
                        ),
                      ),

                      if (widget.isFullscreen) ...[
                        const Spacer(),
                        Text(
                          "WORKSPACE CONSOLE",
                          style: GoogleFonts.orbitron(color: Colors.white, fontSize: 13, fontWeight: FontWeight.bold, letterSpacing: 1),
                        ),
                      ],

                      const Spacer(),

                      if (widget.isCompiling)
                        const Padding(
                          padding: EdgeInsets.only(right: 14),
                          child: SizedBox(
                            width: 18,
                            height: 18,
                            child: CircularProgressIndicator(strokeWidth: 2.5, color: Colors.cyanAccent),
                          ),
                        ),

                      if (widget.onExpand != null && !widget.isFullscreen)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                            onPressed: widget.isCompiling ? null : widget.onExpand,
                            icon: const Icon(Icons.open_in_full, color: Colors.cyanAccent, size: 18),
                          ),
                        ),

                      if (widget.isFullscreen && widget.onCloseFullscreen != null)
                        Container(
                          margin: const EdgeInsets.only(left: 8),
                          decoration: BoxDecoration(
                            color: Colors.white.withValues(alpha: 0.05),
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: IconButton(
                            constraints: const BoxConstraints(),
                            padding: const EdgeInsets.all(6),
                            onPressed: widget.isCompiling ? null : widget.onCloseFullscreen,
                            icon: const Icon(Icons.close_fullscreen, color: Colors.cyanAccent, size: 18),
                          ),
                        ),
                    ],
                  ),
                ),

                Expanded(
                  child: ClipRRect(
                    borderRadius: const BorderRadius.only(bottomLeft: Radius.circular(18), bottomRight: Radius.circular(18)),
                    child: CodeTheme(
                      data: CodeThemeData(styles: vs2015Theme), // Authentic VS Code Theme Syntax Mapping
                      child: CodeField(
                        controller: _controller,
                        expands: true,
                        textStyle: const TextStyle(fontSize: 15, fontFamily: 'Courier', height: 1.5),
                        gutterStyle: const GutterStyle(
                          showLineNumbers: true,
                          showErrors: false,
                          showFoldingHandles: false,
                          textStyle: TextStyle(color: Colors.white38, fontSize: 13),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),

         if (widget.evaluationPassed != null) ...[
          const SizedBox(height: 16),
          _buildMinimalStatusBar(),
        ],

        if (!keyboardOpen && !widget.isCompiling && widget.evaluationPassed != true) ...[
          const SizedBox(height: 16),
          SizedBox(
            height: 54,
            width: double.infinity,
            child: DecoratedBox(
              decoration: BoxDecoration(
                gradient: actionGradient,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: const Color(0xFF00C9A7).withValues(alpha: 0.3),
                    blurRadius: 12,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: ElevatedButton(
                onPressed: widget.onRun,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shadowColor: Colors.transparent,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
                ),
                child: Text(
                  widget.evaluationPassed == false ? "RE-TRY COMPILATION" : "RUN & VERIFY CODE",
                  style: GoogleFonts.orbitron(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 15, letterSpacing: 1.5),
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }

  Widget _buildMinimalStatusBar() {
    final bool passed = widget.evaluationPassed == true;
    final Color glowColor = passed ? Colors.greenAccent : Colors.redAccent;

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: BoxDecoration(
        color: glowColor.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: glowColor.withValues(alpha: 0.4)),
        boxShadow: [
          BoxShadow(
            color: glowColor.withValues(alpha: 0.1),
            blurRadius: 10,
          ),
        ],
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(6),
            decoration: BoxDecoration(
              color: glowColor.withValues(alpha: 0.15),
              shape: BoxShape.circle,
            ),
            child: Icon(passed ? Icons.check_circle_rounded : Icons.cancel_rounded, color: glowColor, size: 22),
          ),
          const SizedBox(width: 14),
          Text(
            passed ? "Answer Correct" : "Incorrect Code",
            style: GoogleFonts.orbitron(color: glowColor, fontSize: 14, fontWeight: FontWeight.bold, letterSpacing: 1),
          ),
          const Spacer(),
          if (passed)
            SizedBox(
              height: 40,
              child: ElevatedButton.icon(
                onPressed: widget.onNextProblem,
                icon: const Icon(Icons.arrow_forward_rounded, size: 18, color: Colors.black),
                label: Text(
                  "NEXT",
                  style: GoogleFonts.orbitron(fontSize: 13, fontWeight: FontWeight.bold, color: Colors.black, letterSpacing: 1),
                ),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.greenAccent,
                  shadowColor: Colors.greenAccent.withValues(alpha: 0.5),
                  elevation: 6,
                  padding: const EdgeInsets.symmetric(horizontal: 18),
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
              ),
            ),
        ],
      ),
    );
  }

  String _getLanguageLabel(dynamic lang) {
    final str = lang.toString().toLowerCase();
    if (str.contains("cpp") || str.contains("c++")) return "C++";
    if (str.contains("python")) return "Python";
    if (str.contains("java")) return "Java";
    if (str.contains("javascript")) return "JS";
    return "CODE";
  }
}