import 'package:anxicode_app/Rank_System/user_language_progress.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class RankProgressService {
  final supabase=Supabase.instance.client;


  Future<UserLanguageProgress?> getProgress({
    required String userId,
    required String languageId,
  }) async {
    final data = await supabase
        .from('user_language_progress')
        .select()
        .eq('user_id', userId)
        .eq('language_id', languageId)
        .maybeSingle();

    if (data == null) return null;

    return UserLanguageProgress.fromJson(data);
  }

  

}