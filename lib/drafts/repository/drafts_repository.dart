import 'package:dio/dio.dart' hide Headers;
import 'package:electronic_approval/drafts/model/favorite_group.dart';
import 'package:retrofit/retrofit.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:electronic_approval/common/pagination/pagination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/dio/dio.dart';

part 'drafts_repository.g.dart';

final draftsRepositoryProvider = Provider<DraftsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return DraftsRepository(dio, baseUrl: '${dio.options.baseUrl}');
});

@RestApi()
abstract class DraftsRepository {
  factory DraftsRepository(Dio dio, {required String baseUrl}) =
      _DraftsRepository;

  @GET('/approvals')
  @Headers({'access_token': true})
  Future<Pagination<Drafts>> getDrafts({
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
    @Query('sort') String? sort,
    @Query('status') String? status,
    @Query('start_at') String? startDate,
    @Query('end_at') String? endDate,
  });

  @POST('/approvals')
  @Headers({'access_token': true})
  @MultiPart()
  Future<Drafts> createDraft({
    @Part(name: 'title') required String title,
    @Part(name: 'content') required String content,
    @Part(name: 'template_id') String? templateId,
    @Part(name: 'form_data') String? formData,
    @Part(name: 'department_id') String? departmentId,
    @Part(name: 'approval_lines') String? approvalLines,
    @Part(name: 'files') List<MultipartFile>? files,
  });

  @GET('/approval-lines/favorite-groups')
  @Headers({'access_token': true})
  Future<List<FavoriteGroup>> getFavoriteGroups();
}
