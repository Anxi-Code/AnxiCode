import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/part4_debug/part4_debug.dart';
import 'package:anxicode_app/part4_debug/part4_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:highlight/highlight.dart';
import 'package:highlight/languages/cpp.dart';
import 'package:highlight/languages/java.dart';
import 'package:highlight/languages/javascript.dart';
import 'package:highlight/languages/python.dart';

class Part4Flow extends ConsumerStatefulWidget {
  final String path;
  final String slug;

  const Part4Flow({super.key, required this.path, required this.slug});

  @override
  ConsumerState<Part4Flow> createState() => _Part4FlowState();
}

class _Part4FlowState extends ConsumerState<Part4Flow> {
  PageController _controller = PageController();
  Future<DebuggingData>? challenges;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadDebugChallenges();
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

  void loadDebugChallenges() {
    final learningService = ref.read(learningServiceProvider);
    final _challenges = learningService.getDebuggingTasks(
      widget.slug,
      widget.path,
    );
    setState(() {
      challenges = _challenges;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<DebuggingData>(
      future: challenges,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Stack(
            children: [
              BgGradient(),
              const Center(
                child: CircularProgressIndicator(color: Colors.cyanAccent),
              ),
            ],
          );
        }
        if (snapshot.hasError) {
          return Stack(
            children: [
              BgGradient(),
              Center(
                child: Text(
                  snapshot.error.toString(),
                  style: const TextStyle(color: Colors.red, fontSize: 14),
                ),
              ),
            ],
          );
        }
        if (!snapshot.hasData) {
          return Stack(
            children: [
              BgGradient(),
              const Center(
                child: Text(
                  'No challenges found',
                  style: TextStyle(color: Colors.white),
                ),
              ),
            ],
          );
        }
        final challenge = snapshot.data!;
        return PageView.builder(
          itemBuilder: (context, index) {
            return DebugCode(
              language: _getLanguageMode(challenge.language),
              buggyCode: challenge.tasks[index].code,
              taskDescription: challenge.tasks[index].description,
            );
          },
        );
      },
    );
  }
}
