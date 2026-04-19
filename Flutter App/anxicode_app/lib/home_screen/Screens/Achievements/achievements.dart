import 'package:flutter/material.dart';
class Achievements extends StatelessWidget {
  const Achievements({super.key});
  @override
  Widget build(BuildContext context) {
    return Achievement();
  }
}
class Achievement extends StatelessWidget {

  const Achievement({super.key});
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      body: Column(
        children: [
          SizedBox(height: 20),
<<<<<<< HEAD
          Container(
            padding: EdgeInsets.all(20),
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
                      child: Icon(Icons.emoji_events,
                          color: Colors.yellow),
                    ),
                    SizedBox(width: 10),
                    Text("Ray Cooper",
                        style: TextStyle(fontSize: 16)),
                  ],
                ),
                SizedBox(height: 20),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      "300",
                      style: TextStyle(
                          fontSize: 50,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(width: 5),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Text("points"),
                    )
                  ],
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          Container(
            height: size.height * 0.53,
            padding: EdgeInsets.all(16),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                topRight: Radius.circular(50),
                topLeft: Radius.circular(50),
              ),
            ),
            child: GridView.count(
              crossAxisCount: 2,
              crossAxisSpacing: size. width * 0.02,
              mainAxisSpacing: size.height * 0.05,
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
=======
           Container(
              padding: EdgeInsets.all(20),
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
                        child: Icon(Icons.emoji_events,
                            color: Colors.yellow),
                      ),
                      SizedBox(width: 10),
                      Text("Ray Cooper",
                          style: TextStyle(fontSize: 16)),
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    children: [
                      Text(
                        "300",
                        style: TextStyle(
                            fontSize: 50,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 5),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 10),
                        child: Text("points"),
                      )
                    ],
                  ),
                ],
              ),
            ),
          SizedBox(height: 20),
           Container(
              height: size.height * 0.53,
              padding: EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topRight: Radius.circular(50),
                  topLeft: Radius.circular(50),
                ),
              ),
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: size. width * 0.02,
                mainAxisSpacing: size.height * 0.05,
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
>>>>>>> 2972cad1d95c3464317e11abfb7be4d8be1cbdd0

        ],
      ),
    );
  }

  Widget buildItem(
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
        SizedBox(height: 10),
        Text(title, textAlign: TextAlign.center),
        SizedBox(height: 5),
        Text(points,
            style: TextStyle(
                color: Colors.orange,
                fontWeight: FontWeight.bold)),
      ],
    );
  }
}