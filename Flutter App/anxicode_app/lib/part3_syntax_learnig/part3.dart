import 'dart:ui';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/part3_syntax_learnig/part3_model.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SyntaxForge extends StatefulWidget {
  final SyntaxChallenge challenge;
  final VoidCallback onNext; // ADDED: Triggered when user clicks the Next button

  const SyntaxForge({
    super.key,
    required this.challenge,
    required this.onNext, // Make sure to pass this from your parent screen!
  });

  @override
  State<SyntaxForge> createState() => _SyntaxForgeState();
}

class _SyntaxForgeState extends State<SyntaxForge> {
  final LinearGradient buttonGradient = const LinearGradient(
    colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
  );

  late List<TextEditingController> _blankControllers;
  // Tracks validation state of each box: null = unchecked, true = correct, false = wrong
  late List<bool?> _fieldValidations;

  bool _isEditorExpanded = false;
  bool _showResult = false;
  bool _isCorrect = false;
  String _resultMessage = '';

  @override
  void initState() {
    super.initState();
    final blankCount = widget.challenge.templateParts.length - 1;

    _blankControllers = List.generate(blankCount, (_) => TextEditingController());
    _fieldValidations = List.generate(blankCount, (_) => null);

    // Listeners: If user starts typing in a red/green box, reset its validation state
    for (int i = 0; i < _blankControllers.length; i++) {
      _blankControllers[i].addListener(() {
        if (_fieldValidations[i] != null) {
          setState(() {
            _fieldValidations[i] = null;
            _showResult = false;
            _isCorrect = false; // Reset to false so the "Verify" button comes back!
          });
        }
      });
    }
  }

  @override
  void dispose() {
    for (final c in _blankControllers) {
      c.dispose();
    }
    super.dispose();
  }

  void _verifySyntax() {
    FocusScope.of(context).unfocus();

    bool allCorrect = true;
    final correctList = widget.challenge.correctAnswers;

    setState(() {
      for (int i = 0; i < _blankControllers.length; i++) {
        final userInput = _blankControllers[i].text.trim();
        final expected = correctList[i].trim();

        bool isMatch = (userInput == expected);
        _fieldValidations[i] = isMatch;

        if (!isMatch) {
          allCorrect = false;
        }
      }

      _showResult = true;
      _isCorrect = allCorrect;
      _resultMessage = allCorrect
          ? '✓ Syntax verified! Well done.'
          : '✗ Some syntax is incorrect. Check the red boxes.';
    });

    // We removed the 3-second auto-hide for correct answers so the Next button
    // and the green banner stay on the screen until the user taps Next.
    if (!allCorrect) {
      Future.delayed(const Duration(seconds: 3), () {
        if (mounted && !_isCorrect) setState(() => _showResult = false);
      });
    }
  }

  void _toggleEditorExpanded() {
    FocusScope.of(context).unfocus();
    setState(() => _isEditorExpanded = !_isEditorExpanded);
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
              title: Text(
                "Syntax Forge",
                style: GoogleFonts.orbitron(
                  color: Colors.cyanAccent,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
              leading: const BackButton(color: Colors.white),
            ),
            body: SafeArea(
              child: Stack(
                children: [
                  // ----- MAIN CONTENT -----
                  SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 80),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        _buildHeader(),
                        const SizedBox(height: 20),
                        _buildTopicCard(),
                        const SizedBox(height: 20),
                        _buildHintCard(),
                        const SizedBox(height: 20),
                        _buildBlanksEditorCard(isExpanded: false),
                        const SizedBox(height: 30),

                        // Condition: Show Next if completely correct, otherwise Verify
                        _isCorrect ? _buildNextButton() : _buildVerifyButton(),

                        if (_showResult) _buildResultBanner(),
                      ],
                    ),
                  ),

                  // ----- BLUR BACKDROP (for expanded editor) -----
                  if (_isEditorExpanded)
                    Positioned.fill(
                      child: GestureDetector(
                        onTap: _toggleEditorExpanded,
                        child: BackdropFilter(
                          filter: ImageFilter.blur(sigmaX: 12, sigmaY: 12),
                          child: Container(
                            color: Colors.black.withValues(alpha: 0.4),
                          ),
                        ),
                      ),
                    ),

                  // ----- EDITOR MODAL -----
                  if (_isEditorExpanded)
                    Positioned.fill(
                      child: Center(
                        child: SingleChildScrollView(
                          padding: EdgeInsets.only(
                              bottom: MediaQuery.of(context).viewInsets.bottom + 20),
                          child: Container(
                            margin: const EdgeInsets.symmetric(horizontal: 20),
                            child: _buildBlanksEditorCard(isExpanded: true),
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

  // ----- HEADER -----
  Widget _buildHeader() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      decoration: _glassCard(),
      child: Row(
        children: [
          Container(
            height: 55,
            width: 55,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: Colors.black.withValues(alpha: 0.2),
              border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
              boxShadow: [
                BoxShadow(
                  color: Colors.cyanAccent.withValues(alpha: 0.2),
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
                  widget.challenge.topic.toUpperCase(),
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    fontSize: 16,
                    letterSpacing: 1.2,
                  ),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
                const SizedBox(height: 6),
                Text(
                  "Rookie Rank",
                  style: GoogleFonts.orbitron(
                    color: Colors.cyanAccent.withValues(alpha: 0.8),
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ----- TASK CARD -----
  Widget _buildTopicCard() {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: _glassCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "TASK",
            style: GoogleFonts.orbitron(
              color: Colors.amber,
              fontWeight: FontWeight.bold,
              fontSize: 12,
              letterSpacing: 1.2,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            widget.challenge.taskDescription,
            style: TextStyle(
              color: Colors.grey.shade200,
              height: 1.6,
              fontSize: 15,
            ),
          ),
        ],
      ),
    );
  }

  // ----- HINT -----
  Widget _buildHintCard() {
    return Container(
      decoration: _glassCard(),
      child: Theme(
        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
        child: ExpansionTile(
          iconColor: Colors.yellowAccent,
          collapsedIconColor: Colors.yellowAccent.withValues(alpha: 0.7),
          title: Row(
            children: [
              const Icon(Icons.lightbulb_outline, color: Colors.yellowAccent, size: 22),
              const SizedBox(width: 12),
              Text(
                "Need a Hint?",
                style: GoogleFonts.orbitron(
                  color: Colors.yellowAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),
            ],
          ),
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  widget.challenge.hint,
                  style: TextStyle(
                    color: Colors.white.withValues(alpha: 0.85),
                    fontSize: 14,
                    height: 1.5,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ----- EDITOR CARD -----
  Widget _buildBlanksEditorCard({required bool isExpanded}) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: _glassCard().copyWith(
        border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.3)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "SYNTAX EDITOR",
                style: GoogleFonts.orbitron(
                  color: Colors.cyanAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 12,
                  letterSpacing: 1.2,
                ),
              ),
              InkWell(
                onTap: _toggleEditorExpanded,
                child: Icon(
                  isExpanded ? Icons.close_fullscreen : Icons.open_in_full,
                  color: Colors.cyanAccent,
                  size: 20,
                ),
              )
            ],
          ),
          const SizedBox(height: 16),
          _buildRichTextCode(isExpanded: isExpanded),
        ],
      ),
    );
  }

  // ----- THE RICH TEXT CODE RENDERER -----
  Widget _buildRichTextCode({required bool isExpanded}) {
    final parts = widget.challenge.templateParts;

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: const Color(0xFF12121A),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(
          color: Colors.cyanAccent.withValues(alpha: 0.2),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.5),
            blurRadius: 10,
          )
        ],
      ),
      child: RichText(
        text: TextSpan(
          style: const TextStyle(
            color: Colors.white,
            fontFamily: 'Courier',
            fontSize: 18,
            height: 2.0,
          ),
          children: List.generate(parts.length * 2 - 1, (index) {
            if (index.isEven) {
              return TextSpan(text: parts[index ~/ 2]);
            } else {
              final blankIndex = index ~/ 2;

              final isValid = _fieldValidations[blankIndex];
              Color fieldBorderColor = Colors.cyanAccent;
              Color fieldTextColor = Colors.amberAccent;
              Color fieldBgColor = const Color(0xFF1E1E2E);

              if (isValid == true) {
                fieldBorderColor = Colors.greenAccent;
                fieldTextColor = Colors.greenAccent;
                fieldBgColor = Colors.greenAccent.withValues(alpha: 0.1);
              } else if (isValid == false) {
                fieldBorderColor = Colors.redAccent;
                fieldTextColor = Colors.redAccent;
                fieldBgColor = Colors.redAccent.withValues(alpha: 0.1);
              }

              return WidgetSpan(
                alignment: PlaceholderAlignment.middle,
                child: Container(
                  width: isExpanded ? 130 : 110,
                  height: 42,
                  margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
                  child: TextField(
                    controller: _blankControllers[blankIndex],
                    style: TextStyle(
                      color: fieldTextColor,
                      fontFamily: 'Courier',
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.center,
                    decoration: InputDecoration(
                      isDense: true,
                      contentPadding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 8,
                      ),
                      filled: true,
                      fillColor: fieldBgColor,
                      border: OutlineInputBorder(
                        borderSide: BorderSide(color: fieldBorderColor),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: fieldBorderColor.withValues(alpha: 0.6),
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: fieldBorderColor,
                          width: 2,
                        ),
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
        ),
      ),
    );
  }

  // ----- VERIFY BUTTON -----
  Widget _buildVerifyButton() {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          gradient: buttonGradient,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: const Color(0xFF00C9A7).withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton(
          onPressed: _verifySyntax,
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
          child: Text(
            "VERIFY SYNTAX",
            style: GoogleFonts.orbitron(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1.2,
            ),
          ),
        ),
      ),
    );
  }

  // ----- NEW: NEXT BUTTON -----
  Widget _buildNextButton() {
    return SizedBox(
      height: 56,
      width: double.infinity,
      child: DecoratedBox(
        decoration: BoxDecoration(
          // Distinct green gradient to signify completion
          gradient: const LinearGradient(
            colors: [Color(0xFF00E676), Color(0xFF1DE9B6)],
          ),
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.greenAccent.withValues(alpha: 0.4),
              blurRadius: 12,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: ElevatedButton.icon(
          onPressed: widget.onNext, // Calls the function passed from the parent
          icon: const Icon(Icons.arrow_forward_rounded, color: Colors.black, size: 24),
          label: Text(
            "NEXT CHALLENGE",
            style: GoogleFonts.orbitron(
              color: Colors.black, // High contrast text
              fontWeight: FontWeight.bold,
              fontSize: 16,
              letterSpacing: 1.2,
            ),
          ),
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
          ),
        ),
      ),
    );
  }

  // ----- RESULT BANNER -----
  Widget _buildResultBanner() {
    return AnimatedOpacity(
      duration: const Duration(milliseconds: 400),
      opacity: _showResult ? 1.0 : 0.0,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 400),
        margin: const EdgeInsets.only(top: 20),
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        decoration: BoxDecoration(
          color: _isCorrect
              ? Colors.greenAccent.withValues(alpha: 0.15)
              : Colors.redAccent.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: _isCorrect ? Colors.greenAccent : Colors.redAccent,
            width: 2,
          ),
        ),
        child: Row(
          children: [
            Icon(
              _isCorrect ? Icons.check_circle : Icons.error_outline,
              color: _isCorrect ? Colors.greenAccent : Colors.redAccent,
              size: 28,
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Text(
                _resultMessage,
                style: GoogleFonts.orbitron(
                  color: _isCorrect ? Colors.greenAccent : Colors.redAccent,
                  fontWeight: FontWeight.bold,
                  fontSize: 14,
                  height: 1.4,
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
        borderRadius: BorderRadius.circular(20),
        gradient: RadialGradient(
          radius: 4,
          colors: [
            Colors.cyanAccent.withValues(alpha: 0.05),
            Colors.white.withValues(alpha: 0.08),
          ],
        ),
        border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.15)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.2),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ]
    );
  }
}