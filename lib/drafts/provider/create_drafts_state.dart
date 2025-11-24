import 'package:electronic_approval/drafts/model/approver_line.dart';
import 'package:json_annotation/json_annotation.dart';

part 'create_drafts_state.g.dart';

@JsonSerializable()
class CreateDraftsState {
  final String title;
  final String content;
  final List<String?>? files;
  final List<ApproverLine>? approverLines;
  final bool isSubmitting;
  final String? error;

  CreateDraftsState({
    required this.title,
    required this.content,
    this.files,
    this.approverLines,
    required this.isSubmitting,
    this.error,
  });

  CreateDraftsState copyWith({
    String? title,
    String? content,
    List<String?>? files,
    List<ApproverLine>? approverLines,
    bool? isSubmitting,
    String? error,
  }) {
    return CreateDraftsState(
      title: title ?? this.title,
      content: content ?? this.content,
      files: files ?? this.files,
      approverLines: approverLines ?? this.approverLines,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
    );
  }

  CreateDraftsState.initial()
    : this(
        title: '',
        content: '',
        files: [],
        approverLines: [],
        isSubmitting: false,
        error: null,
      );

  factory CreateDraftsState.fromJson(Map<String, dynamic> json) =>
      _$CreateDraftsStateFromJson(json);
  Map<String, dynamic> toJson() => _$CreateDraftsStateToJson(this);
}
