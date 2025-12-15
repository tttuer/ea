import 'dart:convert';

import 'package:electronic_approval/drafts/model/approver_line.dart';
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

  void setApproverLines(List<ApproverLine>? approverLines) {
    state = state.copyWith(approverLines: approverLines);
  }

  void removeFile(String? file) {
    state = state.copyWith(
      files: state.files?.where((f) => f != file).toList(),
    );
  }

  void addApprover(ApproverLine approverLine) {
    final currentApproverLines = state.approverLines ?? [];
    if (currentApproverLines.any((a) => a.approverUserId == approverLine.approverUserId)) {
      return;
    }
    state = state.copyWith(
      approverLines: [...currentApproverLines, approverLine],
    );
  }

  void addApprovers(List<ApproverLine> approverLines) {
    final currentApproverLines = state.approverLines ?? [];
    for (var approverLine in approverLines) {
      if (currentApproverLines.any((a) => a.approverUserId == approverLine.approverUserId)) {
        continue;
      }
      currentApproverLines.add(approverLine);
    }
    state = state.copyWith(
      approverLines: currentApproverLines,
    );
  }

  void removeApprover(ApproverLine approverLine) {
    final currentApproverLines = state.approverLines ?? [];
    state = state.copyWith(
      approverLines: currentApproverLines
          .where((a) => a.approverUserId != approverLine.approverUserId)
          .toList(),
    );
    
    final reorderedApprovderLines = state.approverLines?.asMap()
    .entries
    .map((entry) => ApproverLine(
      approverId: entry.value.approverId,
      approverUserId: entry.value.approverUserId,
      approverName: entry.value.approverName,
      stepOrder: entry.key,
      isRequired: entry.value.isRequired,
      isParallel: entry.value.isParallel,
    ))
    .toList();

    state = state.copyWith(approverLines: reorderedApprovderLines);
  }

  void redorderApprover(int fromIndex, int toIndex) {
    final currentApproverLines = state.approverLines ?? [];
    final approverLine = currentApproverLines[fromIndex];
    currentApproverLines.removeAt(fromIndex);
    currentApproverLines.insert(toIndex, approverLine);

    final reorderedApprovderLines = currentApproverLines.asMap().entries.map((
      entry,
    ) {
      return ApproverLine(
        approverId: entry.value.approverId,
        approverUserId: entry.value.approverUserId,
        approverName: entry.value.approverName,
        stepOrder: entry.key,
        isRequired: entry.value.isRequired,
        isParallel: entry.value.isParallel,
      );
    }).toList();

    state = state.copyWith(approverLines: reorderedApprovderLines);
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
        approvalLines: state.approverLines != null
            ? jsonEncode(
                state.approverLines!.map((line) => line.toJson()).toList(),
              )
            : null,
      );

      reset();
    } catch (e) {
      state = state.copyWith(error: e.toString());
    } finally {
      setIsSubmitting(false);
    }
  }
}
