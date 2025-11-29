// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_group_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(getFavoriteGroups)
const getFavoriteGroupsProvider = GetFavoriteGroupsProvider._();

final class GetFavoriteGroupsProvider
    extends
        $FunctionalProvider<
          AsyncValue<List<FavoriteGroup>>,
          List<FavoriteGroup>,
          FutureOr<List<FavoriteGroup>>
        >
    with
        $FutureModifier<List<FavoriteGroup>>,
        $FutureProvider<List<FavoriteGroup>> {
  const GetFavoriteGroupsProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'getFavoriteGroupsProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$getFavoriteGroupsHash();

  @$internal
  @override
  $FutureProviderElement<List<FavoriteGroup>> $createElement(
    $ProviderPointer pointer,
  ) => $FutureProviderElement(pointer);

  @override
  FutureOr<List<FavoriteGroup>> create(Ref ref) {
    return getFavoriteGroups(ref);
  }
}

String _$getFavoriteGroupsHash() => r'448d062fbddc644590ad0178d00f2543c81cabc2';
