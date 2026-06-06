import 'package:anxicode_app/Learning/mod/quiz_result.dart';
import 'package:anxicode_app/Rank_System/rank_progress_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class ResultScreen extends ConsumerStatefulWidget {
  final QuizResult result;
  final String languageId;
  final VoidCallback nextPage;
  final VoidCallback onResetChallenge;
  final int totalTopicsCount; // Holds the total number of topics in this part

  const ResultScreen({
    super.key,
    required this.result,
    required this.languageId,
    required this.nextPage,
    required this.onResetChallenge,
    required this.totalTopicsCount,
  });

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {
  bool isPassed = false;
  int calculatedPointsEarned = 0;

  @override
  void initState() {
    super.initState();
    _processQuizResult();
  }

  void _processQuizResult() {
    if (widget.result.percentage >= 65.0) {
      isPassed = true;
      final int topicsCount = widget.totalTopicsCount > 0 ? widget.totalTopicsCount : 1;
      calculatedPointsEarned = (60.0 / topicsCount).round();

      WidgetsBinding.instance.addPostFrameCallback((_) async {
        try {
          final notifier = ref.read(userLanguageProgressProvider(widget.languageId).notifier);
          await notifier.updateXp(calculatedPointsEarned);
          await notifier.updateTopicIndex();
        } catch (_) {}
      });
    } else {
      isPassed = false;
      calculatedPointsEarned = 0;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        const BgGradient(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            centerTitle: true,
            leading: const BackButton(color: Colors.white),
            title: Text(
              "RESULT",
              style: GoogleFonts.orbitron(
                color: Colors.cyanAccent,
                fontSize: 18,
                fontWeight: FontWeight.bold,
                letterSpacing: 2,
              ),
            ),
          ),
          body: SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    /// TOP CARD
                    Container(
                      padding: const EdgeInsets.all(18),
                      decoration: _glassDecoration(),
                      child: Column(
                        children: [
                          Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      widget.result.topicName.toUpperCase(),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.manrope(
                                        color: Colors.white,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      widget.result.subjectName,
                                      style: GoogleFonts.manrope(
                                        color: Colors.cyanAccent,
                                        fontSize: 12,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 18),

                          Row(
                            children: [
                              SizedBox(
                                width: 92,
                                height: 92,
                                child: TweenAnimationBuilder<double>(
                                  tween: Tween<double>(
                                    begin: 0.0,
                                    end: widget.result.correctAnswers.toDouble(),
                                  ),
                                  duration: const Duration(milliseconds: 1200),
                                  builder: (context, value, child) {
                                    return Stack(
                                      alignment: Alignment.center,
                                      children: [
                                        SizedBox(
                                          width: 92,
                                          height: 92,
                                          child: CircularProgressIndicator(
                                            value: widget.result.totalQuestions == 0
                                                ? 0.0
                                                : value / widget.result.totalQuestions,
                                            strokeWidth: 7,
                                            strokeCap: StrokeCap.round,
                                            backgroundColor: Colors.white.withValues(alpha: 0.06),
                                            valueColor: const AlwaysStoppedAnimation(
                                              Colors.cyanAccent,
                                            ),
                                          ),
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          children: [
                                            Text(
                                              "${value.toInt()}/${widget.result.totalQuestions}",
                                              style: GoogleFonts.orbitron(
                                                color: Colors.white,
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            Text(
                                              "score",
                                              style: GoogleFonts.manrope(
                                                color: Colors.white54,
                                                fontSize: 10,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ],
                                    );
                                  },
                                ),
                              ),
                              const SizedBox(width: 18),
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      isPassed ? "Excellent Work 🚀" : "Review Required 🔴",
                                      style: GoogleFonts.orbitron(
                                        color: Colors.white,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    const SizedBox(height: 8),
                                    RichText(
                                      text: TextSpan(
                                        style: GoogleFonts.manrope(
                                          color: Colors.white70,
                                          fontSize: 13,
                                          height: 1.5,
                                        ),
                                        children: [
                                          TextSpan(text: isPassed ? "You passed this quiz with " : "You scored "),
                                          TextSpan(
                                            text: "${widget.result.percentage.toStringAsFixed(0)}%",
                                            style: TextStyle(
                                              color: isPassed ? Colors.cyanAccent : Colors.redAccent,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          TextSpan(text: isPassed ? " accuracy." : " accuracy. Minimum 65% needed."),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),

                          if (isPassed) ...[
                            const SizedBox(height: 14),
                            Container(
                              padding: const EdgeInsets.symmetric(vertical: 6, horizontal: 12),
                              decoration: BoxDecoration(
                                color: Colors.cyanAccent.withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(color: Colors.cyanAccent.withValues(alpha: 0.25)),
                              ),
                              child: Row(
                                mainAxisSize: MainAxisSize.min,
                                children: [
                                  const Icon(Icons.bolt, color: Colors.cyanAccent, size: 16),
                                  const SizedBox(width: 6),
                                  Text(
                                    "+$calculatedPointsEarned POINTS ADDED TO PROGRESS",
                                    style: GoogleFonts.orbitron(
                                      color: Colors.cyanAccent,
                                      fontSize: 10,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ]
                        ],
                      ),
                    ),

                    const SizedBox(height: 16),
                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            value: widget.result.correctAnswers,
                            subtitle: "Correct",
                            titleColor: Colors.greenAccent,
                            icon: Icons.check_circle_rounded,
                            iconColor: Colors.greenAccent,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _statCard(
                            value: widget.result.wrongAnswers,
                            subtitle: "Wrong",
                            titleColor: Colors.redAccent,
                            icon: Icons.cancel_rounded,
                            iconColor: Colors.redAccent,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 14),

                    Row(
                      children: [
                        Expanded(
                          child: _statCard(
                            duration: widget.result.totalTime,
                            subtitle: "Total Time",
                            titleColor: Colors.cyanAccent,
                            icon: Icons.timer_outlined,
                            iconColor: Colors.cyanAccent,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: _statCard(
                            duration: widget.result.avgTimePerAnswer,
                            subtitle: "Avg / Answer",
                            titleColor: Colors.orangeAccent,
                            icon: Icons.alarm,
                            iconColor: Colors.orangeAccent,
                          ),
                        ),
                      ],
                    ),

                    const SizedBox(height: 16),

                    Container(
                      decoration: _glassDecoration(),
                      child: Theme(
                        data: Theme.of(context).copyWith(dividerColor: Colors.transparent),
                        child: ExpansionTile(
                          tilePadding: const EdgeInsets.symmetric(horizontal: 18, vertical: 2),
                          childrenPadding: const EdgeInsets.fromLTRB(18, 0, 18, 18),
                          collapsedIconColor: Colors.cyanAccent,
                          iconColor: Colors.cyanAccent,
                          title: Text(
                            "CHECK ANSWERS",
                            style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontSize: 13,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: widget.result.answers.length,
                              itemBuilder: (context, index) {
                                final item = widget.result.answers[index];

                                return Container(
                                  margin: const EdgeInsets.only(top: 10),
                                  padding: const EdgeInsets.all(14),
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    color: Colors.black.withValues(alpha: 0.18),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Icon(
                                        item.isCorrect ? Icons.check_circle : Icons.cancel,
                                        color: item.isCorrect ? Colors.greenAccent : Colors.redAccent,
                                        size: 20,
                                      ),
                                      const SizedBox(width: 12),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment: CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              item.question,
                                              style: GoogleFonts.manrope(
                                                color: Colors.white,
                                                fontSize: 13,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            const SizedBox(height: 6),
                                            Text(
                                              "Correct Answer: ${item.answer}",
                                              style: GoogleFonts.manrope(
                                                color: Colors.white70,
                                                fontSize: 12,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    GestureDetector(
                      onTap: widget.onResetChallenge,
                      child: Container(
                        height: 58,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          gradient: LinearGradient(
                            colors: [
                              Colors.cyanAccent.withValues(alpha: 0.9),
                              Colors.blueAccent.withValues(alpha: 0.9),
                            ],
                          ),
                        ),
                        child: const Center(
                          child: Text(
                            "TRY AGAIN",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 16),

                    IgnorePointer(
                      ignoring: !isPassed,
                      child: AnimatedOpacity(
                        duration: const Duration(milliseconds: 250),
                        opacity: isPassed ? 1.0 : 0.3,
                        child: Container(
                          height: 82,
                          padding: const EdgeInsets.symmetric(horizontal: 18),
                          decoration: _glassDecoration(),
                          child: Row(
                            children: [
                              Expanded(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Next Topic",
                                      style: GoogleFonts.manrope(
                                        color: Colors.white60,
                                        fontSize: 11,
                                        fontWeight: FontWeight.w600,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      isPassed ? widget.result.nextChapter.toUpperCase() : "LOCKED (SCORE >= 65%)",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: GoogleFonts.manrope(
                                        color: isPassed ? Colors.white : Colors.white38,
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              GestureDetector(
                                onTap: widget.nextPage,
                                child: Container(
                                  width: 58,
                                  height: 46,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(18),
                                    gradient: LinearGradient(
                                      colors: [
                                        Colors.cyanAccent.withValues(alpha: 0.9),
                                        Colors.blueAccent.withValues(alpha: 0.9),
                                      ],
                                    ),
                                  ),
                                  child: const Icon(
                                    Icons.arrow_forward_rounded,
                                    color: Colors.black,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),

                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  static BoxDecoration _glassDecoration() {
    return BoxDecoration(
      borderRadius: BorderRadius.circular(28),
      gradient: RadialGradient(
        radius: 3,
        colors: [
          Colors.cyanAccent.withValues(alpha: 0.1),
          Colors.white.withValues(alpha: 0.1),
        ],
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.cyanAccent.withValues(alpha: 0.08),
          blurRadius: 18,
          spreadRadius: 1,
        ),
      ],
    );
  }

  Widget _statCard({
    int? value,
    Duration? duration,
    required String subtitle,
    required Color titleColor,
    required IconData icon,
    required Color iconColor,
  }) {
    return Container(
      height: 105,
      padding: const EdgeInsets.all(14),
      decoration: _glassDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(icon, color: iconColor, size: 20),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Column(
                children: [
                  TweenAnimationBuilder<double>(
                    tween: Tween<double>(
                      begin: 0,
                      end: value != null
                          ? value.toDouble()
                          : (duration?.inSeconds.toDouble() ?? 0.0),
                    ),
                    duration: const Duration(milliseconds: 1200),
                    builder: (context, animatedValue, child) {
                      final String displayText = value != null
                          ? animatedValue.toInt().toString()
                          : _formatDuration(Duration(seconds: animatedValue.toInt()));

                      return Text(
                        displayText,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.orbitron(
                          color: titleColor,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                  const SizedBox(height: 3),
                  Text(
                    subtitle,
                    style: GoogleFonts.manrope(
                      color: Colors.white70,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              )
            ],
          ),
        ],
      ),
    );
  }

  String _formatDuration(Duration duration) {
    final minutes = duration.inMinutes.remainder(60).toString().padLeft(2, '0');
    final seconds = duration.inSeconds.remainder(60).toString().padLeft(2, '0');
    return "${minutes}m ${seconds}s";
  }
}