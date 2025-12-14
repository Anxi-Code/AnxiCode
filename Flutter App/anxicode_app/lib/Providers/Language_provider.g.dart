// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Language_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(languagesList)
const languagesListProvider = LanguagesListProvider._();

final class LanguagesListProvider
    extends
        $FunctionalProvider<List<Languages>, List<Languages>, List<Languages>>
    with $Provider<List<Languages>> {
  const LanguagesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'languagesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$languagesListHash();

  @$internal
  @override
  $ProviderElement<List<Languages>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<Languages> create(Ref ref) {
    return languagesList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<Languages> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<Languages>>(value),
    );
  }
}

String _$languagesListHash() => r'1654184c1e19b4c498ec7c7a4192c99f5fe9f873';
