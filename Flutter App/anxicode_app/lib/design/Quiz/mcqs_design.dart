import 'package:anxicode_app/Learning/mod/answer_review.dart';
import 'package:anxicode_app/Learning/mod/mcqs_main.dart';
import 'package:anxicode_app/Learning/mod/quiz_result.dart';
import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:awesome_snackbar_content/awesome_snackbar_content.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Mcqs extends ConsumerStatefulWidget {
  final Function(QuizResult) goToResult;
  final String path;
  final String slug;
  final String nextTopic;

  const Mcqs({
    super.key,
    required this.goToResult,
    required this.slug,
    required this.path,
    required this.nextTopic,
  });

  @override
  ConsumerState<Mcqs> createState() => _McqsState();
}

class _McqsState extends ConsumerState<Mcqs> with SingleTickerProviderStateMixin {
  late McqQuiz quiz;
  bool isLoading = true;
  int currentPage = 0;

  Map<int, int> selectedAnswers = {};

  final PageController _controller = PageController();

  late AnimationController _timerController;
  final int totalDurationInSeconds = 120;
  bool isOver = false;

  bool _halfTimeWarningShown = false;
  bool _tenSecondWarningShown = false;

  int correct = 0;
  int wrong = 0;
  DateTime? startTime;

  QuizResult? result;
  List<AnswerReview> reviews = [];

  @override
  void initState() {
    super.initState();

    _timerController = AnimationController(
      vsync: this,
      duration: Duration(seconds: totalDurationInSeconds),
    );

    _timerController.addStatusListener((status) {
      if (status == AnimationStatus.dismissed) {
        setState(() {
          isOver = true;
        });
      }
    });

    _timerController.addListener(_checkTimerWarnings);

    _loadQuiz();
  }

  void _checkTimerWarnings() {
    final int remainingSeconds =
    (_timerController.duration!.inSeconds * _timerController.value).ceil();
    final int halfTime = totalDurationInSeconds ~/ 2;

    if (remainingSeconds == halfTime && !_halfTimeWarningShown) {
      _halfTimeWarningShown = true;
      _showWarning("Half time remaining!");
    } else if (remainingSeconds == 10 && !_tenSecondWarningShown) {
      _tenSecondWarningShown = true;
      _showWarning("Only 10 seconds left!", isCritical: true);
    }
  }

  void _showWarning(String message, {bool isCritical = false}) {
    if (!mounted) return;

    final snackBar = SnackBar(
      elevation: 0,
      behavior: SnackBarBehavior.floating,
      backgroundColor: Colors.transparent,
      duration: const Duration(seconds: 4),
      content: AwesomeSnackbarContent(
        title: isCritical ? 'Hurry Up!' : 'Time Alert',
        message: message,
        contentType: isCritical ? ContentType.failure : ContentType.warning,
      ),
    );

    ScaffoldMessenger.of(context)
      ..hideCurrentSnackBar()
      ..showSnackBar(snackBar);
  }

  Future<void> _loadQuiz() async {
    final service = ref.read(learningServiceProvider);
    final data = await service.getQuiz(widget.slug, widget.path);
    setState(() {
      quiz = data;
      isLoading = false;
      startTime = DateTime.now();
    });

    _timerController.reverse(from: 1.0);
  }

  @override
  void dispose() {
    _timerController.removeListener(_checkTimerWarnings);
    _timerController.dispose();
    _controller.dispose();
    super.dispose();
  }

  void nextPage() {
    final q = quiz.quizzes[currentPage];
    final selectedIndex = selectedAnswers[currentPage]!;
    final isAnsCorrect = selectedIndex == q.answer;
    final correctAnswerText = q.options[q.answer];

    reviews.add(
      AnswerReview(
        question: q.question,
        answer: correctAnswerText,
        isCorrect: isAnsCorrect,
      ),
    );

    if (isAnsCorrect) {
      correct++;
    } else {
      wrong++;
    }

    if (currentPage < quiz.quizzes.length - 1) {
      setState(() {
        currentPage++;
      });

      _controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );
    }
  }

  void onSubmit() {
    if (selectedAnswers.containsKey(currentPage) && !isOver) {
      final q = quiz.quizzes[currentPage];
      final selectedIndex = selectedAnswers[currentPage]!;
      final isAnsCorrect = selectedIndex == q.answer;
      final correctAnswerText = q.options[q.answer];

      reviews.add(
        AnswerReview(
          question: q.question,
          answer: correctAnswerText,
          isCorrect: isAnsCorrect,
        ),
      );

      if (isAnsCorrect) {
        correct++;
      } else {
        wrong++;
      }
    }

    final topicName = quiz.topic;
    final subjectName = widget.slug;
    final totalQuestions = quiz.quizzes.length;
    final correctAnswers = correct;
    final wrongAnswers = wrong;
    final percentage = totalQuestions > 0 ? (correctAnswers / totalQuestions) * 100 : 0.0;
    final endTime = DateTime.now();
    final totalTime = endTime.difference(startTime!);

    final avgTimeInSeconds = totalQuestions > 0 ? (totalTime.inSeconds ~/ totalQuestions) : 0;
    final Duration avgTimePerAnswer = Duration(seconds: avgTimeInSeconds);

    final nextChapter = widget.nextTopic;

    widget.goToResult(
      QuizResult(
        topicName: topicName,
        subjectName: subjectName.toUpperCase(),
        totalQuestions: totalQuestions,
        correctAnswers: correctAnswers,
        wrongAnswers: wrongAnswers,
        percentage: percentage,
        totalTime: totalTime,
        avgTimePerAnswer: avgTimePerAnswer,
        nextChapter: nextChapter,
        answers: reviews,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final bool isLastPage = !isLoading && currentPage == quiz.quizzes.length - 1;
    final bool hasSelectedCurrent = selectedAnswers.containsKey(currentPage);

    return Stack(
      children: [
        const BgGradient(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Quiz",
              style: GoogleFonts.orbitron(color: Colors.white, fontSize: 16),
            ),
          ),
          body: SafeArea(
            bottom: false,
            child: isLoading
                ? const Center(
              child: CircularProgressIndicator(
                color: Colors.cyanAccent,
              ),
            )
                : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 5),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        quiz.topic.toUpperCase(),
                        style: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 12),
                      AnimatedBuilder(
                        animation: _timerController,
                        builder: (context, child) {
                          final int remainingSeconds =
                          (_timerController.duration!.inSeconds *
                              _timerController.value)
                              .ceil();
                          final String minutesStr = (remainingSeconds ~/ 60)
                              .toString()
                              .padLeft(2, '0');
                          final String secondsStr = (remainingSeconds % 60)
                              .toString()
                              .padLeft(2, '0');

                          Color progressColor = Colors.cyanAccent;
                          if (remainingSeconds <= 10) {
                            progressColor = Colors.redAccent;
                          } else if (remainingSeconds <=
                              totalDurationInSeconds / 2) {
                            progressColor = Colors.yellowAccent;
                          }

                          return Column(
                            children: [
                              Row(
                                mainAxisAlignment:
                                MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "Time left",
                                    style: GoogleFonts.orbitron(
                                      color: Colors.white
                                          .withValues(alpha: 0.5),
                                      fontSize: 14,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      Icon(Icons.timer_outlined,
                                          color: progressColor, size: 18),
                                      const SizedBox(width: 4),
                                      Text(
                                        "$minutesStr:$secondsStr",
                                        style: GoogleFonts.orbitron(
                                          color: progressColor,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                              const SizedBox(height: 16),
                              LinearProgressIndicator(
                                value: _timerController.value,
                                minHeight: 10,
                                borderRadius: BorderRadius.circular(10),
                                color: progressColor,
                                backgroundColor:
                                Colors.white.withValues(alpha: 0.1),
                              ),
                            ],
                          );
                        },
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 20),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(35),
                        topRight: Radius.circular(35),
                      ),
                      gradient: RadialGradient(
                        radius: 3,
                        colors: [
                          Colors.cyanAccent.withValues(alpha: 0.1),
                          Colors.white.withValues(alpha: 0.1),
                        ],
                      ),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(20, 30, 20, 20),
                      child: AnimatedSwitcher(
                        duration: const Duration(milliseconds: 500),
                        switchInCurve: Curves.easeIn,
                        switchOutCurve: Curves.easeOut,
                        child: isOver
                            ? _buildTimeOverOverlay()
                            : Column(
                          key: const ValueKey('quiz_content'),
                          children: [
                            Expanded(
                              child: PageView.builder(
                                controller: _controller,
                                physics:
                                const NeverScrollableScrollPhysics(),
                                itemCount: quiz.quizzes.length,
                                itemBuilder: (context, index) {
                                  final q = quiz.quizzes[index];
                                  final options = q.options;

                                  return Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        "Q.${index + 1} / ${quiz.quizzes.length}",
                                        style: GoogleFonts.orbitron(
                                          color: Colors.white,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                      const SizedBox(height: 16),
                                      Text(
                                        q.question,
                                        style: GoogleFonts.orbitron(
                                          color: Colors.white,
                                          fontSize: 14,
                                          height: 1.5,
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      const SizedBox(height: 20),
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: options.length,
                                          itemBuilder: (context, i) {
                                            final isSelected =
                                                selectedAnswers[index] == i;

                                            return Padding(
                                              padding: const EdgeInsets
                                                  .only(bottom: 16),
                                              child: GestureDetector(
                                                onTap: () {
                                                  setState(() {
                                                    selectedAnswers[index] = i;
                                                  });
                                                },
                                                child: Container(
                                                  padding: const EdgeInsets
                                                      .symmetric(
                                                      horizontal: 20,
                                                      vertical: 18),
                                                  decoration: BoxDecoration(
                                                    gradient: RadialGradient(
                                                      radius: 3,
                                                      colors: [
                                                        Colors.cyanAccent
                                                            .withValues(
                                                            alpha: 0.10),
                                                        Colors.white
                                                            .withValues(
                                                            alpha: 0.08),
                                                      ],
                                                    ),
                                                    borderRadius:
                                                    BorderRadius.circular(16),
                                                    boxShadow: [
                                                      isSelected
                                                          ? BoxShadow(
                                                        color: Colors.cyanAccent
                                                            .withValues(
                                                            alpha: 0.2),
                                                        blurRadius: 12,
                                                        spreadRadius: 1,
                                                      )
                                                          : BoxShadow(
                                                        color: Colors.white
                                                            .withValues(
                                                            alpha: 0),
                                                        blurRadius: 0,
                                                      ),
                                                    ],
                                                    border: Border.all(
                                                      color: isSelected
                                                          ? Colors.cyanAccent
                                                          : Colors.transparent,
                                                      width: 1.5,
                                                    ),
                                                  ),
                                                  child: Row(
                                                    children: [
                                                      Text(
                                                        "${String.fromCharCode(65 + i)}.",
                                                        style: GoogleFonts.orbitron(
                                                          color: isSelected
                                                              ? Colors.cyanAccent
                                                              : Colors.white,
                                                          fontWeight:
                                                          FontWeight.bold,
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                      const SizedBox(width: 16),
                                                      Expanded(
                                                        child: Text(
                                                          options[i],
                                                          style: GoogleFonts.orbitron(
                                                            color: isSelected
                                                                ? Colors.cyanAccent
                                                                : Colors.white,
                                                            fontSize: 15,
                                                          ),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            );
                                          },
                                        ),
                                      ),
                                    ],
                                  );
                                },
                              ),
                            ),
                            AnimatedSwitcher(
                              duration: const Duration(milliseconds: 300),
                              transitionBuilder: (child, animation) =>
                                  ScaleTransition(
                                      scale: animation, child: child),
                              child: hasSelectedCurrent
                                  ? (isLastPage
                                  ? SizedBox(
                                key: const ValueKey('submit'),
                                width: double.infinity,
                                height: 55,
                                child: _buildActionButton(
                                  label: "Submit",
                                  color: Colors.cyanAccent,
                                  onPressed: onSubmit,
                                ),
                              )
                                  : Align(
                                key: const ValueKey('next'),
                                alignment: Alignment.bottomRight,
                                child: SizedBox(
                                  height: 55,
                                  child: _buildActionButton(
                                    label: "Next",
                                    color: Colors.cyanAccent,
                                    onPressed: nextPage,
                                  ),
                                ),
                              ))
                                  : const SizedBox(
                                  key: ValueKey('empty'), height: 55),
                            ),
                          ],
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
    );
  }

  Widget _buildTimeOverOverlay() {
    return Center(
      key: const ValueKey('time_over'),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            "TIME OVER",
            style: GoogleFonts.orbitron(
              fontSize: 40,
              fontWeight: FontWeight.bold,
              color: Colors.cyanAccent,
              letterSpacing: 4,
            ),
          ),
          const SizedBox(height: 32),
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              onPressed: onSubmit,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.cyanAccent,
                foregroundColor: Colors.black,
                elevation: 5,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: Text(
                "SUBMIT NOW",
                style: GoogleFonts.orbitron(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildActionButton({
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return ElevatedButton(
      onPressed: onPressed,
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        foregroundColor: Colors.black,
        elevation: 0,
        padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 14),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: Text(
        label,
        style: GoogleFonts.orbitron(
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}