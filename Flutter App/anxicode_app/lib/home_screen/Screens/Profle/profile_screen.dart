import 'package:anxicode_app/home_screen/Screens/Profle/achievements.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> with SingleTickerProviderStateMixin{
  late AnimationController _controller;
  late Animation<int>   _percentageAnimation;
  late Animation<double> _progressAnimation;
  List<IconData> badges=[
    Icons.military_tech,
    Icons.whatshot,
    Icons.code,
    Icons.psychology,
  ];
@override
  void initState() {
    // TODO: implement initState
  _controller=AnimationController(
      vsync: this,
      duration: Duration(seconds: 1)
  );
  _percentageAnimation=IntTween(begin: 0,end: 81).animate(_controller);
  _progressAnimation=Tween<double>(begin: 1,end: 0.81).animate(_controller);
  _controller.forward();


    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Container(
            height: 120,
            width: 120,
            padding: EdgeInsetsGeometry.all(5.0),
            decoration: BoxDecoration(
                boxShadow: [
                  BoxShadow(
                    color: Colors.blueAccent.withOpacity(0.5),
                    spreadRadius: 5,
                    blurRadius: 7,

                  )
                ],
                shape: BoxShape.circle,
                border: Border.all(
                    color: Colors.cyanAccent,
                    width: 2.5
                )
            ),
            child: CircleAvatar(
              backgroundImage: AssetImage('assets/images/user1.png'),

            ),
          ),
          SizedBox(height: 12,),
          Text("Meesum Afzaal",style: GoogleFonts.orbitron(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 18),),

          SizedBox(height: 6,),
          Text("Shadow Coder",style: GoogleFonts.orbitron(color: Colors.grey.shade400,fontWeight: FontWeight.bold,fontSize: 12),),
          SizedBox(height: 20,),
          Padding(
            padding: const EdgeInsets.fromLTRB(14.0, 14.0, 14.0, 0),
            child: SizedBox(
              height: 230,
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      width: double.infinity,

                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        gradient: RadialGradient(
                          radius: 4,
                          colors: [
                            Colors.cyanAccent.withValues(alpha: 0.1),
                            Colors.white.withValues(alpha: 0.2),
                          ],
                        ),
                      ),
                      child: AnimatedBuilder(animation: _controller, builder: (context,child){
                        return Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Stack(
                                alignment: Alignment.center,
                                children: [
                                  Container(
                                    height: 110,
                                    width: 110,
                                    padding: EdgeInsetsGeometry.all(8),
                                    decoration: BoxDecoration(
                                        shape: BoxShape.circle,
                                        boxShadow: [
                                          BoxShadow(
                                            color: Colors.cyanAccent.withOpacity(0.5),
                                            spreadRadius: 3,
                                            blurRadius: 20,

                                          ),
                                        ],
                                        border: Border.all(
                                            color: Colors.cyanAccent,
                                            width: 2

                                        )
                                    ),
                                    child:  CircularProgressIndicator(
                                      value:_progressAnimation.value,
                                      valueColor: AlwaysStoppedAnimation(Colors.cyanAccent),
                                      strokeWidth: 6,
                                    ),
                                  ),
                                  Text("${_percentageAnimation.value}%",style: GoogleFonts.orbitron(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),)
                                ]
                            ),
                            SizedBox(height: 15,),
                            Text("Win Rate",style: TextStyle(
                              color: Colors.grey.shade400,
                              fontSize: 22,
                              fontWeight: FontWeight.bold,
                            ),)

                          ],
                        );
                      })

                    ),
                  ),
                 SizedBox(width: 8,),
                 Expanded(
                   child: Column(
                     mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                     children: [
                       Expanded(
                         child: Container(
                           height: double.infinity,
                           width: double.infinity,
                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             gradient: RadialGradient(
                               radius: 4,
                               colors: [
                                 Colors.cyanAccent.withValues(alpha: 0.1),
                                 Colors.white.withValues(alpha: 0.2),
                               ],
                             ),

                           ),
                           child: Column(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Text("Total Battles Played",
                                 style: TextStyle(
                                   color: Colors.grey.shade400,
                                   fontSize: 16,
                                   fontWeight: FontWeight.bold,
                                 ),
                               ),
                               SizedBox(height: 8,),
                               TweenAnimationBuilder(
                                   tween: IntTween(begin: 0,end: 100),
                                   duration: Duration(seconds: 1),
                                   builder:(context,value,child){
                                     return Text("$value",
                                       style: GoogleFonts.orbitron(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 20),);
                                   }),


                             ],
                           ),
                         ),
                       ),
                       SizedBox(height: 8,),

                       Expanded(
                         child: Container(
                           height: double.infinity,
                           width: double.infinity,

                           decoration: BoxDecoration(
                             borderRadius: BorderRadius.circular(15),
                             gradient: RadialGradient(
                               radius: 4,
                               colors: [
                                 Colors.cyanAccent.withValues(alpha: 0.1),
                                 Colors.white.withValues(alpha: 0.2),
                               ],
                             ),

                           ),
                           child: Row(
                             mainAxisAlignment: MainAxisAlignment.center,
                             children: [
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("Won",style: TextStyle(color: Colors.grey.shade400,fontSize: 20,fontWeight: FontWeight.bold),),
                                   SizedBox(height: 8,),
                                   TweenAnimationBuilder(
                                       tween: IntTween(begin: 0,end: 81),
                                       duration: Duration(seconds: 1),
                                       builder:(context,value,child){
                                         return Text("$value",
                                           style: GoogleFonts.orbitron(color: Colors.lightGreenAccent,fontWeight:FontWeight.bold,fontSize: 22),);
                                       }),
                                 ],
                               ),
                               SizedBox(width: 30,),
                               Column(
                                 mainAxisAlignment: MainAxisAlignment.center,
                                 children: [
                                   Text("Lost",style: TextStyle(color: Colors.grey.shade400,fontSize: 20,fontWeight: FontWeight.bold),),
                                   SizedBox(height: 8,),
                                   TweenAnimationBuilder(
                                       tween: IntTween(begin: 0,end: 19),
                                       duration: Duration(seconds: 1),
                                       builder:(context,value,child){
                                         return Text("$value",
                                           style: GoogleFonts.orbitron(color: Colors.red,fontWeight:FontWeight.bold,fontSize: 22),);
                                       }),

                                 ],
                               ),
                             ],
                           ),
                         ),
                       ),

                     ],
                   ),
                 ),
                ],
              ),
            ),
          ),
         Padding(
           padding: const EdgeInsets.all(14.0),
           child: GestureDetector(
               onTap: (){
                 Navigator.push(context, MaterialPageRoute(builder: (context)=>Achievements()));
               },
               child: Container(
                   height: 150,
                   width: double.infinity,
                   decoration: BoxDecoration(
                     borderRadius: BorderRadius.circular(15),
                     gradient: RadialGradient(
                       radius: 4,
                       colors: [
                         Colors.cyanAccent.withValues(alpha: 0.1),
                         Colors.white.withValues(alpha: 0.2),
                       ],
                     ),
                   ),
                 child: Padding(
                   padding: const EdgeInsets.all(14.0),
                   child: Column(
                     children: [
                       Row(
                         mainAxisAlignment: MainAxisAlignment.start,
                         children: [
                           Container(
                             height: 35,
                             width: 35,
                             decoration: BoxDecoration(
                               shape: BoxShape.circle,
                               boxShadow: [

                                 BoxShadow(
                                   color: Colors.yellow.withOpacity(0.5),
                                   spreadRadius: 1,
                                   blurRadius: 7,

                                 ),
                               ]
                             ),
                             child: Icon(Icons.emoji_events,color: Colors.yellow),
                           ),
                           SizedBox(width: 10,),
                           Text("Achievements",style: GoogleFonts.orbitron(color: Colors.white,fontWeight:FontWeight.bold,fontSize: 14),),
                           SizedBox(width: 10,),
                           Icon(Icons.arrow_forward_ios,color: Colors.grey.shade400,size: 16)
                         ],
                       ),
                       SizedBox(height: 14,),
                       SizedBox(
                         height: 70,
                         child: ListView.builder(
                             scrollDirection: Axis.horizontal,
                             itemCount: 4,
                             itemBuilder: (context,index){
                               return Padding(
                                 padding: const EdgeInsets.fromLTRB(0, 0,0 , 0),
                                 child: Container(
                                   height: 76,
                                   width: 76,
                                   decoration: BoxDecoration(
                                       shape: BoxShape.circle,
                                       gradient: RadialGradient(
                                         radius: 4,
                                         colors: [
                                           Colors.cyanAccent.withValues(alpha: 0.1),
                                           Colors.white.withValues(alpha: 0.5),
                                         ],

                                       )
                                   ),
                                   child: Icon(
                                     badges[index],
                                     color: Colors.yellow,
                                     size: 30,

                                   ),
                                 ),
                               );
                             }
                         ),
                       )

                     ],
                   ),
                 ),
               ),
             ),

         ),

        ],
      ),
    );
  }
}
