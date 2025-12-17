// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approver_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproverLine _$ApproverLineFromJson(Map<String, dynamic> json) => ApproverLine(
  approverId: json['approver_id'] as String,
  approverUserId: json['approver_user_id'] as String,
  approverName: json['approver_name'] as String,
  stepOrder: (json['step_order'] as num).toInt(),
  isRequired: json['is_required'] as bool,
  isParallel: json['is_parallel'] as bool,
);

Map<String, dynamic> _$ApproverLineToJson(ApproverLine instance) =>
    <String, dynamic>{
      'approver_id': instance.approverId,
      'approver_user_id': instance.approverUserId,
      'approver_name': instance.approverName,
      'step_order': instance.stepOrder,
      'is_required': instance.isRequired,
      'is_parallel': instance.isParallel,
    };
