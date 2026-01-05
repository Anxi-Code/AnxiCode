import 'package:anxicode_app/Providers/Language_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:glass_kit/glass_kit.dart';

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
      height: 130,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: languages.length,
        physics: const BouncingScrollPhysics(),
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.fromLTRB(2, 0, 2, 0),
            child: GestureDetector(
              onTap: () {
                setState(() {
                  selectedIndex = index;
                });
              },
              child: GlassContainer(
                width: 130,
                height: 120,
                gradient: LinearGradient(
                  colors: [Colors.white.withValues(alpha:0.50), Colors.white.withValues(alpha:0.10)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),

                blur: 8.0,
                borderWidth: 1.5,
                elevation: 4.0,
                borderRadius: BorderRadius.circular(25),
                shadowColor: Colors.black.withValues(alpha: 0.2),
                alignment: Alignment.center,
                frostedOpacity: 0.35,
                margin: EdgeInsets.all(8.0),
                padding: EdgeInsets.all(8.0),
                borderGradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: selectedIndex == index
                        ? [
                      Colors.blue.withValues(alpha: 2.0),
                      Colors.yellow.withValues(alpha: 1.0),
                    ]
                        : [
                      Colors.white.withValues(alpha: 0.35),
                      Colors.white.withValues(alpha: 0.25),
                    ],
                    stops: [0.0,0.8]
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
                          color: selectedIndex==index ? Colors.white:Colors.white70,
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
