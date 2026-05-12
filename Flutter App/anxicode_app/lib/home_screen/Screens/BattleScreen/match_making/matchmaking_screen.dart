import 'package:anxicode_app/design/bg_gradient/bg_gradient.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class Matchmaking extends StatefulWidget {
  const Matchmaking({super.key});

  @override
  State<Matchmaking> createState() => _MatchmakingState();
}

class _MatchmakingState extends State<Matchmaking> {
  bool loading = true;
  String opp_username = '';
  String my_username = '';
  String otp = '';
  final supabase = Supabase.instance.client;
  @override
  void initState() {
    super.initState();
    find_opponent();
  }

  Future<String?> current_user_battleid() async {
    final userid = supabase.auth.currentUser?.id;
    if (userid == null) {
      return null;
    }
    final result = await supabase
        .from("battle_participants")
        .select("battle_id")
        .eq("user_id", userid);

    return result[0]["battle_id"];
  }

  Future<String?> find_opponent() async {
    await supabase.rpc(
        'create_battle',
      params: {
          'p_user1':supabase.auth.currentUser!.id,
      }
    );
    final battleId = await current_user_battleid();
    if (battleId == null) {
      return null;
    }
    final result = await supabase
        .from("battle_participants")
        .select("user_id")
        .eq("battle_id", battleId);

    print("got opponent getting to username ");
    print(result);

    final opponent_username = await supabase
        .from("profiles")
        .select("user_name")
        .eq("id", result[1]["user_id"]);
    final username = await supabase
        .from("profiles")
        .select("user_name")
        .eq("id", supabase.auth.currentUser!.id);
    final code = await supabase
        .from("battles")
        .select("join_code")
        .eq("id", battleId);

    setState(() {
      opp_username = opponent_username[0]["user_name"] ?? "";
      my_username = username[0]["user_name"] ?? "";
      otp = code[0]["join_code"] ?? "";
      loading = false;
    });
    return opp_username;
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children:[
        BgGradient(),
        Scaffold(
        backgroundColor: Colors.transparent,

        appBar: AppBar(
          title: const Text("Matchmaking", style: TextStyle(color: Colors.white)),
          centerTitle: true,
          backgroundColor: Colors.transparent,
          elevation: 0,
          leading: BackButton(color: Colors.white),
        ),
        body: Container(
          height: double.infinity,
          width: double.infinity,
          decoration: BoxDecoration(
            color: Colors.transparent
          ),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 150,
                      width: 150,
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
                          CircleAvatar(
                            radius: 38,
                            backgroundImage: AssetImage('assets/images/user1.png'),
                          ),
                          SizedBox(height: 12.0),
                          loading
                              ? SpinKitThreeBounce(
                                color: Colors.cyanAccent,
                                size: 20,
                              )
                              : Text(
                                my_username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        ],
                      ),
                    ),
                    SizedBox(height: 10,),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        loading
                            ? SpinKitDoubleBounce(
                              color: Colors.cyanAccent,
                              size: 40,
                            )
                            : Text(
                              "VS",
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                        SizedBox(height: 10.0),
                        loading
                            ? Text(
                              "Finding match...",
                              style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            )
                            : Text(""),
                      ],
                    ),
                    SizedBox(height: 20,),
                    Container(
                      height: 150,
                      width: 150,
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
                          CircleAvatar(
                            radius: 38,
                            backgroundImage: AssetImage('assets/images/user3.png'),
                          ),
                          SizedBox(height: 12.0),
                          loading
                              ? SpinKitThreeBounce(
                                color: Colors.cyanAccent,
                                size: 20,
                              )
                              : Text(
                                opp_username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20.0),
                Container(
                  height: 50,
                  width: 180,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
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
                      Text(
                        "OTP: ",
                        style: TextStyle(color: Colors.white, fontSize: 16),
                      ),
                      SizedBox(width: 10),
                      Text(
                        otp,
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      IconButton(
                        onPressed: () async {
                          await Clipboard.setData(ClipboardData(text: otp));
                        },
                        icon: Icon(
                          size: 22,
                          Icons.copy_rounded,
                          color: Colors.cyanAccent,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    ]
    );
  }
}
