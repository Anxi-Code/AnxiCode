import 'package:flutter/material.dart';
import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:anxicode_app/Providers/problem_categories_provider.dart';

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
      child: Container(
        height: 60,
        padding: EdgeInsets.symmetric(horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.grey[850],
          borderRadius: BorderRadius.circular(20),
        ),
        child: DropdownButtonFormField2(
          hint: Text("Choose Problem Type", style: TextStyle(color: Colors.white70)),
          isExpanded: true,
          decoration: InputDecoration(border: InputBorder.none),
          dropdownStyleData: DropdownStyleData(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15),
            ),
          ),
          items: problemCategories.map((item) {
            return DropdownMenuItem(
              value: item,
              child: Text(item, style: TextStyle(color: Colors.black)),
            );
          }).toList(),
          onChanged: (value) {},
          iconStyleData: IconStyleData(
            icon: Icon(Icons.keyboard_arrow_down_rounded, color: Colors.white),
          ),
        ),
      ),
    );
  }
}