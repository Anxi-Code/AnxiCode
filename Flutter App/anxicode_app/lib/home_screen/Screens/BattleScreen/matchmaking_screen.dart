import 'package:flutter/material.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

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
    await supabase.rpc('create_battle');
    final battleId = await current_user_battleid();
    if (battleId == null) {
      return null;
    }
    final result = await supabase
        .from("battle_participants")
        .select("user_id")
        .eq("battle_id", battleId);

    print("got opponent getting to username ");

    final opponentUsername = await supabase
        .from("profiles")
        .select("user_name")
        .eq("id", result[0]["user_id"]);
    final username = await supabase
        .from("profiles")
        .select("user_name")
        .eq("id", supabase.auth.currentUser!.id);
    final code = await supabase
        .from("battles")
        .select("join_code")
        .eq("id", battleId);

    setState(() {
      opp_username = opponentUsername[0]["user_name"] ?? "";
      my_username = username[0]["user_name"] ?? "";
      otp = code[0]["join_code"] ?? "";
      loading = false;
    });
    return opp_username;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.orange.shade100,
      appBar: AppBar(
        title: const Text("Matchmaking"),
        centerTitle: true,
        backgroundColor: Colors.orange.shade100,
        elevation: 0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                    my_username,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
              Text("VS", style: TextStyle(color: Colors.white, fontSize: 20)),
              loading
                  ? CircularProgressIndicator(color: Colors.white)
                  : Text(
                    opp_username,
                    style: TextStyle(color: Colors.white, fontSize: 20),
                  ),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(otp, style: TextStyle(color: Colors.white, fontSize: 20)),
            ],
          ),
        ],
      ),
    );
  }
}
