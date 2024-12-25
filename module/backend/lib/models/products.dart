import 'package:backend/base/models.dart';

class Products extends BaseModel<Products> {
  final int product;
  final String barcode;
  final String code;
  final String description;
  final int brandId;
  final int categoryId;
  final int companyId;
  final int unitId;
  final int price;
  final String dimensions;
  final double weight;


  Products({
    required this.code,
    required this.product,
    required this.barcode,
    required this.description,
    required this.categoryId,
    required this.companyId,
    required this.brandId,
    required this.unitId,
    required this.price,
    required this.dimensions,
    required this.weight,
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

  factory Products.empty() {
    return Products(
      product: 0,
      barcode: '',
      description: '',
      categoryId: 0,
      companyId: 0,
      brandId: 0,
      unitId: 0,
      price: 0,
      dimensions: '',
      weight: 0.0,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: null,
      updatedBy: "",
      deletedBy: "",
      deletedAt: null, 
      code: '',
    );
  }

  factory Products.insert(
    String barcode,
    String code,
    String description,
    int brandId,
    int categoryId,
    int unitId,
    double price,
    String dimensions,
    double weight,
    ) {
    return Products(
      product: 0,
      code: code,
      barcode: barcode,
      description: description,
      categoryId: categoryId,
      companyId: 0,
      brandId: brandId,
      unitId: unitId,
      price: 0,
      dimensions: dimensions,
      weight: weight,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: null,
      updatedBy: "",
      deletedBy: "",
      deletedAt: null,
    );
  }

  factory Products.update(
    String barcode,
    String code,
    String description,
    int brandId,
    int categoryId,
    int unitId,
    double price,
    String dimensions,
    double weight,
    ) {
    return Products(
      product: 0,
      code: code,
      barcode: barcode,
      description: description,
      categoryId: categoryId,
      companyId: 0,
      brandId: brandId,
      unitId: unitId,
      price: 0,
      dimensions: dimensions,
      weight: weight,
      id: 0,
      isActive: true,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: null,
      updatedBy: "",
      deletedBy: "",
      deletedAt: null,
    );
  }

  factory Products.delete(int id) {
    return Products(
      product: id,
      barcode: '',
      description: '',
      categoryId: 0,
      companyId: 0,
      brandId: 0,
      unitId: 0,
      price: 0,
      dimensions: '',
      weight: 0.0,
      id: 0,
      isActive: false,
      isDelete: true,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: null,
      updatedBy: "",
      deletedBy: "",
      deletedAt: null, code: '',
    );
  }

  factory Products.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Products.empty();
    return Products(
      product: int.tryParse(json['PRODUCT'].toString()) ?? 0,
      barcode: json['BARCODE'] ?? '',
      code: json['CODE'] ?? '',
      description: json['DESCRIPTION'] ?? 'No description',
      categoryId: int.tryParse(json['CATEGORY_ID'].toString()) ?? 0,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      brandId: int.tryParse(json['BRAND_ID'].toString()) ?? 0,
      unitId: int.tryParse(json['UNIT_ID'].toString()) ?? 0,
      price: int.tryParse(json['PRICE'].toString()) ?? 0,
      dimensions: json['DIMENSIONS'] ?? '',
      weight: double.tryParse(json['WEIGHT'].toString()) ?? 0.0,
      id: int.tryParse(json['ID'].toString()) ?? 0,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
      createdAt: DateTime.tryParse(json['CREATEDAT'] ?? '') ?? DateTime(1950),
      createdBy: json['CREATEDBY'] ?? '',
      updatedAt: json['UPDATEDAT'] != null
          ? DateTime.tryParse(json['UPDATEDAT'])
          : null,
      updatedBy: json['UPDATEDBY'] ?? '',
      deletedAt: json['DELETEDAT'] != null
          ? DateTime.tryParse(json['DELETEDAT'])
          : null,
      deletedBy: json['DELETEDBY'] ?? '',
    );
  }

  @override
  Products fromJson(Map<String, dynamic> json) {
    return Products.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'CODE': code,
      'PRODUCT': product,
      'BARCODE': barcode,
      'DESCRIPTION': description,
      'CATEGORY_ID': categoryId,
      'COMPANY_ID': companyId,
      'BRAND_ID': brandId,
      'UNIT_ID': unitId,
      'PRICE': price,
      'DIMENSIONS': dimensions,
      'WEIGHT': weight,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
      'CREATEDAT': createdAt.toString(),
      'CREATEDBY': createdBy,
      'UPDATEDAT': updatedAt.toString(),
      'UPDATEDBY': updatedBy,
      'DELETEDAT': deletedAt.toString(),
      'DELETEDBY': deletedBy,
    };
  }
}
