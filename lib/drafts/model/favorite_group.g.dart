// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorite_group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FavoriteGroup _$FavoriteGroupFromJson(Map<String, dynamic> json) =>
    FavoriteGroup(
      id: json['id'] as String,
      userId: json['user_id'] as String,
      name: json['name'] as String,
      approverIds: (json['approver_ids'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
      approverNames: (json['approver_names'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$FavoriteGroupToJson(FavoriteGroup instance) =>
    <String, dynamic>{
      'id': instance.id,
      'user_id': instance.userId,
      'name': instance.name,
      'approver_ids': instance.approverIds,
      'approver_names': instance.approverNames,
    };
