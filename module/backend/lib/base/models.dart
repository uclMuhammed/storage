abstract class BaseModel<T> {
  final int id;
  final bool isActive;
  final bool isDelete;
  final DateTime createdAt;
  final String createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final String? deletedBy;
  final DateTime? deletedAt;

  BaseModel({
    required this.id,
    required this.isActive,
    required this.isDelete,
    required this.createdAt,
    required this.createdBy,
    required this.updatedAt,
    required this.updatedBy,
    required this.deletedBy,
    required this.deletedAt,
  });

  T fromJson(Map<String, dynamic> json);

  Map<String, dynamic> toJson();
}
