import 'package:backend/abstract/models.dart';

class Categories extends IModel<Categories> {
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
        'CREATEDAT': createdAt,
        'CREATEDBY': createdBy,
        'UPDATEDAT': updatedAt,
        'UPDATEDBY': updatedBy,
        'DELETEDAT': deletedAt,
        'DELETEDBY': deletedBy,
      };

  @override
  Categories fromJson(Map<String, dynamic> json) {
    return Categories.fromJson(json);
  }

  @override
  Categories copyWith({
    int? category,
    int? companyId,
    String? description,
    int? id,
    bool? isActive,
    bool? isDelete,
    DateTime? createdAt,
    String? createdBy,
    DateTime? updatedAt,
    String? updatedBy,
    DateTime? deletedAt,
    String? deletedBy,
  }) {
    return Categories(
      category: category ?? this.category,
      companyId: companyId ?? this.companyId,
      description: description ?? this.description,
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      isDelete: isDelete ?? this.isDelete,
      createdAt: createdAt ?? this.createdAt,
      createdBy: createdBy ?? this.createdBy,
      updatedAt: updatedAt ?? this.updatedAt,
      updatedBy: updatedBy ?? this.updatedBy,
      deletedAt: deletedAt ?? this.deletedAt,
      deletedBy: deletedBy ?? this.deletedBy,
    );
  }

  factory Categories.empty() {
    return Categories(
      id: -1,
      category: -1,
      companyId: -1,
      description: '',
      isActive: false,
      isDelete: false,
      createdAt: null,
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
      createdAt: null,
      createdBy: '',
    );
  }

  factory Categories.update(String description, bool isActive) {
    return Categories(
      id: 0,
      description: description,
      isActive: isActive,
      isDelete: false,
      createdAt: null,
      createdBy: '',
      updatedAt: null,
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
      createdAt: null,
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedAt: null,
      deletedBy: '',
    );
  }
}
