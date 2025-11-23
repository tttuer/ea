import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:electronic_approval/drafts/provider/create_drafts_state.dart';
import 'package:electronic_approval/drafts/repository/drafts_repository.dart';
import 'package:dio/dio.dart';

final createDraftsProvider =
    NotifierProvider<CreateDraftsNotifier, CreateDraftsState>(
      () => CreateDraftsNotifier(),
    );

class CreateDraftsNotifier extends Notifier<CreateDraftsState> {
  late final DraftsRepository _draftsRepository = ref.watch(
    draftsRepositoryProvider,
  );
  @override
  CreateDraftsState build() {
    return CreateDraftsState.initial();
  }

  void setTitle(String title) {
    state = state.copyWith(title: title);
  }

  void setContent(String content) {
    state = state.copyWith(content: content);
  }

  void setFiles(List<String?>? files) {
    state = state.copyWith(files: files);
  }

  void setIsSubmitting(bool isSubmitting) {
    state = state.copyWith(isSubmitting: isSubmitting);
  }

  void removeFile(String? file) {
    state = state.copyWith(files: state.files?.where((f) => f != file).toList());
  }

  void reset() {
    state = CreateDraftsState.initial();
  }

  Future<void> createDraft() async {
    try {
      setIsSubmitting(true);

      List<MultipartFile>? files;
      if (state.files != null && state.files!.isNotEmpty) {
        files = [];
        for (var filePath in state.files!) {
          if (filePath != null) {
            final file = await MultipartFile.fromFile(filePath);
            files.add(file);
          }
        }
      }

      await _draftsRepository.createDraft(
        title: state.title,
        content: state.content,
        files: files,
      );

      reset();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      setIsSubmitting(false);
    }
  }
}
