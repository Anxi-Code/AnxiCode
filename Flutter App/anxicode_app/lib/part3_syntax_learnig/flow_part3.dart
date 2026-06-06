import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/Rank_System/rank_progress_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/part3_syntax_learnig/part3.dart';
import 'package:anxicode_app/part3_syntax_learnig/part3_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Part3Flow extends ConsumerStatefulWidget {
  final String path;
  final String slug;
  final String languageId;

  const Part3Flow({
    super.key,
    required this.path,
    required this.slug,
    required this.languageId,
  });

  @override
  ConsumerState<Part3Flow> createState() => _Part3FlowState();
}

class _Part3FlowState extends ConsumerState<Part3Flow> {
  List<SyntaxChallenge>? challenges;
  bool loading = true;
  PageController? _controller;
  int? _lastInitializedIndex;

  @override
  void initState() {
    super.initState();
    loadSyntaxChallenges();
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  void loadSyntaxChallenges() async {
    final learningService = ref.read(learningServiceProvider);
    final _challenges = await learningService.getSyntax(widget.slug, widget.path);
    setState(() {
      challenges = _challenges;
      loading = false;
    });
  }

   Future<void> onChallengeCleared(int index) async {
    if (challenges == null) return;

    final int topicsCount = challenges!.length > 0 ? challenges!.length : 1;
    final int pointsToEarn = (60.0 / topicsCount).round();

    try {
      final notifier = ref.read(userLanguageProgressProvider(widget.languageId).notifier);

      await notifier.updateXp(pointsToEarn);
      await notifier.updateTopicIndex();

      final bool isLastPage = index == challenges!.length - 1;

      if (isLastPage) {
        await notifier.updateRankPart(4);
        await notifier.saveToDatabase();

        if (mounted) {
          Navigator.pop(context);
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                "Syntax Dominion Conquered! Error Tracking Arena Unlocked.",
                style: GoogleFonts.orbitron(),
              ),
              backgroundColor: Colors.cyanAccent,
            ),
          );
        }
      } else {
        _controller?.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    } catch (e) {
      if (index < challenges!.length - 1) {
        _controller?.nextPage(
          duration: const Duration(milliseconds: 500),
          curve: Curves.easeIn,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (loading) {
      return Stack(
        children: [
          const BgGradient(),
          const Center(
            child: CircularProgressIndicator(color: Colors.cyanAccent),
          )
        ],
      );
    }

    final progressAsync = ref.watch(userLanguageProgressProvider(widget.languageId));

    return progressAsync.when(
      loading: () => Stack(
        children: [
          const BgGradient(),
          const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
        ],
      ),
      error: (err, _) => Scaffold(
        body: Center(
          child: Text("Error: $err", style: GoogleFonts.orbitron(color: Colors.red)),
        ),
      ),
      data: (userProgress) {
        int savedTopicIndex = userProgress?.currentTopicIndex ?? 0;
        if (savedTopicIndex >= challenges!.length) {
          savedTopicIndex = challenges!.length - 1;
        }

       if (_controller == null || _lastInitializedIndex != savedTopicIndex) {
          _controller?.dispose();
          _controller = PageController(initialPage: savedTopicIndex);
          _lastInitializedIndex = savedTopicIndex;
        }

        return PageView.builder(
          controller: _controller,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: challenges!.length,
          itemBuilder: (context, index) {
            final int topicsCount = challenges!.length > 0 ? challenges!.length : 1;
            final int standardReward = (60.0 / topicsCount).round();
            final bool isLast = index == challenges!.length - 1;

            return SyntaxForge(
              challenge: challenges![index],
              onNext: () => onChallengeCleared(index),
              pointsPreview: standardReward,
              isLastChallenge: isLast,
            );
          },
        );
      },
    );
  }
}