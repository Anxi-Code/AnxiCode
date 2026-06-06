import 'dart:ui';
import 'package:anxicode_app/Network/dio_client.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/part4_debug/description.dart';
import 'package:anxicode_app/part4_debug/editor.dart';
import 'package:anxicode_app/part4_debug/helper_functions.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight/highlight_core.dart';

class DebugCode extends StatefulWidget {
  final Mode language;
  final String buggyCode;
  final String taskDescription;
  final String taskId;
  final String slug;
  final int pointsPreview;
  final VoidCallback onSuccessCleared;

  const DebugCode({
    super.key,
    required this.language,
    required this.buggyCode,
    required this.taskDescription,
    required this.taskId,
    required this.slug,
    required this.pointsPreview,
    required this.onSuccessCleared,
  });

  @override
  State<DebugCode> createState() => _DebugCodeState();
}

class _DebugCodeState extends State<DebugCode> {
  bool isMissionExpanded = false;
  bool isEditorExpanded = false;
  bool isCompiling = false;

  bool? evaluationPassed;
  late String workingCodeBuffer;

  @override
  void initState() {
    super.initState();
    workingCodeBuffer = widget.buggyCode;
  }

  void openMission() {
    FocusScope.of(context).unfocus();
    setState(() => isMissionExpanded = true);
  }

  void closeMission() => setState(() => isMissionExpanded = false);

  void openEditor() {
    FocusScope.of(context).unfocus();
    setState(() => isEditorExpanded = true);
  }

  void closeEditor() => setState(() => isEditorExpanded = false);

  void _updateCodeBuffer(String code) {
    workingCodeBuffer = code;
  }

  Future<void> _runAndVerifyCode() async {
    FocusScope.of(context).unfocus();
    setState(() {
      isCompiling = true;
      evaluationPassed = null;
    });

    try {
      final int numericId = int.tryParse(widget.taskId.replaceAll(RegExp(r'[^0-9]'), '')) ?? 1;

      final Map<String, dynamic> payload = {
        "slug": widget.slug,
        "task_id": numericId,
        "rank": "rookie",
        "description": widget.taskDescription,
        "language": _getLanguageString(widget.language),
        "code_user_debuged": workingCodeBuffer,
      };

      final response = await DioClient().dio.post("/api/part4/verify", data: payload);
      final bool backendSuccess = response.data['status'] == 'success' && response.data['all_passed'] == true;

      setState(() {
        isCompiling = false;
        evaluationPassed = backendSuccess;
      });
    } on DioException catch (dioErr) {
      final String diagnosticLog = dioErr.message ?? dioErr.type.toString();
      debugPrint("Dio Error Network Catch Exception Logs: $diagnosticLog");
      setState(() {
        isCompiling = false;
        evaluationPassed = false;
      });
    } catch (e) {
      debugPrint("Generic Framework Code Execution Error: $e");
      setState(() {
        isCompiling = false;
        evaluationPassed = false;
      });
    }
  }

  String _getLanguageString(dynamic languageMode) {
    final String modeStr = languageMode.toString().toLowerCase();
    if (modeStr.contains("python")) return "python";
    if (modeStr.contains("cpp") || modeStr.contains("c++")) return "cpp";
    if (modeStr.contains("java")) return "java";
    if (modeStr.contains("javascript")) return "javascript";
    return "python";
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Stack(
        children: [
          const BgGradient(),
          Scaffold(
            backgroundColor: Colors.transparent,
            resizeToAvoidBottomInset: true,
            appBar: AppBar(
              backgroundColor: Colors.transparent,
              elevation: 0,
              centerTitle: true,
              leading: const BackButton(color: Colors.white),
              title: Text(
                "Error Tracking Arena",
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.2,
                ),
              ),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 10, 16, 120),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeaderCard(),
                        const SizedBox(height: 18),
                        DescriptionTile(
                          description: widget.taskDescription,
                          onExpand: openMission,
                        ),
                        const SizedBox(height: 18),

                        SizedBox(
                          height: 420,
                          child: DebugCodeEditor(
                            buggyCode: workingCodeBuffer,
                            language: widget.language,
                            onRun: _runAndVerifyCode,
                            onExpand: openEditor,
                            onCodeChanged: _updateCodeBuffer,
                            isCompiling: isCompiling,
                            evaluationPassed: evaluationPassed,
                            onNextProblem: widget.onSuccessCleared,
                            isFullscreen: false,
                          ),
                        ),
                      ],
                    ),
                  ),

                  if (isMissionExpanded)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: closeMission,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 16, sigmaY: 16),
                          child: Container(color: Colors.black.withValues(alpha: 0.5)),
                        ),
                      ),
                    ),

                  if (isMissionExpanded)
                    Positioned.fill(
                      child: Center(
                        child: Container(
                          margin: const EdgeInsets.all(20),
                          padding: const EdgeInsets.all(20),
                          decoration: _glassCardDecoration(),
                          constraints: BoxConstraints(maxHeight: MediaQuery.of(context).size.height * 0.75),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  const Icon(Icons.flag, color: Colors.amber),
                                  const SizedBox(width: 10),
                                  Text(
                                    "MISSION OBJECTIVE",
                                    style: GoogleFonts.orbitron(color: Colors.amber, fontWeight: FontWeight.bold, fontSize: 15),
                                  ),
                                  const Spacer(),
                                  InkWell(
                                    onTap: closeMission,
                                    child: Container(
                                      padding: const EdgeInsets.all(6),
                                      decoration: BoxDecoration(
                                        color: Colors.cyanAccent.withValues(alpha: 0.1),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: const Icon(Icons.close, color: Colors.cyanAccent, size: 20),
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
                                    style: TextStyle(color: Colors.grey.shade300, height: 1.8, fontSize: 15),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                 if (isEditorExpanded)
                    Positioned.fill(
                      child: Stack(
                        children: [
                          const BgGradient(),
                          SafeArea(
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(16, 16, 16, 24),
                              child: DebugCodeEditor(
                                buggyCode: workingCodeBuffer,
                                language: widget.language,
                                onRun: _runAndVerifyCode,
                                onCodeChanged: _updateCodeBuffer,
                                isCompiling: isCompiling,
                                evaluationPassed: evaluationPassed,
                                onNextProblem: () {
                                  closeEditor();
                                  widget.onSuccessCleared();
                                },
                                isFullscreen: true,
                                onCloseFullscreen: closeEditor, ),
                            ),
                          ),
                        ],
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

  Widget _buildHeaderCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _glassCardDecoration(),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.cyanAccent.withValues(alpha: 0.1),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.2)),
            ),
            child: const Icon(Icons.bug_report_rounded, color: Colors.cyanAccent, size: 28),
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "DE-BUG FORGE",
                style: GoogleFonts.orbitron(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 16, letterSpacing: 1.2),
              ),
              const SizedBox(height: 6),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.cyanAccent.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(6),
                ),
                child: Text(
                  "+${widget.pointsPreview} POINTS ON VERIFY",
                  style: GoogleFonts.orbitron(color: Colors.cyanAccent, fontSize: 10, fontWeight: FontWeight.bold),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  BoxDecoration _glassCardDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(20),
      gradient: RadialGradient(
        radius: 3,
        colors: [
          Colors.cyanAccent.withValues(alpha: 0.08),
          Colors.white.withValues(alpha: 0.03),
        ],
      ),
      border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.2)),
      boxShadow: [
        BoxShadow(
          color: Colors.black.withValues(alpha: 0.3),
          blurRadius: 15,
          offset: const Offset(0, 5),
        ),
      ],
    );
  }
}