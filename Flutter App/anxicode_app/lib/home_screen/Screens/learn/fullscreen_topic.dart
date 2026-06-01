import 'package:anxicode_app/design/Explaination/exp.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';

class FullScreenTopicView extends StatelessWidget {
  final String topicName;
  final String slug;
  final String path;

  const FullScreenTopicView({
    super.key,
    required this.topicName,
    required this.slug,
    required this.path,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          const BgGradient(),

          Column(
            children: [
              SafeArea(
                child: Padding(
                  padding: const EdgeInsets.all(12),
                  child: Row(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.close, color: Colors.white),
                        onPressed: () => Navigator.pop(context),
                      ),
                      Text(
                        topicName.toUpperCase(),
                        style: const TextStyle(
                          color: Colors.cyanAccent,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              Expanded(
                child: Container(
                  margin: const EdgeInsets.all(12),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(24),
                    gradient: RadialGradient(
                      radius: 3,
                      colors: [
                        Colors.cyanAccent.withValues(alpha: 0.10),
                        Colors.white.withValues(alpha: 0.08),
                      ],
                    ),
                  ),

                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(24),

                    child: Hero(
                      tag: "topic-$slug",

                      child: Material(
                        color: Colors.transparent,

                        child: Topic(
                          slug: slug,
                          path: path,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}