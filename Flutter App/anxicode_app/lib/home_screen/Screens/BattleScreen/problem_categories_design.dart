import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anxicode_app/Designs/glassmorphism.dart';
import 'package:anxicode_app/Providers/problem_categories_provider.dart';
import 'package:glassmorphism/glassmorphism.dart';


class ProblemCategoriesDesign extends ConsumerStatefulWidget {
  const ProblemCategoriesDesign({super.key});

  @override
  ConsumerState<ProblemCategoriesDesign> createState() => _State();
}

class _State extends ConsumerState<ProblemCategoriesDesign> {
  @override
  Widget build(BuildContext context) {
    final problemCategories = ref.watch(problemCategoriesListProvider);
    return Padding(
      padding: const EdgeInsets.all(6.0),
      child: GlassmorphicContainer(
        width: double.infinity,
        height: 70,
        borderRadius: 20,
        blur: 25,
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
            colors:
                 [
              Colors.blue.withValues(alpha: 1.0),
              Colors.red.withValues(alpha: 1.0),
            ],

            stops: [0.0,0.7]
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: DropdownButtonFormField2(
              hint: Text(
                "Choose Problem Type",
                style: TextStyle(color: Colors.white.withValues(alpha: 0.8)),
              ),
              isExpanded: true,
              decoration: InputDecoration(
                border: InputBorder.none
              ),
              items:
                  problemCategories.map((item) {
                    return DropdownMenuItem(
                      value: item,
                      child: Row(
                        children: [
                          Text(item, style: TextStyle(color: Colors.white)),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                // Do something when changing the item if you want.

              },
              dropdownStyleData: DropdownStyleData(

                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.9),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ),

    );
  }
}
