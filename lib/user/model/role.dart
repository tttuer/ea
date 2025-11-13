import 'package:json_annotation/json_annotation.dart';

enum Role {
  @JsonValue('USER')
  user,
  @JsonValue('ADMIN')
  admin,
  @JsonValue('VOUCHER')
  voucher,
}
