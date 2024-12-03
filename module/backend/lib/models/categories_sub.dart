import 'package:backend/base/models.dart';

class CategoriesSub extends BaseModel<CategoriesSub> {
  final int categorySub;
  final String description;
  final int categoryId;
  final int companyId;
  CategoriesSub({
    required this.categorySub,
    required this.description,
    required this.categoryId,
    required this.companyId,
    required super.id,
    required super.isActive,
    required super.isDelete,
    required super.createdAt,
    required super.createdBy,
    required super.updatedAt,
    required super.updatedBy,
    required super.deletedBy,
    required super.deletedAt,
  });

  factory CategoriesSub.empty() {
    return CategoriesSub(
      categorySub: 0,
      description: '',
      categoryId: 0,
      companyId: 0,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }

  factory CategoriesSub.insert(String description, int categoryId) {
    return CategoriesSub(
      categorySub: 0,
      description: description,
      categoryId: categoryId,
      companyId: 0,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }

  factory CategoriesSub.update(int id, String description, int categoryId) {
    return CategoriesSub(
      categorySub: 0,
      description: description,
      categoryId: categoryId,
      companyId: 0,
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }

  factory CategoriesSub.delete(int id) {
    return CategoriesSub(
      categorySub: 0,
      description: '',
      categoryId: 0,
      companyId: 0,
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }

  factory CategoriesSub.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return CategoriesSub.empty();
    return CategoriesSub(
      categorySub: int.tryParse(json['CATEGORY_SUB'].toString()) ?? 0,
      description: json['DESCRIPTION'],
      categoryId: int.tryParse(json['CATEGORY_ID'].toString()) ?? 0,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      id: int.tryParse(json['ID'].toString()) ?? 0,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
      createdAt: DateTime.tryParse(json['CREATEDAT'] ?? '') ?? DateTime(1950),
      createdBy: json['CREATEDBY'],
      updatedAt: json['UPDATEDAT'] != null ? DateTime.tryParse(json['UPDATEDAT']) : null,
      updatedBy: json['UPDATEDBY'],
      deletedAt: json['DELETEDAT'] != null ? DateTime.tryParse(json['DELETEDAT']) : null,
      deletedBy: json['DELETEDBY'],
    );
  }
  @override
  CategoriesSub fromJson(Map<String, dynamic> json) => CategoriesSub.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'CATEGORY_SUB': categorySub,
        'DESCRIPTION': description,
        'CATEGORY_ID': categoryId,
        'COMPANY_ID': companyId,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
        'CREATEDAT': createdAt,
        'CREATEDBY': createdBy,
        'UPDATEDAT': updatedAt,
        'UPDATEDBY': updatedBy,
        'DELETEDAT': deletedAt,
        'DELETEDBY': deletedBy,
      };
}
