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
  final String departmentId;
  final DocumentStatus status;
  @JsonKey(name: 'current_step')
  final int currentStep;
  @JsonKey(name: 'created_at')
  final String createdAt;
  @JsonKey(name: 'updated_at')
  final String updatedAt;
  @JsonKey(name: 'submitted_at')
  final String submittedAt;
  @JsonKey(name: 'completed_at')
  final String completedAt;
  @JsonKey(name: 'histories')
  final List<ApprovalHistory> histories;

  Drafts({
    required this.id,
    required this.templateId,
    required this.documentNumber,
    required this.title,
    required this.content,
    required this.formData,
    required this.requesterId,
    required this.requesterName,
    required this.departmentId,
    required this.status,
    required this.currentStep,
    required this.createdAt,
    required this.updatedAt,
    required this.submittedAt,
    required this.completedAt,
    required this.histories,
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

  factory ApprovalHistory.fromJson(Map<String, dynamic> json) => _$ApprovalHistoryFromJson(json);
  Map<String, dynamic> toJson() => _$ApprovalHistoryToJson(this);
}

enum DocumentStatus {
  @JsonValue('DRAFT')
  draft,
  @JsonValue('SUBMITTED')
  submitted,
  @JsonValue('IN_PROGRESS')
  inProgress,
  @JsonValue('APPROVED')
  approved,
  @JsonValue('REJECTED')
  rejected,
  @JsonValue('CANCELLED')
  cancelled,
}

enum ApprovalAction {
  @JsonValue('APPROVE')
  approve,
  @JsonValue('REJECT')
  reject,
  @JsonValue('CANCEL')
  cancel,
}
