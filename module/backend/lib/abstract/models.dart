import 'dart:convert';

abstract class IModel<T> {
  final int? id;
  final bool? isActive;
  final bool? isDelete;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String? deletedBy;

  IModel({
    this.id,
    this.isActive,
    this.isDelete,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.deletedBy,
  });

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();

  T copyWith();

  String encodedJson() => json.encode(toJson());

  T decodedJson(String json) => fromJson(jsonDecode(json));
}
