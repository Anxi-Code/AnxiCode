import 'dart:ui';
import 'package:anxicode_app/part4_debug/description.dart';
import 'package:anxicode_app/part4_debug/editor.dart';
import 'package:anxicode_app/part4_debug/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:highlight/highlight_core.dart';
import 'package:highlight/languages/cpp.dart';

class DebugCode extends StatefulWidget {
  final Mode language;
  final String buggyCode;
  final String taskDescription;

  const DebugCode({
    super.key,
    required this.language,
    required this.buggyCode,
    required this.taskDescription,
  });

  @override
  State<DebugCode> createState() => _DebugCodeState();
}

class _DebugCodeState extends State<DebugCode> {
  bool isMissionExpanded = false;
  bool isEditorExpanded = false;

  void openMission() => setState(() => isMissionExpanded = true);
  void closeMission() => setState(() => isMissionExpanded = false);

  void openEditor() => setState(() => isEditorExpanded = true);
  void closeEditor() => setState(() => isEditorExpanded = false);

  void _runCode() {}

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Stack(
        children: [
          //--------------------------------------------------
          // MAIN CONTENT
          //--------------------------------------------------
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  headerCard(),
                  const SizedBox(height: 15),

                  DescriptionTile(
                    description: widget.taskDescription,
                    onExpand: openMission,
                  ),

                  const SizedBox(height: 15),

                  //--------------------------------------------------
                  // FIXED EDITOR HEIGHT (NO Expanded)
                  //--------------------------------------------------
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.55,
                    child: DebugCodeEditor(
                      buggyCode: widget.buggyCode,
                      language: cpp,
                      onRun: _runCode,
                      onExpand: openEditor,
                    ),
                  ),

                  const SizedBox(height: 10),
                ],
              ),
            ),
          ),

          //--------------------------------------------------
          // BLUR BACKDROP
          //--------------------------------------------------
          if (isMissionExpanded || isEditorExpanded)
            Positioned.fill(
              child: GestureDetector(
                onTap: () {
                  closeMission();
                  closeEditor();
                },
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(color: Colors.black.withValues(alpha: 0.35)),
                ),
              ),
            ),

          //--------------------------------------------------
          // MISSION MODAL
          //--------------------------------------------------
          if (isMissionExpanded)
            Positioned.fill(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(18),
                  decoration: glassCard(),
                  constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height * 0.70,
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          const Icon(Icons.flag, color: Colors.amber),
                          const SizedBox(width: 8),
                          const Text(
                            "MISSION OBJECTIVE",
                            style: TextStyle(
                              color: Colors.amber,
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                            ),
                          ),
                          const Spacer(),
                          InkWell(
                            onTap: closeMission,
                            child: const Icon(
                              Icons.close,
                              color: Colors.cyanAccent,
                            ),
                          ),
                        ],
                      ),

                      const SizedBox(height: 20),

                      Expanded(
                        child: SingleChildScrollView(
                          child: Text(
                            widget.taskDescription,
                            style: TextStyle(
                              color: Colors.grey.shade300,
                              height: 1.7,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          if (isEditorExpanded)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              bottom: 0,
              child: Material(
                color: Colors.transparent,
                child: SafeArea(
                  child: Center(
                    child: Container(
                      margin: const EdgeInsets.all(20),
                      decoration: glassCard(),
                      child: Column(
                        children: [
                          Container(
                            padding: const EdgeInsets.all(14),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.code,
                                  color: Colors.cyanAccent,
                                ),

                                const SizedBox(width: 10),

                                const Text(
                                  "CODE EDITOR",
                                  style: TextStyle(
                                    color: Colors.cyanAccent,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),

                                const Spacer(),

                                IconButton(
                                  onPressed: closeEditor,
                                  icon: const Icon(
                                    Icons.close,
                                    color: Colors.cyanAccent,
                                  ),
                                ),
                              ],
                            ),
                          ),

                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.all(12),
                              child: DebugCodeEditor(
                                buggyCode: widget.buggyCode,
                                language: cpp,
                                onRun: _runCode,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
