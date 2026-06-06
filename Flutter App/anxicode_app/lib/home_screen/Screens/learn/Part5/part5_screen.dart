import 'package:anxicode_app/Learning/mod/files_part.dart';
import 'package:anxicode_app/Learning/mod/quiz_result.dart';
import 'package:anxicode_app/Rank_System/rank_progress_provider.dart';
import 'package:anxicode_app/design/Quiz/mcqs_design.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/home_screen/Screens/learn/rank_promotion_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class Part5Screen extends ConsumerStatefulWidget {
  final FilePart part5;
  final String slug;
  final String languageId;
  final String nextRankName;

  const Part5Screen({
    super.key,
    required this.part5,
    required this.slug,
    required this.languageId,
    required this.nextRankName,
  });

  @override
  ConsumerState<Part5Screen> createState() => _Part5ScreenState();
}

class _Part5ScreenState extends ConsumerState<Part5Screen> {
  final PageController _controller = PageController(viewportFraction: 1.0);
  bool isProcessing = false;

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void goToResult(QuizResult quizResult) async {
    if (quizResult.percentage >= 65.0) {
      setState(() => isProcessing = true);

      try {
        final notifier = ref.read(userLanguageProgressProvider(widget.languageId).notifier);
        final currentProgress = ref.read(userLanguageProgressProvider(widget.languageId)).value;

        if (currentProgress != null) {
          await notifier.updateXp(60);

           if (currentProgress.currentRankName.toLowerCase() != "legendary") {
            await notifier.updateRankName(widget.nextRankName, currentProgress.currentRankOrder + 1);
          } else {
            await notifier.updateRankName(currentProgress.currentRankName, currentProgress.currentRankOrder);
          }


          await notifier.saveToDatabase();
        }

        if (mounted) {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => RankPromotionScreen(nextRankName: widget.nextRankName),
            ),
          );
        }
      } catch (e) {
        setState(() => isProcessing = false);
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text("Error saving progress: $e")));
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("You scored ${quizResult.percentage.round()}%. 65% needed to pass the Confidence Test. Try again!", style: GoogleFonts.orbitron()),
          backgroundColor: Colors.redAccent,
        ),
      );
      _controller.jumpToPage(0);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Stack(
        children: [
          const BgGradient(),
          PageView.builder(
            controller: _controller,
            itemCount: 1,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Mcqs(
                goToResult: goToResult,
                slug: widget.slug,
                path: widget.part5.filePath,
                nextTopic: "Rank Promotion",
              );
            },
          ),
          if (isProcessing)
            Container(
              color: Colors.black.withValues(alpha: 0.6),
              child: const Center(child: CircularProgressIndicator(color: Colors.cyanAccent)),
            ),
        ],
      ),
    );
  }
}