import 'package:json_annotation/json_annotation.dart';

part 'favorite_group.g.dart';

@JsonSerializable()
class FavoriteGroup {
  String id;
  @JsonKey(name: 'user_id')
  String userId;
  String name;
  @JsonKey(name: 'approver_ids')
  List<String> approverIds;
  @JsonKey(name: 'approver_names')
  List<String> approverNames;

  FavoriteGroup({
    required this.id,
    required this.userId,
    required this.name,
    required this.approverIds,
    required this.approverNames,
  });

  factory FavoriteGroup.fromJson(Map<String, dynamic> json) =>
      _$FavoriteGroupFromJson(json);
  Map<String, dynamic> toJson() => _$FavoriteGroupToJson(this);
}