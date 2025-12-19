// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'problem_categories_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(problemCategoriesList)
const problemCategoriesListProvider = ProblemCategoriesListProvider._();

final class ProblemCategoriesListProvider
    extends $FunctionalProvider<List<String>, List<String>, List<String>>
    with $Provider<List<String>> {
  const ProblemCategoriesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'problemCategoriesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$problemCategoriesListHash();

  @$internal
  @override
  $ProviderElement<List<String>> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  List<String> create(Ref ref) {
    return problemCategoriesList(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(List<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<List<String>>(value),
    );
  }
}

String _$problemCategoriesListHash() =>
    r'bc9bb2523c4477007a0382e8422dbc720a60867f';
