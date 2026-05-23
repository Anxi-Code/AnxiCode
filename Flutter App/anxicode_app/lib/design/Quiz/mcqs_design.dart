import 'package:anxicode_app/Learning/mod/mcqs_main.dart';
import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Mcqs extends ConsumerStatefulWidget {
  final String path;

  const Mcqs({
    super.key,
    required this.path,
  });

  @override
  ConsumerState<Mcqs> createState() => _McqsState();
}

class _McqsState extends ConsumerState<Mcqs> {
  late McqQuiz quiz;
  bool isLoading = true;
  int currentPage = 0;
  int selectedIndex = -1;

  final PageController _controller = PageController();

  @override
  void initState() {
    super.initState();
    _loadQuiz();
  }

  Future<void> _loadQuiz() async {
    final service = ref.read(learningServiceProvider);
    final data = await service.getQuiz(widget.path);
    setState(() {
      quiz = data;
      isLoading = false;
    });
  }

  void nextPage() {
    if (currentPage < quiz.quizzes.length - 1) {
      currentPage++;
      selectedIndex = -1;

      _controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      setState(() {});
    }
  }

  void previousPage() {
    if (currentPage > 0) {
      currentPage--;
      selectedIndex = -1;

      _controller.animateToPage(
        currentPage,
        duration: const Duration(milliseconds: 400),
        curve: Curves.easeInOut,
      );

      setState(() {});
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
            title: Text(
              quiz.language,
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: const BackButton(color: Colors.white),
          ),

          body: isLoading
              ? const Center(
            child: CircularProgressIndicator(
              color: Colors.cyanAccent,
            ),
          )
              : Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                child: Text(
                  "${quiz.topic.toUpperCase()} • ${quiz.part}",
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              Expanded(
                child: PageView.builder(
                  controller: _controller,
                  itemCount: quiz.quizzes.length,
                  onPageChanged: (index) {
                    setState(() {
                      currentPage = index;
                      selectedIndex = -1;
                    });
                  },
                  itemBuilder: (context, index) {
                    final q = quiz.quizzes[index];

                    final options = q.options;

                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20),
                          child: Text(
                            "Q. ${index + 1}/${quiz.quizzes.length}",
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                          ),
                          child: Text(
                            q.question,
                            style: GoogleFonts.orbitron(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),

                        const SizedBox(height: 20),

                        Expanded(
                          child: ListView.builder(
                            itemCount: options.length,
                            itemBuilder: (context, i) {
                              final isSelected = selectedIndex == i;
                              final isCorrect =
                                  selectedIndex != -1 &&
                                      i == q.answer;

                              return Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 20,
                                  vertical: 10,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedIndex = i;
                                    });
                                  },
                                  child: Container(
                                    height: 70,
                                    decoration: BoxDecoration(
                                      borderRadius:
                                      BorderRadius.circular(20),
                                      border: Border.all(
                                        color: isSelected
                                            ? Colors.cyanAccent
                                            : Colors.transparent,
                                        width: 1.5,
                                      ),
                                      boxShadow: isSelected
                                          ? [
                                        BoxShadow(
                                          color: Colors.cyanAccent
                                              .withOpacity(0.4),
                                          blurRadius: 15,
                                          spreadRadius: 3,
                                        )
                                      ]
                                          : [],
                                      gradient: RadialGradient(
                                        radius: 4,
                                        colors: [
                                          Colors.cyanAccent
                                              .withOpacity(0.3),
                                          Colors.white.withOpacity(0.1),
                                        ],
                                      ),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(14),
                                      child: Row(
                                        children: [
                                          Text(
                                            "${String.fromCharCode(65 + i)}.",
                                            style: GoogleFonts.orbitron(
                                              color: isSelected
                                                  ? Colors.cyanAccent
                                                  : Colors.white,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          const SizedBox(width: 10),
                                          Expanded(
                                            child: Text(
                                              options[i],
                                              style:
                                              GoogleFonts.orbitron(
                                                color: isSelected
                                                    ? Colors.cyanAccent
                                                    : Colors.white,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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

              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    ElevatedButton(
                      onPressed: previousPage,
                      child: const Text("Previous"),
                    ),
                    ElevatedButton(
                      onPressed: nextPage,
                      child: Text(
                        currentPage == quiz.quizzes.length - 1
                            ? "Submit"
                            : "Next",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}