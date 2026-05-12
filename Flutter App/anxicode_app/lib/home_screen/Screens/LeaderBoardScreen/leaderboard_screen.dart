import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  final List<Map<String, dynamic>> leaderboardData = [
    {
      "rank": "1",
      "name": "Mike Wheeler",
      "image": "assets/images/user3.png",
      "points": "100 pts",
      "change": "+1",
    },
    {
      "rank": "2",
      "name": "Dustin Henderson",
      "image": "assets/images/user3.png",
      "points": "98 pts",
      "change": "+2",
    },
    {
      "rank": "3",
      "name": "Nancy Wheeler",
      "image": "assets/images/user3.png",
      "points": "94 pts",
      "change": "-2",
    },
    {
      "rank": "4",
      "name": "Jim Hopper",
      "image": "assets/images/user3.png",
      "points": "85 pts",
      "change": "-1",
    },
    {
      "rank": "5",
      "name": "Lucas Sinclair",
      "image": "assets/images/user3.png",
      "points": "80 pts",
      "change": "+1",
    },
    {
      "rank": "6",
      "name": "Max Mayfield",
      "image": "assets/images/user3.png",
      "points": "75 pts",
      "change": "-4",
    },
    {
      "rank": "7",
      "name": "Joyce Byers",
      "image": "assets/images/user3.png",
      "points": "70 pts",
      "change": "+3",
    },
    {
      "rank": "8",
      "name": "Will Byers",
      "image": "assets/images/user3.png",
      "points": "68 pts",
      "change": "-1",
    },
    {
      "rank": "9",
      "name": "Steve Harrington",
      "image": "assets/images/user3.png",
      "points": "65 pts",
      "change": "+2",
    },
    {
      "rank": "10",
      "name": "Robin Buckley",
      "image": "assets/images/user3.png",
      "points": "62 pts",
      "change": "-3",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 10),
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 40,),
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

          const SizedBox(height: 50),

          Expanded(
            child: Container(
              width: double.infinity,
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  colors: [Color(0xFF1B1B3A), Color(0xFF2D2D5A)],
                ),
                borderRadius: BorderRadius.circular(30),
                border: Border.all(color: Colors.amberAccent, width: 2),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.35),
                    blurRadius: 18,
                    offset: const Offset(0, 8),
                  ),
                ],
              ),
              child: Container(
                padding: const EdgeInsets.fromLTRB(30, 30, 30, 15),
                child: ListView.builder(
                  physics: const BouncingScrollPhysics(),
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
          ),

          const SizedBox(height: 10.0),
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
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Container(
        height: 70,
        width: double.infinity,
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFF00C9A7), Color(0xFF007CF0)],
          ),
          borderRadius: BorderRadius.circular(18),
          border: Border.all(color: Colors.white24, width: 1.5),
          boxShadow: [
            BoxShadow(
              color: Colors.cyanAccent.withOpacity(0.2),
              blurRadius: 10,
              spreadRadius: 1,
            ),
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 10.0),
            Text(
              rank,
              style: const TextStyle(
                fontSize: 20,
                color: Colors.amberAccent,
                fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic,
              ),
            ),
            const SizedBox(width: 15.0),
            CircleAvatar(backgroundImage: AssetImage(image), radius: 25),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 6.0),
                Text(
                  name,
                  style: const TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                  ),
                ),
                const SizedBox(height: 4),
                Text(points, style: const TextStyle(color: Colors.white70)),
              ],
            ),
            const Spacer(),
            Text(
              change,
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                color:
                    change.contains('+')
                        ? Colors.lightGreenAccent
                        : Colors.redAccent,
              ),
            ),
            const SizedBox(width: 10.0),
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
        width: 120,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            colors: [Color(0xFFFFC75F), Color(0xFFFF9671)],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: borderRadius,
          border: Border.all(color: Colors.white24, width: 2),
          boxShadow: [
            BoxShadow(color: Colors.orange, blurRadius: 12, spreadRadius: 2),
          ],
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
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              score,
              style: const TextStyle(
                color: Colors.white70,
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
            const SizedBox(height: 10.0),
          ],
        ),
      ),
    );
  }
}
