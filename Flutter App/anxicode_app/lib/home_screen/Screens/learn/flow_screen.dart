import 'package:anxicode_app/Learning/mod/part1.dart';
import 'package:anxicode_app/Rank_System/rank_progress_provider.dart';
import 'package:anxicode_app/home_screen/Screens/learn/part1_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Part1Flow extends ConsumerStatefulWidget {
  final List<Part1Topic> part1topics;
  final String slug;
  final String languageId;

  const Part1Flow({
    super.key,
    required this.slug,
    required this.part1topics,
    required this.languageId,
  });

  @override
  ConsumerState<Part1Flow> createState() => _Part1FlowState();
}

class _Part1FlowState extends ConsumerState<Part1Flow> {
  PageController? _controller;
  int? _lastInitializedIndex;

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void nextPage() {
    _controller?.nextPage(
      duration: const Duration(milliseconds: 300),
      curve: Curves.easeIn,
    );
  }

  Future<void> handleFlowCompletion() async {
    try {
      await ref
          .read(userLanguageProgressProvider(widget.languageId).notifier)
          .updateRankPart(2);

      await ref
          .read(userLanguageProgressProvider(widget.languageId).notifier)
          .saveToDatabase();

      if (mounted) {
        Navigator.pop(context);
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
              "Part 1 Completed! Concept Mastery Lab Unlocked.",
              style: GoogleFonts.orbitron(),
            ),
            backgroundColor: Colors.cyanAccent,
          ),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Failed to save progress: $e")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressAsync = ref.watch(userLanguageProgressProvider(widget.languageId));

    return Scaffold(
      backgroundColor: Colors.black,
      body: progressAsync.when(
        loading: () => const Center(
          child: CircularProgressIndicator(color: Colors.cyanAccent),
        ),
        error: (err, _) => Center(
          child: Text(
            "Error loading flow: $err",
            style: GoogleFonts.orbitron(color: Colors.red),
          ),
        ),
        data: (userProgress) {
          if (widget.part1topics.isEmpty) {
            return Center(
              child: Text(
                "No learning content available for this section.",
                style: GoogleFonts.orbitron(color: Colors.white),
              ),
            );
          }

          int savedTopicIndex = userProgress?.currentTopicIndex ?? 0;
          if (savedTopicIndex >= widget.part1topics.length) {
            savedTopicIndex = widget.part1topics.length - 1;
          }

          if (_controller == null || _lastInitializedIndex != savedTopicIndex) {
            _controller?.dispose();
            _controller = PageController(initialPage: savedTopicIndex);
            _lastInitializedIndex = savedTopicIndex;
          }

          return PageView.builder(
            controller: _controller,
            itemCount: widget.part1topics.length,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              final currentTopic = widget.part1topics[index];
              final bool isLastPage = index == widget.part1topics.length - 1;

              final String nextButtonLabel = isLastPage
                  ? "Finish Part"
                  : widget.part1topics[index + 1].topicName;

              return Part1Screen(
                slug: widget.slug,
                languageId: widget.languageId,
                part1topic: currentTopic,
                nextTopic: nextButtonLabel,
                nextPage: isLastPage ? handleFlowCompletion : nextPage,
                totalTopicsCount: widget.part1topics.length,
              );
            },
          );
        },
      ),
    );
  }
}