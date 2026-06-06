// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'rank_progress_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(rankProgress)
const rankProgressProvider = RankProgressProvider._();

final class RankProgressProvider
    extends
        $FunctionalProvider<
          RankProgressService,
          RankProgressService,
          RankProgressService
        >
    with $Provider<RankProgressService> {
  const RankProgressProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'rankProgressProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$rankProgressHash();

  @$internal
  @override
  $ProviderElement<RankProgressService> $createElement(
    $ProviderPointer pointer,
  ) => $ProviderElement(pointer);

  @override
  RankProgressService create(Ref ref) {
    return rankProgress(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(RankProgressService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<RankProgressService>(value),
    );
  }
}

String _$rankProgressHash() => r'83208dff574fc0d2baac9dbf57d62493fdef6737';

@ProviderFor(UserLanguageProgressNotifier)
const userLanguageProgressProvider = UserLanguageProgressNotifierFamily._();

final class UserLanguageProgressNotifierProvider
    extends
        $AsyncNotifierProvider<
          UserLanguageProgressNotifier,
          UserLanguageProgress?
        > {
  const UserLanguageProgressNotifierProvider._({
    required UserLanguageProgressNotifierFamily super.from,
    required String super.argument,
  }) : super(
         retry: null,
         name: r'userLanguageProgressProvider',
         isAutoDispose: true,
         dependencies: null,
         $allTransitiveDependencies: null,
       );

  @override
  String debugGetCreateSourceHash() => _$userLanguageProgressNotifierHash();

  @override
  String toString() {
    return r'userLanguageProgressProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  UserLanguageProgressNotifier create() => UserLanguageProgressNotifier();

  @override
  bool operator ==(Object other) {
    return other is UserLanguageProgressNotifierProvider &&
        other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$userLanguageProgressNotifierHash() =>
    r'a3507d7d827078973f6f562949b46ec844122de6';

final class UserLanguageProgressNotifierFamily extends $Family
    with
        $ClassFamilyOverride<
          UserLanguageProgressNotifier,
          AsyncValue<UserLanguageProgress?>,
          UserLanguageProgress?,
          FutureOr<UserLanguageProgress?>,
          String
        > {
  const UserLanguageProgressNotifierFamily._()
    : super(
        retry: null,
        name: r'userLanguageProgressProvider',
        dependencies: null,
        $allTransitiveDependencies: null,
        isAutoDispose: true,
      );

  UserLanguageProgressNotifierProvider call(String languageId) =>
      UserLanguageProgressNotifierProvider._(argument: languageId, from: this);

  @override
  String toString() => r'userLanguageProgressProvider';
}

abstract class _$UserLanguageProgressNotifier
    extends $AsyncNotifier<UserLanguageProgress?> {
  late final _$args = ref.$arg as String;
  String get languageId => _$args;

  FutureOr<UserLanguageProgress?> build(String languageId);
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build(_$args);
    final ref =
        this.ref
            as $Ref<AsyncValue<UserLanguageProgress?>, UserLanguageProgress?>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<
                AsyncValue<UserLanguageProgress?>,
                UserLanguageProgress?
              >,
              AsyncValue<UserLanguageProgress?>,
              Object?,
              Object?
            >;
    element.handleValue(ref, created);
  }
}
