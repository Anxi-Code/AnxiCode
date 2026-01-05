import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anxicode_app/Providers/problem_categories_provider.dart';
import 'package:glass_kit/glass_kit.dart';


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
      child: GlassContainer(
        width: double.infinity,
        height: 60,
        gradient: LinearGradient(
          colors: [Colors.white.withValues(alpha:0.50), Colors.white.withValues(alpha:0.10)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),

        blur: 15.0,
        borderWidth: 1.0,
        elevation: 4.0,
        borderRadius: BorderRadius.circular(25),
        shadowColor: Colors.black.withValues(alpha: 0.2),
        alignment: Alignment.center,
        frostedOpacity: 0.2,
        margin: EdgeInsets.all(8.0),
        padding: EdgeInsets.all(8.0),

        borderGradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors:
                 [
              Colors.white.withValues(alpha: 3.15),
              Colors.white.withValues(alpha: 2.25),
            ],

            stops: [0.0,0.7]
        ),
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 1, 8,1),
          child: DropdownButtonFormField2(
              hint: Text(
                "Choose Problem Type",
                style: TextStyle(color: Colors.white70,fontSize: 15),
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
                          Text(item, style: TextStyle(color: Colors.black45,fontSize: 15)),
                        ],
                      ),
                    );
                  }).toList(),
              onChanged: (value) {
                // Do something when changing the item if you want.

              },
            iconStyleData: IconStyleData(
              icon: Icon(
                Icons.keyboard_arrow_down_rounded,
                color: Colors.white, // 👈 arrow color
              ),
            ),

              dropdownStyleData: DropdownStyleData(


                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.8),
                  borderRadius: BorderRadius.circular(18),
                ),
              ),
            ),
          ),
        ),

    );
  }
}
