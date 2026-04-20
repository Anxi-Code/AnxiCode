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
              setState(() {
                selectedIndex = index;
                widget.onLanguageSelected(languages[index].languageName);

              });

            },
            child: Container(
              width: 120,
              margin: EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: isSelected ? Colors.blue : Colors.white,
                borderRadius: BorderRadius.circular(20),
                border: Border.all(
                  color: isSelected ? Colors.yellow : Colors.white24,
                  width: 2,
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(languages[index].imagePath, height: 50),
                  SizedBox(height: 10),
                  Text(
                    languages[index].languageName,
                    style: TextStyle(color: Colors.black),
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