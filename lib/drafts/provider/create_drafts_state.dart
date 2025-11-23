import 'package:json_annotation/json_annotation.dart';

part 'create_drafts_state.g.dart';

@JsonSerializable()
class CreateDraftsState {
  final String title;
  final String content;
  final List<String?>? files;
  final bool isSubmitting;
  final String? error;
  CreateDraftsState({
    required this.title,
    required this.content,
    this.files,
    required this.isSubmitting,
    this.error,
  });

  CreateDraftsState copyWith({
    String? title,
    String? content,
    List<String?>? files,
    bool? isSubmitting,
    String? error,
  }) {
    return CreateDraftsState(
      title: title ?? this.title,
      content: content ?? this.content,
      files: files ?? this.files,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: error ?? this.error,
    );
  }

  CreateDraftsState.initial() : this(
    title: '',
    content: '',
    files: [],
    isSubmitting: false,
    error: null,
  );

  factory CreateDraftsState.fromJson(Map<String, dynamic> json) => _$CreateDraftsStateFromJson(json);
  Map<String, dynamic> toJson() => _$CreateDraftsStateToJson(this);
}