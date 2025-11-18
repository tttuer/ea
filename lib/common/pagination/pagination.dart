import 'package:json_annotation/json_annotation.dart';

part 'pagination.g.dart';

@JsonSerializable(
  genericArgumentFactories: true,
)
class Pagination<T> {
  final int total;
  final int page;
  @JsonKey(name: 'page_size')
  final int pageSize;
  @JsonKey(name: 'total_pages')
  final int totalPages;
  final List<T> items;


  Pagination({
    required this.total,
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.items,
  });

  factory Pagination.fromJson(
    Map<String, dynamic> json,
    T Function(dynamic) fromJsonT,
  ) => _$PaginationFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(T Function(T) toJsonT) =>
      _$PaginationToJson(this, toJsonT);
}
