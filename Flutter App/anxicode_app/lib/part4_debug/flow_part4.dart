import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/Rank_System/rank_progress_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/part4_debug/part4_debug.dart';
import 'package:anxicode_app/part4_debug/part4_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/python.dart';

class Part4Flow extends ConsumerStatefulWidget {
  final String path;
  final String slug;
  final String languageId;
  final String rankName;


  const Part4Flow({
    super.key,
    required this.path,
    required this.slug,
    required this.languageId,
    required this.rankName
  });

  @override
  ConsumerState<Part4Flow> createState() => _Part4FlowState();
}

class _Part4FlowState extends ConsumerState<Part4Flow> {
  PageController? _controller;
  int? _lastInitializedIndex;
  Future<DebuggingData>? challengesFuture;

  @override
  void initState() {
    super.initState();
    loadDebugChallenges();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void loadDebugChallenges() {
    final learningService = ref.read(learningServiceProvider);
    setState(() {
      challengesFuture = learningService.getDebuggingTasks(widget.slug, widget.path);
    });
  }

  Mode _getLanguageMode(String lang) {
    switch (lang.toLowerCase()) {
      case 'cpp':
      case 'c++':
      case 'c':
        return cpp;
      case 'python':
      case 'py':
        return python;
      case 'java':
        return java;
      case 'javascript':
      case 'js':
        return javascript;
      default:
        return cpp;
    }
  }

  Future<void> onTaskCleared(int currentIndex, int totalTasks) async {
    final int pointsEarned = (60.0 / (totalTasks > 0 ? totalTasks : 1)).round();

    try {
      final notifier = ref.read(userLanguageProgressProvider(widget.languageId).notifier);

      await notifier.updateXp(pointsEarned);
      await notifier.updateTopicIndex();

      final bool isLastPage = currentIndex == totalTasks - 1;

      if (isLastPage) {

        await notifier.updateRankPart(5);
        await notifier.saveToDatabase();

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Error Tracking Arena Clear! Confidence Test Unlocked.",
                style: GoogleFonts.orbitron(),
              ),
              backgroundColor: Colors.cyanAccent,
            ),
          );
        }
      } else {
        _controller?.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    } catch (e) {
      if (currentIndex < totalTasks - 1) {
        _controller?.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final progressAsync = ref.watch(userLanguageProgressProvider(widget.languageId));

    return FutureBuilder<DebuggingData>(
      future: challengesFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              const BgGradient(),
              const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
            ],
          );
        }
        if (snapshot.hasError || !snapshot.hasData) {
          return Stack(
            children: [
              const BgGradient(),
              Center(
                child: Text(
                  snapshot.error?.toString() ?? 'No challenges found',
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ],
          );
        }

        final challengeData = snapshot.data!;

        return progressAsync.when(
          loading: () => const Scaffold(
            backgroundColor: Colors.transparent,
            body: Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
          ),
          error: (err, _) => Scaffold(
            body: Center(child: Text("Error syncing progression: $err")),
          ),
          data: (userProgress) {
            int savedTopicIndex = userProgress?.currentTopicIndex ?? 0;
            if (savedTopicIndex >= challengeData.tasks.length) {
              savedTopicIndex = challengeData.tasks.length - 1;
            }

            // Sync structural index jumps smoothly
            if (_controller == null || _lastInitializedIndex != savedTopicIndex) {
              _controller?.dispose();
              _controller = PageController(initialPage: savedTopicIndex);
              _lastInitializedIndex = savedTopicIndex;
            }

            return PageView.builder(
              controller: _controller,
              itemCount: challengeData.tasks.length,
              physics: const NeverScrollableScrollPhysics(),
              itemBuilder: (context, index) {
                final taskItem = challengeData.tasks[index];
                final int totalTasks = challengeData.tasks.length;
                final int pointsAllocation = (60.0 / (totalTasks > 0 ? totalTasks : 1)).round();

                return DebugCode(
                  language: _getLanguageMode(challengeData.language),
                  buggyCode: taskItem.code,
                  taskDescription: taskItem.description,
                  taskId: "task_${index + 1}", slug: widget.slug,
                  pointsPreview: pointsAllocation,
                  rankName: widget.rankName.toLowerCase(),
                  onSuccessCleared: () => onTaskCleared(index, totalTasks),
                );
              },
            );
          },
        );
      },
    );
  }
}