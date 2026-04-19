import 'package:flutter/material.dart';

class Achievements extends StatelessWidget {
  const Achievements({super.key});

  @override
  Widget build(BuildContext context) {
    return const Achievement();
  }
}

class Achievement extends StatelessWidget {
  const Achievement({super.key});

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),


            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.orange.shade100,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      CircleAvatar(
                        backgroundColor: Colors.orange.shade200,
                        child: const Icon(Icons.emoji_events,
                            color: Colors.yellow),
                      ),
                      const SizedBox(width: 10),
                      const Text("Ray Cooper",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  const SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: const [
                      Text(
                        "300",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Padding(
                        padding: EdgeInsets.only(bottom: 10),
                        child: Text("points"),
                      )
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            // 🔹 Grid Section
            Container(
              padding: const EdgeInsets.all(16),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: GridView.count(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                crossAxisCount: 2,
                crossAxisSpacing: size.width * 0.02,
                mainAxisSpacing: size.height * 0.02,
                children: [
                  buildItem("Mein hoon don", "+1000",
                      Colors.orange.shade100, Icons.home),
                  buildItem("Badge mera hai", "+100",
                      Colors.blue.shade100, Icons.home),
                  buildItem("Laal Singh Chadda", "+200",
                      Colors.pink.shade100, Icons.home),
                  buildItem("Nikl Pyaare", "+300",
                      Colors.green.shade100, Icons.home),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildItem(
      String title, String points, Color color, IconData icon) {
    return Column(
      children: [
        Container(
          height: 100,
          width: 100,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
          child: Center(
            child: Icon(icon, size: 40),
          ),
        ),
        const SizedBox(height: 10),
        Text(title, textAlign: TextAlign.center),
        const SizedBox(height: 5),
        Text(points,
            style: const TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}