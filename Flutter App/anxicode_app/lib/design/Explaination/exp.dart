import 'package:anxicode_app/Constants/constants.dart';
import 'package:anxicode_app/Learning/pro/learning_provider.dart';
import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown_plus/flutter_markdown_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;

class Topic extends ConsumerStatefulWidget {
  final String slug;
  final String path;
  const Topic({super.key,
    required this.slug,
    required this.path});

  @override
  ConsumerState<Topic> createState() => _TopicState();
}

class _TopicState extends ConsumerState<Topic> {

  bool loading = true;
  String data = "";

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getData();
  }
  Future<void> getData() async {
    final learningService = ref.read(learningServiceProvider);
    String markdown = await learningService.getMarkdown(
        widget.slug, widget.path);
    setState(() {
      loading = false;
      data = markdown;
    });
  }



  @override
  Widget build(BuildContext context) {

    return loading ? const Center(child: SpinKitWanderingCubes(color: Colors.cyanAccent,size: 50,),):Padding(
            padding: const EdgeInsets.all(8.0),
            child: Markdown(
              data: data,
              extensionSet: md.ExtensionSet.gitHubWeb,
              styleSheet: MarkdownStyleSheet(
                p: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 15,
                  height: 1.8,
                  fontWeight: FontWeight.w400,
                ),

                h1: GoogleFonts.orbitron(
                  color: Colors.white,
                  fontSize: 26,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 1,
                ),

                h2: GoogleFonts.orbitron(
                  color: const Color(0xFFD6E8FF),
                  fontSize: 22,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 0.8,
                ),

                h3: GoogleFonts.orbitron(
                  color: const Color(0xFFB8D4FF),
                  fontSize: 19,
                  fontWeight: FontWeight.w600,
                ),

                h4: GoogleFonts.orbitron(
                  color: Colors.white70,
                  fontSize: 17,
                  fontWeight: FontWeight.w500,
                ),

                h5: GoogleFonts.orbitron(
                  color: Colors.white60,
                  fontSize: 15,
                  fontWeight: FontWeight.w500,
                ),

                strong: GoogleFonts.orbitron(
                  color: const Color(0xFF8EC5FF),
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),

                tableBody: GoogleFonts.manrope(
                  color: Colors.white,
                  fontSize: 14,
                ),

                tableHead: GoogleFonts.orbitron(
                  color: Colors.cyanAccent,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                ),
                blockSpacing: 20,

                codeblockDecoration: BoxDecoration(
                  color: const Color(0xFF081532),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.cyanAccent,
                      spreadRadius: 1,
                      blurRadius: 10,
                    ),
                  ],
                ),
                tableScrollbarThumbVisibility: true,
                tableBorder: TableBorder.all(
                  color: Colors.cyanAccent,
                  width: 1,
                ),

                tableCellsPadding: EdgeInsets.all(10),
                code: GoogleFonts.jetBrainsMono(color: Colors.cyanAccent,fontSize: 14,fontWeight: FontWeight.bold),
                codeblockPadding: EdgeInsets.all(15),
                listBullet: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),

    );
  }
}
