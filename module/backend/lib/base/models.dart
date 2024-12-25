abstract class BaseModel<T> {
  final int id;
  final bool isActive;
  final bool isDelete;
  final DateTime? createdAt;
  final String? createdBy;
  final DateTime? updatedAt;
  final String? updatedBy;
  final DateTime? deletedAt;
  final String? deletedBy;

  BaseModel({
    required this.id,
    required this.isActive,
    required this.isDelete,
    this.createdAt,
    this.createdBy,
    this.updatedAt,
    this.updatedBy,
    this.deletedAt,
    this.deletedBy,
  });
  T fromJson(Map<String, dynamic> json);
  Map<String, dynamic> toJson();

  // Utility methods
  bool get isDeleted => isDelete;
  bool get isUpdated => updatedAt != null;
}
