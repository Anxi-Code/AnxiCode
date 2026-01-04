import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final List<Map<String, dynamic>> leaderboardData = [
    {"rank": "1", "name": "Mike Wheeler", "image": "assets/images/user3.png", "points": "100 pts", "change": "+1"},
    {"rank": "2", "name": "Dustin Henderson", "image": "assets/images/user3.png", "points": "98 pts", "change": "+2"},
    {"rank": "3", "name": "Nancy Wheeler", "image": "assets/images/user3.png", "points": "94 pts", "change": "-2"},
    {"rank": "4", "name": "Jim Hopper", "image": "assets/images/user3.png", "points": "85 pts", "change": "-1"},
    {"rank": "5", "name": "Lucas Sinclair", "image": "assets/images/user3.png", "points": "80 pts", "change": "+1"},
    {"rank": "6", "name": "Max Mayfield", "image": "assets/images/user3.png", "points": "75 pts", "change": "-4"},
    {"rank": "7", "name": "Joyce Byers", "image": "assets/images/user3.png", "points": "70 pts", "change": "+3"},
    {"rank": "8", "name": "Will Byers", "image": "assets/images/user3.png", "points": "68 pts", "change": "-1"},
    {"rank": "9", "name": "Steve Harrington", "image": "assets/images/user3.png", "points": "65 pts", "change": "+2"},
    {"rank": "10", "name": "Robin Buckley", "image": "assets/images/user3.png", "points": "62 pts", "change": "-3"},
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage("assets/home_bg.jpg"),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                _topUser(
                  image: 'assets/images/user1.png',
                  name: 'Derek',
                  score: '869',
                  height: 170,
                  radius: 40,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                    bottomLeft: Radius.circular(10),
                  ),
                ),
                _topUser(
                  image: 'assets/images/user3.png',
                  name: 'Kevin',
                  score: '1000',
                  height: 200,
                  radius: 50,
                  color: Colors.blue,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                  ),
                ),
                _topUser(
                  image: 'assets/images/user1.png',
                  name: 'Araujo',
                  score: '711',
                  height: 170,
                  radius: 40,
                  borderRadius: const BorderRadius.only(
                    topLeft: Radius.circular(60),
                    topRight: Radius.circular(60),
                    bottomRight: Radius.circular(10),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 80),

          Expanded(
            child: Container(
              padding: const EdgeInsets.fromLTRB(30, 40, 30, 20),
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
                ),
              ),
              child: ListView.builder(
                itemCount: leaderboardData.length,
                itemBuilder: (context, index) {
                  final user = leaderboardData[index];
                  return leaderboardItem(
                    rank: user["rank"],
                    name: user["name"],
                    image: user["image"],
                    points: user["points"],
                    change: user["change"],
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget leaderboardItem({
    required String rank,
    required String name,
    required String image,
    required String points,
    required String change,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 20, 5),
        decoration: BoxDecoration(
          color: Colors.grey[50],
          borderRadius: BorderRadius.circular(10),
        ),
        child: Row(
          children: [
            Text(rank, style: const TextStyle(fontSize: 18)),
            const SizedBox(width: 20),
            CircleAvatar(
              backgroundImage: AssetImage(image),
              radius: 22,
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: const TextStyle(fontSize: 15)),
                const SizedBox(height: 4),
                Text(points),
              ],
            ),
            const Spacer(),
            Text(
              change,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
          ],
        ),
      ),
    );
  }

  Widget _topUser({
    required String image,
    required String name,
    required String score,
    required double height,
    required double radius,
    Color color = const Color(0xFF0D47A1),
    required BorderRadius borderRadius,
  }) {
    return Padding(
      padding: EdgeInsets.only(top: height == 170 ? 30 : 0),
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: color,
          borderRadius: borderRadius,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(10),
              child: CircleAvatar(
                backgroundImage: AssetImage(image),
                radius: radius,
              ),
            ),
            Text(
              name,
              style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
            ),
            Text(
              score,
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
                fontSize: 20,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
