// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'approver_line.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ApproverLine _$ApproverLineFromJson(Map<String, dynamic> json) => ApproverLine(
  approverId: json['approverId'] as String,
  approverUserId: json['approverUserId'] as String,
  approverName: json['approverName'] as String,
  stepOrder: (json['stepOrder'] as num).toInt(),
  isRequired: json['isRequired'] as bool,
  isParallel: json['isParallel'] as bool,
);

Map<String, dynamic> _$ApproverLineToJson(ApproverLine instance) =>
    <String, dynamic>{
      'approverId': instance.approverId,
      'approverUserId': instance.approverUserId,
      'approverName': instance.approverName,
      'stepOrder': instance.stepOrder,
      'isRequired': instance.isRequired,
      'isParallel': instance.isParallel,
    };
