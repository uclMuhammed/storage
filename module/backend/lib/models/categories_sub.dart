import 'package:backend/abstract/models.dart';
import 'package:flutter/foundation.dart';

class CategoriesSub extends IModel<CategoriesSub> {
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

  factory CategoriesSub.fromJson(Map<String, dynamic> json) {
    if (kDebugMode) {
      print('Raw JSON Input: $json');
    }

    try {
      final categorySub = CategoriesSub(
        id: json['ID'] is int ? json['ID'] : int.parse(json['ID'].toString()),
        categorySub: json['CATEGORY_SUB'] is int
            ? json['CATEGORY_SUB']
            : int.parse(json['CATEGORY_SUB'].toString()),
        categoryId: json['CATEGORY_ID'] is int
            ? json['CATEGORY_ID']
            : int.parse(json['CATEGORY_ID'].toString()),
        companyId: json['COMPANY_ID'] is int
            ? json['COMPANY_ID']
            : int.parse(json['COMPANY_ID'].toString()),
        description: json['DESCRIPTION'] as String,
        isActive: json['ISACTIVE'] as bool,
        isDelete: json['ISDELETE'] as bool,
        createdAt: json['CREATEDAT'] != null
            ? DateTime.parse(json['CREATEDAT'].toString())
            : DateTime.now(),
        createdBy: json['CREATEDBY'] as String? ?? '',
        updatedAt: json['UPDATEDAT'] != null
            ? DateTime.tryParse(json['UPDATEDAT'].toString())
            : null,
        updatedBy: json['UPDATEDBY'] as String?,
        deletedAt: json['DELETEDAT'] != null
            ? DateTime.tryParse(json['DELETEDAT'].toString())
            : null,
        deletedBy: json['DELETEDBY'] as String?,
      );

      if (kDebugMode) {
        print('Successfully parsed CategoriesSub: ${categorySub.toJson()}');
      }

      return categorySub;
    } catch (e, stackTrace) {
      if (kDebugMode) {
        print('JSON Parse Error: $e');
        print('Stack Trace: $stackTrace');
        print('Problematic JSON: $json');
      }
      rethrow;
    }
  }

  @override
  CategoriesSub fromJson(Map<String, dynamic> json) =>
      CategoriesSub.fromJson(json);

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

  @override
  CategoriesSub copyWith({
    int? categorySub,
    String? description,
    int? categoryId,
    int? companyId,
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
    return CategoriesSub(
      categorySub: categorySub ?? this.categorySub,
      description: description ?? this.description,
      categoryId: categoryId ?? this.categoryId,
      companyId: companyId ?? this.companyId,
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

  factory CategoriesSub.insert(
    String description,
    int categoryId,
  ) {
    return CategoriesSub(
      id: 0,
      categorySub: 0,
      categoryId: categoryId,
      companyId: 0,
      description: description,
      isActive: true,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedAt: null,
      deletedBy: null,
    );
  }
  factory CategoriesSub.update(String description, int categoryId) {
    return CategoriesSub(
      categorySub: 0,
      description: description,
      categoryId: categoryId,
      companyId: 0,
      id: 0,
      isActive: true,
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
      isDelete: true,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }
}
