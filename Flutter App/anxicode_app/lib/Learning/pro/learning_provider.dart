import 'package:anxicode_app/Learning/mod/language_model.dart';
import 'package:anxicode_app/Learning/mod/rank_manifest.dart';
import 'package:anxicode_app/Learning/mod/rank_metadata.dart';
import 'package:anxicode_app/Learning/mod/rank_model.dart';
import 'package:anxicode_app/Learning/Services/learning_service.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';



part 'learning_provider.g.dart';

@riverpod
LearningService learningService(
    Ref ref,
    ) {
  return LearningService();
}

@riverpod
Future<List<LanguageModel>> languages(
    Ref ref,
    ) async {
  final service = ref.watch(
    learningServiceProvider,
  );

  return service.getLanguages();
}

@riverpod
Future<List<RankModel>> ranks(
    Ref ref,
    String languageId,
    ) async {
  final service = ref.watch(
    learningServiceProvider,
  );

  return service.getRanks(languageId);
}
@riverpod
Future<RankManifest> ranksManifest(Ref ref, String languageId) async {
  final service = ref.watch(learningServiceProvider);
  return service.getRanksManifest(languageId);
}
