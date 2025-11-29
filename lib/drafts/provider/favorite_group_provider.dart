import 'package:electronic_approval/drafts/model/favorite_group.dart';
import 'package:electronic_approval/drafts/repository/drafts_repository.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'favorite_group_provider.g.dart';

@riverpod
Future<List<FavoriteGroup>> getFavoriteGroups(Ref ref) async {
  final draftsRepository = ref.watch(draftsRepositoryProvider);
  return await draftsRepository.getFavoriteGroups();
}