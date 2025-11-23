import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';
import 'package:electronic_approval/drafts/model/drafts.dart';
import 'package:electronic_approval/common/pagination/pagination.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/common/dio/dio.dart';

part 'drafts_repository.g.dart';

final draftsRepositoryProvider = Provider<DraftsRepository>((ref) {
  final dio = ref.watch(dioProvider);
  return DraftsRepository(dio, baseUrl: '${dio.options.baseUrl}/approvals');
});

@RestApi()
abstract class DraftsRepository {
  factory DraftsRepository(Dio dio, {required String baseUrl}) = _DraftsRepository;

  @GET('')
  @Headers({'access_token': true})
  Future<Pagination<Drafts>> getDrafts({
    @Query('page') int page = 1,
    @Query('page_size') int pageSize = 20,
    @Query('sort') String? sort,
    @Query('status') String? status,
    @Query('start_at') String? startDate,
    @Query('end_at') String? endDate,
  });

  /*
    title: str = Form(...),
    content: str = Form(...),
    template_id: Optional[str] = Form(None),
    form_data: Optional[str] = Form(None),
    department_id: Optional[str] = Form(None),
    approval_lines: Optional[str] = Form(None),
    files: List[UploadFile] = File(default=[]),
  */

  @POST('')
  @Headers({'access_token': true})
  @MultiPart()
  Future<Drafts> createDraft({
    @Field('title') required String title,
    @Field('content') required String content,
    @Field('template_id') String? templateId,
    @Field('form_data') String? formData,
    @Field('department_id') String? departmentId,
    @Field('approval_lines') String? approvalLines,
    @Part(name: 'files') List<MultipartFile>? files,
  });
}