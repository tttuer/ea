// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  id: json['id'] as String,
  name: json['name'] as String,
  userId: json['user_id'] as String,
  createdAt: json['created_at'] as String,
  updatedAt: json['updated_at'] as String,
  roles: (json['roles'] as List<dynamic>)
      .map((e) => $enumDecode(_$RoleEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'user_id': instance.userId,
      'created_at': instance.createdAt,
      'updated_at': instance.updatedAt,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]!).toList(),
    };

const _$RoleEnumMap = {
  Role.user: 'USER',
  Role.admin: 'ADMIN',
  Role.voucher: 'VOUCHER',
};
