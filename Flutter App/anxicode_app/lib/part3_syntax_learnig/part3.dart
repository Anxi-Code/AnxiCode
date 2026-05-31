import 'dart:ui';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/part3_syntax_learnig/part3_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SyntaxForge extends StatefulWidget {
  final SyntaxChallenge challenge;

  const SyntaxForge({super.key, required this.challenge});

  @override
  State<SyntaxForge> createState() => _SyntaxForgeState();
}

class _SyntaxForgeState extends State<SyntaxForge> {
  final LinearGradient buttonGradient = const LinearGradient(
    colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
  );
  late List<TextEditingController> _blankControllers;

  bool _isMissionExpanded = false;
  bool _showResult = false;
  bool _isCorrect = false;
  String _resultMessage = '';

  @override
  void initState() {
    super.initState();
    // Initialize one controller per blank (templateParts length - 1)
    _blankControllers = List.generate(
      widget.challenge.templateParts.length - 1,
      (_) => TextEditingController(),
    );
  }

  @override
  void dispose() {
    for (final c in _blankControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _verifySyntax() {
    bool allCorrect = true;
    final correctList = widget.challenge.correctAnswers;

    for (int i = 0; i < _blankControllers.length; i++) {
      final userInput = _blankControllers[i].text.trim();
      final expected = correctList[i].trim();
      if (userInput != expected) {
        allCorrect = false;
        break;
      }
    }

    setState(() {
      _showResult = true;
      _isCorrect = allCorrect;
      _resultMessage =
          allCorrect
              ? '✓ Syntax verified! Well done, Agent.'
              : '✗ Incorrect syntax. Check the hint and try again.';
    });

    // Auto-hide result after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _showResult = false);
      }
    });
  }

  void _openMission() => setState(() => _isMissionExpanded = true);
  void _closeMission() => setState(() => _isMissionExpanded = false);

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return AnimatedPadding(
      duration: const Duration(milliseconds: 150),
      padding: EdgeInsets.only(bottom: keyboardHeight),
      child: Stack(
        children: [
          BgGradient(),
          // ----- MAIN CONTENT -----
          SafeArea(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _buildHeader(),
                  const SizedBox(height: 15),
                  _buildTopicCard(),
                  const SizedBox(height: 15),
                  _buildHintCard(),
                  const SizedBox(height: 15),
                  _buildBlanksEditor(),
                  const SizedBox(height: 10),
                  _buildVerifyButton(),
                  if (_showResult) _buildResultBanner(),
                ],
              ),
            ),
          ),

          // ----- BLUR BACKDROP (for expanded mission) -----
          if (_isMissionExpanded)
            Positioned.fill(
              child: GestureDetector(
                onTap: _closeMission,
                child: BackdropFilter(
                  filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                  child: Container(color: Colors.black.withValues(alpha: 0.35)),
                ),
              ),
            ),

          // ----- MISSION MODAL -----
          if (_isMissionExpanded)
            Positioned.fill(
              child: Center(
                child: Container(
                  margin: const EdgeInsets.all(20),
                  padding: const EdgeInsets.all(18),
                  decoration: _glassCard(),
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
                            onTap: _closeMission,
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
                            widget.challenge.taskDescription,
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
        ],
      ),
    );
  }

  // ----- HEADER -----
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: _glassCard(),
      child: Row(
        children: [
          Container(
            height: 50,
            width: 50,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.4),
                  blurRadius: 15,
                ),
              ],
            ),
            child: const Icon(
              Icons.code_rounded,
              color: Colors.cyanAccent,
              size: 30,
            ),
          ),
          const SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "ANXICODE: SYNTAX FORGE",
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  "Rookie Rank",
                  style: GoogleFonts.orbitron(
                    color: Colors.grey.shade400,
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----- TOPIC + TASK -----
  Widget _buildTopicCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: _glassCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.topic, color: Colors.cyanAccent),
              const SizedBox(width: 8),
              Text(
                "TOPIC",
                style: GoogleFonts.orbitron(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 11,
                ),
              ),
              const Spacer(),
              Text(
                widget.challenge.topic,
                style: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            "TASK",
            style: GoogleFonts.orbitron(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 6),
          Text(
            widget.challenge.taskDescription,
            style: TextStyle(
              color: Colors.grey.shade300,
              height: 1.5,
              fontSize: 14,
            ),
          ),
          const SizedBox(height: 10),
          InkWell(
            onTap: _openMission,
            borderRadius: BorderRadius.circular(6),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  Icons.open_in_full,
                  size: 16,
                  color: Colors.amber.shade200,
                ),
                const SizedBox(width: 4),
                Text(
                  "Expand mission",
                  style: TextStyle(color: Colors.amber.shade200, fontSize: 12),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----- HINT -----
  Widget _buildHintCard() {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: _glassCard(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(Icons.lightbulb_outline, color: Colors.yellowAccent),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              "HINT: ${widget.challenge.hint}",
              style: TextStyle(
                color: Colors.yellowAccent.withValues(alpha: 0.9),
                fontSize: 13,
                height: 1.4,
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----- EDITOR: Partial Fill In The Blanks -----
  Widget _buildBlanksEditor() {
    final parts = widget.challenge.templateParts;
    final controllers = _blankControllers;

    return Container(
      padding: const EdgeInsets.all(10),
      decoration: _glassCard().copyWith(
        border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "SYNTAX EDITOR",
            style: GoogleFonts.orbitron(
              color: Colors.cyanAccent,
              fontWeight: FontWeight.bold,
              fontSize: 11,
            ),
          ),
          const SizedBox(height: 12),
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.black.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(10),
              border: Border.all(
                color: Colors.cyanAccent.withValues(alpha: 0.15),
              ),
            ),
            // Using RichText with WidgetSpan perfectly aligns the inputs inline with the code
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'Courier',
                  fontSize: 16,
                  height: 1.8, // Gives the text fields breathing room
                ),
                children: List.generate(parts.length * 2 - 1, (index) {
                  if (index.isEven) {
                    // Text part
                    return TextSpan(text: parts[index ~/ 2]);
                  } else {
                    // Blank field locked inline
                    final blankIndex = index ~/ 2;
                    return WidgetSpan(
                      alignment: PlaceholderAlignment.middle,
                      child: Container(
                        width: 90, // Set standard blank size
                        height:
                            32, // Lock height so it doesn't break syntax alignment
                        margin: const EdgeInsets.symmetric(horizontal: 4),
                        child: TextField(
                          controller: controllers[blankIndex],
                          style: const TextStyle(
                            color: Colors.amber,
                            fontFamily: 'Courier',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                          textAlign: TextAlign.center,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 4,
                              horizontal: 4,
                            ),
                            filled: true,
                            fillColor: Color(0xFF1E1E2E),
                            border: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyanAccent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.cyanAccent),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                color: Colors.amberAccent,
                                width: 2,
                              ),
                              borderRadius: BorderRadius.all(
                                Radius.circular(6),
                              ),
                            ),
                          ),
                        ),
                      ),
                    );
                  }
                }),
              ),
            ),
          ),
        ],
      ),
    );
  }

  // ----- VERIFY BUTTON -----
  Widget _buildVerifyButton() {
    // Upgraded gradient: Electric Blue to Cyan
    const gradient = LinearGradient(
      colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
    );

    return SizedBox(
      height: 48,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: gradient,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00E5FF).withValues(alpha: 0.3),
              blurRadius: 8,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: _verifySyntax,
          icon: const Icon(Icons.check_circle_outline, color: Colors.white),
          label: Text(
            "VERIFY SYNTAX",
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
    );
  }

  // ----- RESULT BANNER (animated) -----
  Widget _buildResultBanner() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: _showResult ? 1.0 : 0.0,
      child: Container(
        margin: const EdgeInsets.only(top: 10),
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
        decoration: BoxDecoration(
          color:
              _isCorrect
                  ? Colors.greenAccent.withValues(alpha: 0.15)
                  : Colors.redAccent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: _isCorrect ? Colors.greenAccent : Colors.redAccent,
            width: 1.5,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _isCorrect ? Icons.check_circle : Icons.cancel,
              color: _isCorrect ? Colors.greenAccent : Colors.redAccent,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                _resultMessage,
                style: GoogleFonts.orbitron(
                  color: _isCorrect ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----- HELPER: glass card decoration -----
  BoxDecoration _glassCard() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(15),
      gradient: RadialGradient(
        radius: 4,
        colors: [
          Colors.cyanAccent.withValues(alpha: 0.10),
          Colors.white.withValues(alpha: 0.15),
        ],
      ),
      border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.15)),
    );
  }
}
