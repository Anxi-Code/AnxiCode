import 'dart:convert';

import 'package:anxicode_app/Learning/mod/mcqs_main.dart';
import 'package:anxicode_app/Learning/mod/rank_manifest.dart';
import 'package:anxicode_app/part3_syntax_learnig/part3_model.dart';
import 'package:anxicode_app/part4_debug/part4_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import '../mod/language_model.dart';
import '../mod/rank_model.dart';

class LearningService {
  final supabase = Supabase.instance.client;

  // FETCH LANGUAGES
  Future<List<LanguageModel>> getLanguages() async {
    final response = await supabase
        .from('languages')
        .select()
        .order('name');

    return response
        .map<LanguageModel>(
          (e) => LanguageModel.fromMap(e),
    )
        .toList();
  }

  // FETCH RANKS OF SPECIFIC LANGUAGE
  Future<List<RankModel>> getRanks(
      String languageId,
      ) async {
    final response = await supabase
        .from('ranks')
        .select()
        .eq('language_id', languageId)
        .order('rank_order');

    return response
        .map<RankModel>(
          (e) => RankModel.fromMap(e),
    )
        .toList();
  }
  Future<String> getManifestPath(
      String languageId,
      String rank
      )async{
    final response = await supabase
        .from('rank_manifests')
        .select('manifest_path')
        .eq('language_id', languageId)
    .eq('rank_name', rank);
    return response.first['manifest_path'];
  }
  Future<RankManifest> getRanksManifest(String languageID,String rank)async {
    final path=await getManifestPath(languageID,rank);
    print(path);
    final bytes=await supabase.storage.from('rank_manifests').download(path);
    final response=utf8.decode(bytes);
    final manifest=jsonDecode(response);
    final rankMainfest=RankManifest.fromJson(manifest);
    return rankMainfest;
  }
  Future<String> getMarkdown(String bucket,String path)async{
    print("inside");
    final bytes=await supabase.storage.from(bucket).download(path);
    final content=utf8.decode(bytes);
    print(content);
    return content;
  }
  Future<McqQuiz> getQuiz(String bucket,String path) async {
    print(bucket);
    print(path);
    final bytes = await supabase.storage
        .from(bucket)
        .download(path);
    final content = utf8.decode(bytes);
    final jsonMap = jsonDecode(content) as Map<String, dynamic>;
    print("inside mcqs");
    return McqQuiz.fromJson(jsonMap);
  }
  Future<List<SyntaxChallenge>> getSyntax(String bucket,String path) async {
    print(bucket);
    print(path);
    final bytes = await supabase.storage
        .from(bucket)
        .download(path);
    final content = utf8.decode(bytes);
    final jsonMap = jsonDecode(content);
    print(jsonMap);
    print("inside get syntax");
    return jsonMap.map<SyntaxChallenge>((e)=>SyntaxChallenge.fromJson(e as Map<String, dynamic>)).toList();
  }
  Future<DebuggingData> getDebuggingTasks(String bucket, String path) async {
    final bytes = await supabase.storage.from(bucket).download(path);
    final content = utf8.decode(bytes);

    // Decode as a Map since the JSON starts with {
    final Map<String, dynamic> jsonMap = jsonDecode(content);

    // Let the factory do all the heavy lifting!
    return DebuggingData.fromJson(jsonMap);
  }

}

