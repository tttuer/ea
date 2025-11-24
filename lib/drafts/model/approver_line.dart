import 'package:json_annotation/json_annotation.dart';

part 'approver_line.g.dart';

@JsonSerializable()
class ApproverLine {
  String approverId;
  String approverUserId;
  String approverName;
  int stepOrder;
  bool isRequired;
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
