// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'create_drafts_state.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CreateDraftsState _$CreateDraftsStateFromJson(Map<String, dynamic> json) =>
    CreateDraftsState(
      title: json['title'] as String,
      content: json['content'] as String,
      files: (json['files'] as List<dynamic>?)
          ?.map((e) => e as String?)
          .toList(),
      approverLines: (json['approverLines'] as List<dynamic>?)
          ?.map((e) => ApproverLine.fromJson(e as Map<String, dynamic>))
          .toList(),
      isSubmitting: json['isSubmitting'] as bool,
      error: json['error'] as String?,
    );

Map<String, dynamic> _$CreateDraftsStateToJson(CreateDraftsState instance) =>
    <String, dynamic>{
      'title': instance.title,
      'content': instance.content,
      'files': instance.files,
      'approverLines': instance.approverLines,
      'isSubmitting': instance.isSubmitting,
      'error': instance.error,
    };
