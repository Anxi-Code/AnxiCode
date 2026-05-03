import 'package:anxicode_app/Providers/Language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LanguagesDesign extends ConsumerStatefulWidget {
  final Function(String) onLanguageSelected;

  const LanguagesDesign({super.key, required this.onLanguageSelected});

  @override
  ConsumerState<LanguagesDesign> createState() => _LanguagesDesignState();
}

class _LanguagesDesignState extends ConsumerState<LanguagesDesign> {
  int selectedIndex = -1;

  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(languagesListProvider);
    String selectedLanguage='';


    return SizedBox(
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        itemBuilder: (context, index) {
          bool isSelected = selectedIndex == index;


          return GestureDetector(
            onTap: () {
<<<<<<< Updated upstream
              setState(() {
                selectedIndex = index;
                widget.onLanguageSelected(languages[index].languageName);

              });

=======
              setState(() => selectedIndex = index);
>>>>>>> Stashed changes
            },
            child: Container(
              width: 120,
              margin: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                gradient: isSelected
                    ? const LinearGradient(
                  colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
                )
                    : const LinearGradient(
                  colors: [Color(0xFF1B1B3A), Color(0xFF2D2D5A)],
                ),
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.amber : Colors.white24,
                  width: 2,
                ),
                boxShadow: [
                  BoxShadow(
                    color: isSelected
                        ? Colors.cyanAccent.withOpacity(0.3)
                        : Colors.black.withOpacity(0.2),
                    blurRadius: 12,
                  ),
                ],
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(languages[index].imagePath, height: 50),
                  const SizedBox(height: 10),
                  Text(
                    languages[index].languageName,
                    style: const TextStyle(color: Colors.white),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}