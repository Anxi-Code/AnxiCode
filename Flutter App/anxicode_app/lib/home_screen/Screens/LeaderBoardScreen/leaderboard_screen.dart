import 'package:flutter/material.dart';

class Leaderboard extends StatefulWidget {
  const Leaderboard({super.key});

  @override
  State<Leaderboard> createState() => _LeaderboardState();
}

class _LeaderboardState extends State<Leaderboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Leaderboard',
        style: TextStyle(
            color: Colors.white
        ),),
        backgroundColor:Colors.black,
        centerTitle: true,
      ),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/leaderboard.jpg"),
            fit: BoxFit.cover,
          ),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 20),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60), bottomLeft: Radius.circular(10))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/affaq.jpg'),
                              radius: 40,
                            ),
                          ),
                          Text('AFFAQ',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),),
                          Text('869',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),
                        ],
                      ),
                    ),
                  ),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius:
                        BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(8),
                          child: CircleAvatar(
                            backgroundImage: AssetImage('assets/meesum.jpg'),
                            radius: 50,
                          ),
                        ),
                        Text('MEESUM',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold
                          ),),
                        Text('1000',
                          style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                              fontSize: 20
                          ),),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: 30),
                    child: Container(
                      height: 170,
                      decoration: BoxDecoration(
                          color: Colors.blue[900],
                          borderRadius:
                          BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60), bottomRight: Radius.circular(10))
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(10),
                            child: CircleAvatar(
                              backgroundImage: AssetImage('assets/shahroz.jpg'),
                              radius: 40,
                            ),
                          ),
                          Text('SHAHROZ',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold
                            ),),
                          Text('711',
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 20
                            ),),

                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(topLeft: Radius.circular(40),topRight: Radius.circular(40))
                  ),
                  padding: EdgeInsets.fromLTRB(30, 40, 30, 10),
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('1',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/meesum.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Meesum Afzaal',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('100 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('+1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('2',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/shahroz.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Shahroz Javed',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('98 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('+2',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('3',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/affaq.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Affaq Ahmad',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('94 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('-2',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('4',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/waleed.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Waleed Rajpoot',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('85 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('-1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('5',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/sameer.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Sameer Badar',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('80 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('+1',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('6',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/waleed.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gujjar Singh',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('33 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('-4',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('7',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/waleed.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gujjar Singh',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('33 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('-4',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('8',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/waleed.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gujjar Singh',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('33 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('-4',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                      SizedBox(height: 10,),
                      Container(
                        padding: EdgeInsets.fromLTRB(10, 5, 20, 5),
                        decoration: BoxDecoration(
                            color: Colors.grey[200],
                            borderRadius: BorderRadius.all(Radius.circular(10))
                        ),
                        child: Row(
                          children: [
                            Text('9',
                              style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.w400
                              ),),
                            SizedBox(width: 15,),
                            CircleAvatar(
                              backgroundImage: AssetImage('assets/waleed.jpg'),
                              radius: 30,
                            ),
                            SizedBox(width: 15,),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text('Gujjar Singh',
                                  style: TextStyle(
                                      fontSize: 15
                                  ),),
                                Row(
                                  children: [
                                    Image(image: AssetImage('assets/coin.jpg'),
                                      width: 20,
                                      height: 20,
                                    ),
                                    Text('33 pts')
                                  ],
                                )
                              ],
                            ),
                            Spacer(),
                            Text('-4',
                              style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20
                              ),)
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
