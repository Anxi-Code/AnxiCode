import 'package:anxicode_app/part4_debug/helper_functions.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class DescriptionTile extends StatelessWidget {
  final String description;
  final VoidCallback onExpand;

  const DescriptionTile({
    super.key,
    required this.description,
    required this.onExpand,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: glassCard(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.flag, color: Colors.amber),

              const SizedBox(width: 8),

              Text(
                "MISSION OBJECTIVE",
                style: GoogleFonts.orbitron(
                  color: Colors.amber,
                  fontWeight: FontWeight.bold,
                  fontSize: 13,
                ),
              ),

              const Spacer(),

              InkWell(
                onTap: onExpand,
                borderRadius: BorderRadius.circular(6),
                child: Container(
                  height: 28,
                  width: 28,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.cyanAccent),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: const Icon(
                    Icons.open_in_full,
                    size: 16,
                    color: Colors.cyanAccent,
                  ),
                ),
              ),
            ],
          ),

          const SizedBox(height: 12),

          SizedBox(
            height: 80,
            child: Text(
              description,
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: Colors.grey.shade300,
                height: 1.5,
                fontSize: 14,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
