import 'dart:convert';

import 'package:anxicode_app/Learning/mod/mcqs_main.dart';
import 'package:anxicode_app/Learning/mod/parts_model.dart';
import 'package:anxicode_app/Learning/mod/rank_manifest.dart';
import 'package:anxicode_app/Learning/mod/rank_metadata.dart';
import 'package:anxicode_app/Learning/pro/learning_provider.dart';
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
      )async{
    final response = await supabase
        .from('rank_metadata')
        .select('manifest_path')
        .eq('language_id', languageId);
    return response.first['manifest_path'];
  }
  Future<RankManifest> getRanksManifest(String languageID)async {
    final _path=await getManifestPath(languageID);
    final splittedPath = _path.split('/');
    final bucket=splittedPath.first;
    final path=splittedPath.sublist(1).join('/');
    final bytes=await supabase.storage.from(bucket).download(path);
    final response=utf8.decode(bytes);
    final manifest=jsonDecode(response);
    final rankMainfest=RankManifest.fromJson(manifest);
    return rankMainfest;
  }
  Future<String> getMarkdown(String path)async{
    final splittedPath = path.split('/');
    final bucket=splittedPath.first;
    final path1=splittedPath.sublist(1).join('/');
    final bytes=await supabase.storage.from(bucket).download(path1);
    final content=utf8.decode(bytes);
    return content;
  }
  Future<McqQuiz> getQuiz(String path) async {
    final splittedPath = path.split('/');
    final bucket = splittedPath.first;
    final filePath = splittedPath.sublist(1).join('/');
    final bytes = await supabase.storage
        .from(bucket)
        .download(filePath);
    final content = utf8.decode(bytes);
    final jsonMap = jsonDecode(content) as Map<String, dynamic>;
    return McqQuiz.fromJson(jsonMap);
  }

}

