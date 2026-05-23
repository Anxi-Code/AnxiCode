import 'dart:math';
import 'dart:ui';

import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/home_screen/Screens/learn/ranks_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguagesScreen extends ConsumerStatefulWidget {
  const LanguagesScreen({super.key});

  @override
  ConsumerState<LanguagesScreen> createState() => _LanguagesScreenState();
}

class _LanguagesScreenState extends ConsumerState<LanguagesScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _shineController;

  @override
  void initState() {
    super.initState();

    _shineController = AnimationController(
      vsync: this,
      duration: const Duration(seconds: 10),
    )..repeat();
  }

  @override
  void dispose() {
    _shineController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final languagesAsync = ref.watch(languagesProvider);

    return languagesAsync.when(
      data: (languages) {
        return Column(
          children: [
            const SizedBox(height: 14),

            /// HEADER (unchanged)
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 14,
                ),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(26),
                  gradient: RadialGradient(
                    radius: 2.5,
                    colors: [
                      Colors.cyanAccent.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.1),
                    ],
                  ),

                ),
                child: Row(
                  children: [
                    Container(
                      height: 38,
                      width: 38,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(18),
                        gradient: RadialGradient(
                          colors: [
                            Colors.cyanAccent.withValues(alpha: 0.2),
                            Colors.white.withValues(alpha: 0.1),
                          ],
                        ),

                      ),
                      child: const Icon(
                        Icons.code_rounded,
                        color: Colors.cyanAccent,
                        size: 28,
                      ),
                    ),
                    const SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        "CHOOSE LANGUAGE",
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.orbitron(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          letterSpacing: 1.5,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 22),

            /// LIST
            Expanded(
              child: ListView.builder(
                physics: const BouncingScrollPhysics(),
                padding: const EdgeInsets.symmetric(horizontal: 18),
                itemCount: languages.length,
                itemBuilder: (context, index) {
                  final language = languages[index];

                  return TweenAnimationBuilder(
                    tween: Tween<double>(begin: 0, end: 1),
                    duration: Duration(milliseconds: 450 + (index * 120)),
                    builder: (context, value, child) {
                      return Transform.translate(
                        offset: Offset(0, 30 * (1 - value)),
                        child: Opacity(opacity: value, child: child),
                      );
                    },
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) => RanksScreen(
                              languageId: language.id,
                              languageName: language.name,
                            ),
                          ),
                        );
                      },

                      child: AnimatedBuilder(
                        animation: _shineController,
                        builder: (context, child) {
                          return Container(
                            height: 138,
                            margin: const EdgeInsets.only(bottom: 18),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(28),
                              gradient: RadialGradient(
                                radius: 2.8,
                                colors: [
                                  Colors.cyanAccent.withValues(alpha: 0.1),
                                  Colors.white.withValues(alpha: 0.1),
                                ],
                              ),

                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(28),
                              child: Stack(
                                children: [
                                  /// ✨ REAL GLASS SHINE (FULL CARD + NATURAL LOOP)
                                  Positioned.fill(
                                    child: AnimatedBuilder(
                                      animation: _shineController,
                                      builder: (context, child) {
                                        // smooth looping curve (no fake reset feel)
                                        final curveValue = Curves.easeInOut.transform(
                                          (_shineController.value < 0.5)
                                              ? _shineController.value * 2
                                              : (1 - _shineController.value) * 2,
                                        );

                                        // moves across full width
                                        final left = lerpDouble(-300, 300, curveValue)!;

                                        return Transform.translate(
                                          offset: Offset(left, 0),
                                          child: Transform.rotate(
                                            angle: pi / 6,
                                            child: Container(
                                              width: 140, // 👈 wide enough to cover card properly
                                              height: double.infinity,
                                              decoration: BoxDecoration(
                                                gradient: LinearGradient(
                                                  begin: Alignment.topLeft,
                                                  end: Alignment.bottomRight,
                                                  colors: [
                                                    Colors.transparent,
                                                    Colors.white.withValues(alpha: 0.03),
                                                    Colors.cyanAccent.withValues(alpha: 0.07),
                                                    Colors.white.withValues(alpha: 0.03),
                                                    Colors.transparent,
                                                  ],
                                                  stops: const [0.0, 0.35, 0.5, 0.65, 1.0],
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    ),
                                  ),

                                  /// CONTENT
                                  Padding(
                                    padding: const EdgeInsets.all(14),
                                    child: Row(
                                      children: [
                                        /// ICON
                                        Container(
                                          height: 78,
                                          width: 78,
                                          padding: const EdgeInsets.all(14),
                                          decoration: BoxDecoration(
                                            borderRadius: BorderRadius.circular(24),
                                            gradient: RadialGradient(
                                              colors: [
                                                Colors.cyanAccent.withValues(alpha: 0.2),
                                                Colors.white.withValues(alpha: 0.1),
                                              ],
                                            ),

                                          ),
                                          child: Image.asset(
                                            language.icon,
                                            fit: BoxFit.contain,
                                          ),
                                        ),

                                        const SizedBox(width: 16),

                                        /// TEXT
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment: CrossAxisAlignment.start,
                                            mainAxisAlignment: MainAxisAlignment.center,
                                            children: [
                                              Text(
                                                language.name,
                                                maxLines: 1,
                                                overflow: TextOverflow.ellipsis,
                                                style: GoogleFonts.orbitron(
                                                  color: Colors.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 18,
                                                ),
                                              ),

                                              const SizedBox(height: 10),

                                              Container(
                                                padding: const EdgeInsets.symmetric(
                                                  horizontal: 10,
                                                  vertical: 5,
                                                ),
                                                decoration: BoxDecoration(
                                                  borderRadius: BorderRadius.circular(12),
                                                  color: Colors.cyanAccent.withValues(alpha: 0.10),
                                                ),
                                                child: Text(
                                                  language.slug.toUpperCase(),
                                                  style: GoogleFonts.orbitron(
                                                    color: Colors.cyanAccent,
                                                    fontSize: 9,
                                                    fontWeight: FontWeight.bold,
                                                    letterSpacing: 1.3,
                                                  ),
                                                ),
                                              ),

                                              const SizedBox(height: 14),

                                              Row(
                                                children: [
                                                  Expanded(
                                                    child: ClipRRect(
                                                      borderRadius: BorderRadius.circular(20),
                                                      child: TweenAnimationBuilder<double>(
                                                        tween: Tween(begin: 0, end: 0.45),
                                                        duration: const Duration(seconds: 2),
                                                        builder: (context, progress, child) {
                                                          return LinearProgressIndicator(
                                                            value: progress,
                                                            minHeight: 6,
                                                            backgroundColor: Colors.white10,
                                                            valueColor:
                                                            const AlwaysStoppedAnimation(
                                                              Colors.cyanAccent,
                                                            ),
                                                          );
                                                        },
                                                      ),
                                                    ),
                                                  ),
                                                  const SizedBox(width: 10),
                                                  Text(
                                                    "45%",
                                                    style: GoogleFonts.orbitron(
                                                      color: Colors.cyanAccent,
                                                      fontWeight: FontWeight.bold,
                                                      fontSize: 10,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),

                                        const SizedBox(width: 12),

                                        /// 🚀 TRANSPARENT BUTTON (FIXED)
                                        Container(
                                          height: 46,
                                          width: 46,
                                          decoration: BoxDecoration(
                                            shape: BoxShape.circle,
                                            color: Colors.transparent, // 👈 transparent
                                            border: Border.all(
                                              color: Colors.cyanAccent,
                                              width: 1.5,
                                            ),
                                          ),
                                          child: const Icon(
                                            Icons.arrow_forward_ios_rounded,
                                            color: Colors.cyanAccent, // 👈 cyan arrow
                                            size: 18,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },

      error: (e, _) {
        return Center(
          child: Text(
            e.toString(),
            style: GoogleFonts.orbitron(color: Colors.red),
          ),
        );
      },

      loading: () {
        return const Center(
          child: CircularProgressIndicator(color: Colors.cyanAccent),
        );
      },
    );
  }
}