import 'dart:ui';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
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

  void openMission() {
    FocusScope.of(context).unfocus(); // Close keyboard if open
    setState(() => isMissionExpanded = true);
  }

  void closeMission() => setState(() => isMissionExpanded = false);

  void openEditor() {
    FocusScope.of(context).unfocus(); // Close keyboard if open
    setState(() => isEditorExpanded = true);
  }

  void closeEditor() => setState(() => isEditorExpanded = false);

  void _runCode() {
    FocusScope.of(context).unfocus(); // Close keyboard on run
    // TODO: Implement code running logic
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      // Tapping anywhere outside the editor hides the keyboard
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          //--------------------------------------------------
          // BACKGROUND GRADIENT (Base Layer)
          //--------------------------------------------------
          const BgGradient(),

          //--------------------------------------------------
          // SCAFFOLD (Transparent to show gradient)
          // Automatically handles keyboard resizing!
          //--------------------------------------------------
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              title: Text("Debug Challenge",style: TextStyle(color: Colors.white),),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  //--------------------------------------------------
                  // MAIN CONTENT
                  //--------------------------------------------------
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    // Generous bottom padding so you can scroll above the keyboard
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 80),
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
                        // FIXED EDITOR HEIGHT
                        // Changed from a percentage to a fixed height (400)
                        // so it doesn't glitch when the keyboard resizes the screen
                        //--------------------------------------------------
                        SizedBox(
                          height: 400,
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
                                  physics: const BouncingScrollPhysics(),
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

                  //--------------------------------------------------
                  // EDITOR MODAL
                  //--------------------------------------------------
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
            ),
          ),
        ],
      ),
    );
  }
}