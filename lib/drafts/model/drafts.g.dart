// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'drafts.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Drafts _$DraftsFromJson(Map<String, dynamic> json) => Drafts(
  id: json['id'] as String,
  templateId: json['template_id'] as String,
  documentNumber: json['document_number'] as String,
  title: json['title'] as String,
  content: json['content'] as String,
  formData: json['form_data'] as Map<String, dynamic>,
  requesterId: json['requester_id'] as String,
  requesterName: json['requester_name'] as String,
  departmentId: json['department_id'] as String,
  status: $enumDecode(_$DocumentStatusEnumMap, json['status']),
  currentStep: (json['current_step'] as num).toInt(),
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  submittedAt: json['submitted_at'] as String,
  completedAt: json['completed_at'] as String,
  histories: (json['histories'] as List<dynamic>)
      .map((e) => ApprovalHistory.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$DraftsToJson(Drafts instance) => <String, dynamic>{
  'id': instance.id,
  'template_id': instance.templateId,
  'document_number': instance.documentNumber,
  'title': instance.title,
  'content': instance.content,
  'form_data': instance.formData,
  'requester_id': instance.requesterId,
  'requester_name': instance.requesterName,
  'department_id': instance.departmentId,
  'status': _$DocumentStatusEnumMap[instance.status]!,
  'current_step': instance.currentStep,
  'created_at': instance.createdAt,
  'updated_at': instance.updatedAt,
  'submitted_at': instance.submittedAt,
  'completed_at': instance.completedAt,
  'histories': instance.histories,
};

const _$DocumentStatusEnumMap = {
  DocumentStatus.draft: 'DRAFT',
  DocumentStatus.submitted: 'SUBMITTED',
  DocumentStatus.inProgress: 'IN_PROGRESS',
  DocumentStatus.approved: 'APPROVED',
  DocumentStatus.rejected: 'REJECTED',
  DocumentStatus.cancelled: 'CANCELLED',
};

ApprovalHistory _$ApprovalHistoryFromJson(Map<String, dynamic> json) =>
    ApprovalHistory(
      id: json['id'] as String,
      requestId: json['request_id'] as String,
      approverId: json['approver_id'] as String,
      approverName: json['approver_name'] as String,
      action: $enumDecode(_$ApprovalActionEnumMap, json['action']),
      comment: json['comment'] as String,
      createdAt: json['created_at'] as String,
      ipAddress: json['ip_address'] as String,
    );

Map<String, dynamic> _$ApprovalHistoryToJson(ApprovalHistory instance) =>
    <String, dynamic>{
      'id': instance.id,
      'request_id': instance.requestId,
      'approver_id': instance.approverId,
      'approver_name': instance.approverName,
      'action': _$ApprovalActionEnumMap[instance.action]!,
      'comment': instance.comment,
      'created_at': instance.createdAt,
      'ip_address': instance.ipAddress,
    };

const _$ApprovalActionEnumMap = {
  ApprovalAction.approve: 'APPROVE',
  ApprovalAction.reject: 'REJECT',
  ApprovalAction.cancel: 'CANCEL',
};
