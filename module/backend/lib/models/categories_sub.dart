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
        description: json['DESCRIPTION']?.toString().trim().toUpperCase() ?? '',
        isActive: json['ISACTIVE'] as bool,
        isDelete: json['ISDELETE'] as bool,
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
        'DESCRIPTION': description.trim().toUpperCase(),
        'CATEGORY_ID': categoryId,
        'COMPANY_ID': companyId,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
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
      description: description ?? this.description.trim().toUpperCase(),
      categoryId: categoryId ?? this.categoryId,
      companyId: companyId ?? this.companyId,
      id: id ?? this.id,
      isActive: isActive ?? this.isActive,
      isDelete: isDelete ?? this.isDelete,
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
      description: description.trim().toUpperCase(),
      isActive: true,
      isDelete: false,
    );
  }
  factory CategoriesSub.update(String description, int categoryId) {
    return CategoriesSub(
      categorySub: 0,
      description: description.trim().toUpperCase(),
      categoryId: categoryId,
      companyId: 0,
      id: 0,
      isActive: true,
      isDelete: false,
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
    );
  }
}
