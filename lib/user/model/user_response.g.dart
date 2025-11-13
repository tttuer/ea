// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserResponse _$UserResponseFromJson(Map<String, dynamic> json) => UserResponse(
  id: json['id'] as String,
  name: json['name'] as String,
  userId: json['userId'] as String,
  createdAt: json['createdAt'] as String,
  updatedAt: json['updatedAt'] as String,
  roles: (json['roles'] as List<dynamic>)
      .map((e) => $enumDecode(_$RoleEnumMap, e))
      .toList(),
);

Map<String, dynamic> _$UserResponseToJson(UserResponse instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'userId': instance.userId,
      'createdAt': instance.createdAt,
      'updatedAt': instance.updatedAt,
      'roles': instance.roles.map((e) => _$RoleEnumMap[e]!).toList(),
    };

const _$RoleEnumMap = {
  Role.user: 'USER',
  Role.admin: 'ADMIN',
  Role.voucher: 'VOUCHER',
};
