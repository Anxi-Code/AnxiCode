import 'package:anxicode_app/design/Explaination/exp.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:anxicode_app/home_screen/Screens/learn/fullscreen_topic.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class TopicScreen extends StatefulWidget {
  final VoidCallback goToQuiz;
  final String topicName;
  final String slug;
  final String path;

  const TopicScreen({
    super.key,
    required this.goToQuiz,
    required this.topicName,
    required this.slug,
    required this.path,
  });

  @override
  State<TopicScreen> createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
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
            leading: const BackButton(color: Colors.white),
            centerTitle: true,
            title:   Text(
              "TOPIC",
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.w700,
                letterSpacing: 2,
              ),
            ),

          ),

          body: Column(
            children: [
              const SizedBox(height: 10),


              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Container(
                  padding: const EdgeInsets.all(16),
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
                  child: Row(
                    children: [
                      Container(
                        width: 50,
                        height: 50,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: RadialGradient(
                            colors: [
                              Colors.cyanAccent.withOpacity(0.7),
                              Colors.cyanAccent.withOpacity(0.1),
                            ],
                          ),
                        ),
                        child: const Icon(
                          Icons.auto_awesome,
                          color: Colors.white,
                        ),
                      ),

                      const SizedBox(width: 16),

                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Learning Theory",
                              style: GoogleFonts.orbitron(
                                color: Colors.white,
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            const SizedBox(height: 6),
                            Text(
                              "Read the topic carefully before moving to the quiz section.",
                              style: GoogleFonts.manrope(
                                color: Colors.white70,
                                fontSize: 13,
                                height: 1.5,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),


              Expanded(
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 14),
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
                  child: Stack(
                    children: [

                      ClipRRect(
                        borderRadius: BorderRadius.circular(24),
                        child: Topic(
                          slug: widget.slug,
                          path: widget.path,
                        ),
                      ),


                      Positioned(
                        top: 10,
                        right: 10,
                        child: InkWell(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (_) => FullScreenTopicView(
                                  topicName: widget.topicName,
                                  slug: widget.slug,
                                  path: widget.path,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              gradient: RadialGradient(
                                colors: [
                                  Colors.cyanAccent.withOpacity(0.1),
                                  Colors.blueAccent.withOpacity(0.1),
                                ],
                              ),
                            ),
                            child: const Icon(
                              Icons.open_in_full,
                              color: Colors.cyanAccent,
                              size: 18,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),

              const SizedBox(height: 20),


              Padding(
                padding: const EdgeInsets.fromLTRB(20, 0, 20, 20),
                child: GestureDetector(
                  onTap: widget.goToQuiz,
                  child: Container(
                    height: 60,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      gradient: LinearGradient(
                        colors: [
                          Colors.cyanAccent.withOpacity(0.9),
                          Colors.blueAccent.withOpacity(0.9),
                        ],
                      ),
                    ),
                    child: const Center(
                      child: Text(
                        "CONTINUE TO QUIZ",
                        style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}