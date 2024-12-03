import 'package:backend/base/models.dart';

class Categories extends BaseModel<Categories> {
  final int category;
  final String description;
  final int companyId;

  Categories(
      {required this.description,
      required this.companyId,
      required this.category,
      required super.id,
      required super.isActive,
      required super.isDelete,
      required super.createdAt,
      required super.createdBy,
      required super.updatedAt,
      required super.updatedBy,
      required super.deletedBy,
      required super.deletedAt});

  factory Categories.empty() {
    return Categories(
        description: '',
        category: 0,
        companyId: 0,
        id: 0,
        isActive: false,
        isDelete: false,
        createdAt: DateTime.now(),
        createdBy: '',
        updatedAt: null,
        updatedBy: null,
        deletedBy: null,
        deletedAt: null);
  }

  factory Categories.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Categories.empty();
    return Categories(
      id: int.tryParse(json['ID'].toString()) ?? -1,
      description: json['DESCRIPTION'],
      category: int.tryParse(json['CATEGORY'].toString()) ?? -1,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? -1,
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
  Categories fromJson(Map<String, dynamic> json) {
    return Categories.fromJson(json);
  }

  @override
  // Categories sınıfında toJson metodu
  @override
  Map<String, dynamic> toJson() {
    return {
      'DESCRIPTION': description,
    };
  }
}
