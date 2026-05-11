import 'package:flutter/material.dart';
import 'chat_detail_screen.dart';

class Chat extends StatelessWidget {
  const Chat({super.key});

  @override
  Widget build(BuildContext context) {
    final List<Map<String, String>> chats = [
      {"name": "Ali", "message": "Ready for coding battle?", "time": "2:30 PM"},
      {"name": "Ahmad", "message": "Let's play tonight", "time": "1:15 PM"},
      {"name": "Hassan", "message": "Bro send the challenge link", "time": "Yesterday"},
      {"name": "Usman", "message": "I won the last match", "time": "Monday"},
      {"name": "Zain", "message": "Which language are you choosing?", "time": "Sunday"},
    ];

    return Scaffold(
      backgroundColor: Colors.transparent,

      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        title: const Text(
          "Chats",
          style: TextStyle(color: Colors.white),
        ),
      ),

      body: ListView.builder(
        itemCount: chats.length,
        padding: const EdgeInsets.all(10),

        itemBuilder: (context, index) {
          final chat = chats[index];

          return GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => ChatDetailScreen(
                    userName: chat["name"]!,
                  ),
                ),
              );
            },

            child: Container(
              margin: const EdgeInsets.only(bottom: 10),
              padding: const EdgeInsets.all(15),

              decoration: BoxDecoration(
                color: Colors.white.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
              ),

              child: Row(
                children: [
                  Container(
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blueAccent.withOpacity(0.5),
                          spreadRadius: 5,
                          blurRadius: 7,
                        ),
                      ],
                    ),

                    child: CircleAvatar(
                      radius: 28,
                      backgroundColor: Colors.cyanAccent,
                    ),
                  ),

                  const SizedBox(width: 15),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          chat["name"]!,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 5),

                        Text(
                          chat["message"]!,
                          style: const TextStyle(
                            color: Colors.white70,
                            fontSize: 14,
                          ),
                          overflow: TextOverflow.ellipsis,
                        ),
                      ],
                    ),
                  ),

                  Text(
                    chat["time"]!,
                    style: const TextStyle(
                      color: Colors.white54,
                      fontSize: 12,
                    ),
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