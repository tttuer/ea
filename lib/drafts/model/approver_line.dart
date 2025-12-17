import 'package:json_annotation/json_annotation.dart';

part 'approver_line.g.dart';

@JsonSerializable()
class ApproverLine {
  @JsonKey(name: 'approver_id')
  String approverId;
  @JsonKey(name: 'approver_user_id')
  String approverUserId;
  @JsonKey(name: 'approver_name')
  String approverName;
  @JsonKey(name: 'step_order')
  int stepOrder;
  @JsonKey(name: 'is_required')
  bool isRequired;
  @JsonKey(name: 'is_parallel')
  bool isParallel;

  ApproverLine({
    required this.approverId,
    required this.approverUserId,
    required this.approverName,
    required this.stepOrder,
    required this.isRequired,
    required this.isParallel,
  });

  factory ApproverLine.fromJson(Map<String, dynamic> json) =>
      _$ApproverLineFromJson(json);
  Map<String, dynamic> toJson() => _$ApproverLineToJson(this);
}
