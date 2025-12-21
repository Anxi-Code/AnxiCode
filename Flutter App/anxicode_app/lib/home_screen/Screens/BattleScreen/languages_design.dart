import 'package:anxicode_app/Providers/Language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glassmorphism/glassmorphism.dart';

class LanguagesDesign extends ConsumerStatefulWidget {
  const LanguagesDesign({super.key});

  @override
  ConsumerState<LanguagesDesign> createState() => _LanguagesDesignState();
}

class _LanguagesDesignState extends ConsumerState<LanguagesDesign> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(languagesListProvider);

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: GlassmorphicContainer(
                width: 130,
                height: 120,
                borderRadius: 20,
                blur: 4,
                alignment: Alignment.bottomCenter,
                border: 1.5,
                linearGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      Colors.white.withValues(alpha: 0.1),
                      Colors.white.withValues(alpha: 0.05),
                    ],
                    stops: [
                      0.1,
                      1,
                    ]),
                borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: selectedIndex == index
                        ? [
                      Colors.blue.withValues(alpha: 1.0),
                      Colors.red.withValues(alpha: 1.0),
                    ]
                        : [
                      Colors.white.withValues(alpha: 0.6),
                      Colors.white.withValues(alpha: 0.2),
                    ],
                    stops: [0.0,0.9]
                ),
                child:  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        languages[index].imagePath,
                        height: 50,
                        width: 40,
                      ),
                      SizedBox(height: 10),
                      Text(
                        languages[index].languageName,
                        style: TextStyle(
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                          color: Colors.white.withValues(alpha: 0.8),
                        ),
                      ),
                    ],
                  ),
                ),

              ),



          );
        },
      ),
    );
  }
}
