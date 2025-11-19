import 'package:flutter/material.dart';
import 'package:json_annotation/json_annotation.dart';

part 'drafts.g.dart';

@JsonSerializable()
class Drafts {
  final String id;
  @JsonKey(name: 'template_id')
  final String templateId;
  @JsonKey(name: 'document_number')
  final String documentNumber;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'content')
  final String content;
  @JsonKey(name: 'form_data')
  final Map<String, dynamic> formData;
  @JsonKey(name: 'requester_id')
  final String requesterId;
  @JsonKey(name: 'requester_name')
  final String requesterName;
  @JsonKey(name: 'department_id')
  final String? departmentId;
  final DocumentStatus status;
  @JsonKey(name: 'current_step')
  final int currentStep;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'submitted_at')
  final String? submittedAt;
  @JsonKey(name: 'completed_at')
  final String? completedAt;
  @JsonKey(name: 'histories')
  final List<ApprovalHistory>? histories;

  Drafts({
    required this.id,
    required this.templateId,
    required this.documentNumber,
    required this.title,
    required this.content,
    required this.formData,
    required this.requesterId,
    required this.requesterName,
    this.departmentId,
    required this.status,
    required this.currentStep,
    required this.createdAt,
    required this.updatedAt,
    this.submittedAt,
    this.completedAt,
    this.histories,
  });

  factory Drafts.fromJson(Map<String, dynamic> json) => _$DraftsFromJson(json);
  Map<String, dynamic> toJson() => _$DraftsToJson(this);
}

@JsonSerializable()
class ApprovalHistory {
  @JsonKey(name: 'id')
  final String id;
  @JsonKey(name: 'request_id')
  final String requestId;
  @JsonKey(name: 'approver_id')
  final String approverId;
  @JsonKey(name: 'approver_name')
  final String approverName;
  @JsonKey(name: 'action')
  final ApprovalAction action;
  @JsonKey(name: 'comment')
  final String comment;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'ip_address')
  final String ipAddress;

  ApprovalHistory({
    required this.id,
    required this.requestId,
    required this.approverId,
    required this.approverName,
    required this.action,
    required this.comment,
    required this.createdAt,
    required this.ipAddress,
  });

  factory ApprovalHistory.fromJson(Map<String, dynamic> json) =>
      _$ApprovalHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovalHistoryToJson(this);
}

enum DocumentStatus {
  @JsonValue('DRAFT')
  draft('기안', Colors.grey),
  @JsonValue('SUBMITTED')
  submitted('결재대기', Colors.yellow),
  @JsonValue('IN_PROGRESS')
  inProgress('결재중', Color.fromARGB(255, 109, 216, 245)),
  @JsonValue('APPROVED')
  approved('결재완료', Color.fromARGB(255, 213, 213, 213)),
  @JsonValue('REJECTED')
  rejected('반려', Colors.red),
  @JsonValue('CANCELLED')
  cancelled('취소', Colors.grey);

  final String statusText;
  final Color color;

  const DocumentStatus(this.statusText, this.color);
}

enum ApprovalAction {
  @JsonValue('APPROVE')
  approve,
  @JsonValue('REJECT')
  reject,
  @JsonValue('CANCEL')
  cancel,
}
