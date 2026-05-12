import 'package:anxicode_app/Providers/languages/Language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

class LanguagesDesign extends ConsumerStatefulWidget {
  final Function(String) onLanguageSelected;

  const LanguagesDesign({super.key, required this.onLanguageSelected});

  @override
  ConsumerState<LanguagesDesign> createState() => _LanguagesDesignState();
}

class _LanguagesDesignState extends ConsumerState<LanguagesDesign> {
  int selectedIndex = -1;
  PageController _controller = PageController(viewportFraction: 1.0);

  void NextPage() {
    final languages = ref.watch(languagesListProvider);
    if (selectedIndex < languages.length - 1) {
      selectedIndex++;
      _controller.animateToPage(
        selectedIndex,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
    setState(() {});
  }

  void PreviousPage() {
    if (selectedIndex > 0) {
      selectedIndex--;
      _controller.animateToPage(
        selectedIndex,
        duration: Duration(milliseconds: 200),
        curve: Curves.easeIn,
      );
    }
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    final languages = ref.watch(languagesListProvider);
    String selectedLanguage = 'Python';

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: SizedBox(
        height: 130,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent.withOpacity(0.3),
                      spreadRadius: 2,
                      blurRadius: 12,
                    )
                  ],
                  shape: BoxShape.circle
              ),
              child: Center(
                child: IconButton(
                  onPressed: PreviousPage,
                  icon: Icon(Icons.arrow_back_rounded),
                  color: Colors.cyanAccent,
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                onPageChanged: (index) {
                  setState(() {
                    selectedLanguage = languages[index].languageName;
                    widget.onLanguageSelected(selectedLanguage);
                    selectedIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Container(
                          height: 80,
                          width: 80,

                          child: Image.asset(
                            languages[index].imagePath,
                            fit: BoxFit.cover,
                          ),
                        ),
                        Text(
                          languages[index].languageName,
                          style: GoogleFonts.orbitron(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                  );
                },
                controller: _controller,
                scrollDirection: Axis.horizontal,
                itemCount: languages.length,
              ),
            ),
            Container(
              decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.cyanAccent.withOpacity(0.3),
                    spreadRadius: 2,
                    blurRadius: 12,
                  )
                ],
                shape: BoxShape.circle
              ),
              child: IconButton(
                onPressed: NextPage,
                icon: Icon(Icons.arrow_forward_rounded, color: Colors.cyanAccent),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
