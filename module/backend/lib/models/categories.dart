import 'package:backend/base/models.dart';

class Categories extends BaseModel<Categories> {
  final int category;
  final int companyId;
  final String description;

  Categories({
    required super.id,
    required this.category,
    required this.companyId,
    required this.description,
    required super.isActive,
    required super.isDelete,
    super.createdAt,
    super.createdBy,
    super.updatedAt,
    super.updatedBy,
    super.deletedAt,
    super.deletedBy,
  });

  factory Categories.empty() {
    return Categories(
      id: -1,
      category: -1,
      companyId: -1,
      description: '',
      isActive: false,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
    );
  }
  factory Categories.insert(
    String description,
  ) {
    return Categories(
      id: 0,
      category: 0,
      companyId: 0,
      description: description,
      isActive: true,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: 'system',
    );
  }

  factory Categories.update(String description, bool isActive) {
    return Categories(
      id: 0,
      description: description,
      isActive: isActive,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: DateTime.now(),
      updatedBy: '',
      category: 0,
      companyId: 0,
    );
  }
  factory Categories.delete({
    required int id,
  }) {
    return Categories(
      id: id,
      category: 0,
      companyId: 0,
      description: '',
      isActive: false,
      isDelete: true,
      createdAt: DateTime.now(),
      createdBy: 'system',
      updatedAt: DateTime.now(),
      updatedBy: 'system',
      deletedAt: DateTime.now(),
      deletedBy: 'system',
    );
  }

  factory Categories.fromJson(Map<String, dynamic> json) => Categories(
        id: int.tryParse(json['ID'].toString()) ?? -1,
        category: int.tryParse(json['CATEGORY'].toString()) ?? -1,
        companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? -1,
        description: json['DESCRIPTION'],
        isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
        isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
        createdAt: DateTime.tryParse(json['CREATEDAT'] ?? '') ?? DateTime(1950),
        createdBy: json['CREATEDBY'],
        updatedAt: json['UPDATEDAT'] != null
            ? DateTime.tryParse(json['UPDATEDAT'])
            : null,
        updatedBy: json['UPDATEDBY'],
        deletedAt: json['DELETEDAT'] != null
            ? DateTime.tryParse(json['DELETEDAT'])
            : null,
        deletedBy: json['DELETEDBY'],
      );

  @override
  Map<String, dynamic> toJson() => {
        'CATEGORY': category,
        'COMPANY_ID': companyId,
        'DESCRIPTION': description,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
      };

  @override
  Categories fromJson(Map<String, dynamic> json) {
    return Categories.fromJson(json);
  }
}
