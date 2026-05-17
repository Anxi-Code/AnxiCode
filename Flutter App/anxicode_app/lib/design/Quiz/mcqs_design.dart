import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class Mcqs extends StatefulWidget {
  const Mcqs({super.key});

  @override
  State<Mcqs> createState() => _McqsState();
}

class _McqsState extends State<Mcqs> {
  List<Map<String, dynamic>> questions = [
    {
      "question": "What is a variable in C++?",
      "options": [
        "A fixed value that cannot change",
        "A memory location to store data",
        "A loop structure",
        "A compiler error",
      ],
    },
    {
      "question": "Which keyword is used to define a constant in C++?",
      "options": ["var", "const", "let", "final"],
    },
    {
      "question": "Which symbol is used for single-line comment in C++?",
      "options": ["//", "/* */", "#", "<!-- -->"],
    },
    {
      "question": "Which function is the entry point of a C++ program?",
      "options": ["start()", "main()", "run()", "init()"],
    },
    {
      "question": "Which header file is used for input/output in C++?",
      "options": ["<stdio.h>", "<iostream>", "<conio.h>", "<math.h>"],
    },
  ];
  int currentPage=0;
  List options = ['A', 'B', 'C', 'D'];
  String selectedOption = '';
  PageController _controller = PageController(viewportFraction: 1.0);

  void NextPage(){
    if(currentPage<questions.length-1){
      currentPage++;
      _controller.animateToPage(currentPage, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }

  }
  void PreviousPage(){
    if(currentPage>0){
      currentPage--;
      _controller.animateToPage(currentPage, duration: Duration(milliseconds: 400), curve: Curves.easeInOut);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        BgGradient(),
        Scaffold(
          backgroundColor: Colors.transparent,
          appBar: AppBar(
            backgroundColor: Colors.transparent,
            title: Text(
              "Quiz",
              style: GoogleFonts.orbitron(
                color: Colors.white,
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            leading: BackButton(color: Colors.white),
          ),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 10, 14, 0),
                child: Text(
                  "C++ Basics — Variables & Data Types",
                  style: GoogleFonts.orbitron(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              SizedBox(height: 30),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Time left:",
                      style: TextStyle(
                        color: Colors.grey.shade500,
                        fontSize: 16,
                      ),
                    ),
                    Row(
                      children: [
                        Icon(
                          Icons.timer,
                          color: Colors.grey.shade500,
                          size: 14,
                        ),
                        Text(
                          "15:00",
                          style: TextStyle(
                            color: Colors.grey.shade400,
                            fontSize: 16,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              SizedBox(height: 10),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 0, 14, 10),
                child: LinearProgressIndicator(
                  value: 0.5,
                  minHeight: 10,
                  borderRadius: BorderRadius.circular(25),
                  color: Colors.cyanAccent,
                ),
              ),
              SizedBox(height: 10),
              Expanded(
                child: Container(
                  height: double.infinity,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(25),
                      topRight: Radius.circular(25),
                    ),
                    gradient: RadialGradient(
                      radius: 4,
                      colors: [
                        Colors.cyanAccent.withValues(alpha: 0.2),
                        Colors.white.withValues(alpha: 0.2),
                      ],
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Expanded(
                        child: PageView.builder(
                          itemCount: questions.length,
                          controller: _controller,
                          onPageChanged: (index)async{
                             setState(() {
                              selectedOption='';
                              currentPage=index;

                            });
                          },
                          itemBuilder: (context, index) {
                            return Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                                  child: Text(
                                    "Q. ${index + 1}/5",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 10.0),
                                Padding(
                                  padding: const EdgeInsets.fromLTRB(20, 0, 20, 0),
                                  child: Text(
                                    "${questions[index]["question"]}",
                                    style: GoogleFonts.orbitron(
                                      color: Colors.white,
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                SizedBox(height: 25.0),
                                Expanded(
                                  child: ListView.builder(
                                    itemCount: questions[index]["options"].length,
                                    itemBuilder: (context, index) {
                                      return Padding(
                                        padding: const EdgeInsets.fromLTRB(20, 10, 20, 10),
                                        child: GestureDetector(
                                          onTap: () {
                                            setState(() {
                                              selectedOption = options[index];
                                            });
                                          },
                                          child: Container(
                                            height: 70,
                                            width: 150,
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(20),
                                              border: Border.all(
                                                color: selectedOption==options[index]?Colors.cyanAccent:Colors.transparent,
                                                width: 1.5
                                              ),
                                              boxShadow: selectedOption==options[index]?[
                                                BoxShadow(
                                                  color: Colors.cyanAccent.withOpacity(0.4),
                                                  spreadRadius: 3,
                                                  blurRadius: 15,
                                                )

                                              ]:[],
                                              gradient: RadialGradient(
                                                radius: 4,
                                                colors: [
                                                  Colors.cyanAccent.withValues(alpha: 0.3),
                                                  Colors.white.withValues(alpha: 0.1),
                                                ],
                                              ),

                                          ),
                                            child: Padding(
                                              padding: const EdgeInsets.all(14.0),
                                              child: Row(
                                                crossAxisAlignment: CrossAxisAlignment.center,
                                                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                                children: [
                                                  Text("${options[index]}.",style: GoogleFonts.orbitron(
                                                    color: selectedOption==options[index]?Colors.cyanAccent:Colors.white,
                                                    fontSize: 16,
                                                    fontWeight: FontWeight.bold,
                                                  ),),
                                                  SizedBox(width: 10,),
                                                  Expanded(child: Text("${questions[currentPage]["options"][index]}",style: GoogleFonts.orbitron(
                                                    color: selectedOption==options[index]?Colors.cyanAccent:Colors.white,
                                                    fontSize: 15,
                                                    fontWeight: FontWeight.bold,
                                                  ),))
                                                ],
                                              ),
                                            ),
                                        ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
                            );
                          },
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 0,20,20),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.grey.withValues(alpha: 0.4),
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey.withOpacity(0.5),
                                      spreadRadius: 2,
                                      blurRadius: 18,
                                    )
                                  ],

                              ),
                              child: ElevatedButton(
                                onPressed: PreviousPage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,

                                ),
                                child: Text(
                                  "Previous",
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              height: 40,
                              width: 150,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20),
                                color:currentPage==questions.length-1 ? Colors.greenAccent.withValues(alpha: 0.6): Colors.cyanAccent.withValues(alpha: 0.6),
                                boxShadow: [
                                  BoxShadow(
                                    color:currentPage==questions.length-1 ? Colors.greenAccent.withValues(alpha: 0.5): Colors.cyanAccent.withOpacity(0.5),
                                    spreadRadius: 2,
                                    blurRadius: 18,
                                  )
                                ],

                              ),
                              child: ElevatedButton(
                                onPressed: NextPage,
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: Colors.transparent,
                                  shadowColor: Colors.transparent,

                                ),
                                child: Text(
                                  currentPage==questions.length-1 ? "Submit":"Next",
                                  style: GoogleFonts.orbitron(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 16,
                                    letterSpacing: 0.5,
                                  ),
                                ),
                              ),
                            )

                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),

            ],
          ),
        ),
      ],
    );
  }
}
