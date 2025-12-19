import 'package:anxicode_app/Designs/glassmorphism.dart';
import 'package:anxicode_app/Providers/Language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

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
              child: Glassmorphism(
                blur: 3,
                opacity:0.2,
                borderRadius: BorderRadius.circular(18),
                borderColor:
                    selectedIndex == index ? Colors.blue : Colors.white,

                child: SizedBox(
                  width: 130,
                  child: Column(
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
            ),
          );
        },
      ),
    );
  }
}
