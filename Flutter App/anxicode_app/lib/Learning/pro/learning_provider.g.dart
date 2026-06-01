// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'learning_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(learningService)
const learningServiceProvider = LearningServiceProvider._();

final class LearningServiceProvider
    extends
        $FunctionalProvider<LearningService, LearningService, LearningService>
    with $Provider<LearningService> {
  const LearningServiceProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'learningServiceProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$learningServiceHash();

  @$internal
  @override
  $ProviderElement<LearningService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  LearningService create(Ref ref) {
    return learningService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(LearningService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<LearningService>(value),
    );
  }
}

String _$learningServiceHash() => r'f006c028ca1ace5d256d8908b673d754e3a6cbdf';

@ProviderFor(languages)
const languagesProvider = LanguagesProvider._();

final class LanguagesProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<LanguageModel>>,
          List<LanguageModel>,
          FutureOr<List<LanguageModel>>
        >
    with
        $FutureModifier<List<LanguageModel>>,
        $FutureProvider<List<LanguageModel>> {
  const LanguagesProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languagesProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languagesHash();

  @$internal
  @override
  $FutureProviderElement<List<LanguageModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<LanguageModel>> create(Ref ref) {
    return languages(ref);
  }
}

String _$languagesHash() => r'10e4af3ed36c21c63e4f56c25cfc4ebc3bb0346d';

@ProviderFor(ranks)
const ranksProvider = RanksFamily._();

final class RanksProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<RankModel>>,
          List<RankModel>,
          FutureOr<List<RankModel>>
        >
    with $FutureModifier<List<RankModel>>, $FutureProvider<List<RankModel>> {
  const RanksProvider._({
    required RanksFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'ranksProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ranksHash();

  @override
  String toString() {
    return r'ranksProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<List<RankModel>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<RankModel>> create(Ref ref) {
    final argument = this.argument as String;
    return ranks(ref, argument);
  }

  @override
  bool operator ==(Object other) {
    return other is RanksProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ranksHash() => r'bb8efd96d883c0aa87071d67a7cdc9c8b2b1fa02';

final class RanksFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<List<RankModel>>, String> {
  const RanksFamily._()
    : super(
        retry: null,
        name: r'ranksProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RanksProvider call(String languageId) =>
      RanksProvider._(argument: languageId, from: this);

  @override
  String toString() => r'ranksProvider';
}

@ProviderFor(ranksManifest)
const ranksManifestProvider = RanksManifestFamily._();

final class RanksManifestProvider
    extends
        $FunctionalProvider<
          AsyncValue<RankManifest>,
          RankManifest,
          FutureOr<RankManifest>
        >
    with $FutureModifier<RankManifest>, $FutureProvider<RankManifest> {
  const RanksManifestProvider._({
    required RanksManifestFamily super.from,
    required (String, String) super.argument,
  }) : super(
         retry: null,
         name: r'ranksManifestProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$ranksManifestHash();

  @override
  String toString() {
    return r'ranksManifestProvider'
        ''
        '$argument';
  }

  @$internal
  @override
  $FutureProviderElement<RankManifest> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<RankManifest> create(Ref ref) {
    final argument = this.argument as (String, String);
    return ranksManifest(ref, argument.$1, argument.$2);
  }

  @override
  bool operator ==(Object other) {
    return other is RanksManifestProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$ranksManifestHash() => r'b5ef9ad95d907798171fd76aec6d0f7a68ac9578';

final class RanksManifestFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<RankManifest>, (String, String)> {
  const RanksManifestFamily._()
    : super(
        retry: null,
        name: r'ranksManifestProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  RanksManifestProvider call(String languageId, String rank) =>
      RanksManifestProvider._(argument: (languageId, rank), from: this);

  @override
  String toString() => r'ranksManifestProvider';
}
