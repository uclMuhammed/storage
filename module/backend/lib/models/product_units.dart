import '../base/models.dart';

class ProductUnits extends BaseModel<ProductUnits> {
  final int unit;
  final String description;
  final double quantity;
  final int companyid;
  ProductUnits({
    required this.unit,
    required this.description,
    required this.quantity,
    required this.companyid,
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

  factory ProductUnits.empty() {
    return ProductUnits(
      unit: 0,
      description: '',
      quantity: 0,
      companyid: 0,
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

  factory ProductUnits.insert(String description, double quantity) {
    return ProductUnits(
      unit: 0,
      description: description,
      quantity: quantity,
      companyid: 0,
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

  factory ProductUnits.update(
      String description, double quantity, bool? isActive) {
    return ProductUnits(
      unit: 0,
      description: description,
      quantity: quantity,
      companyid: 0,
      id: 0,
      isActive: isActive ?? true,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: null,
      updatedBy: "",
      deletedBy: "",
      deletedAt: null,
    );
  }

  factory ProductUnits.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProductUnits.empty();
    return ProductUnits(
      unit: int.tryParse(json['UNIT'].toString()) ?? 0,
      description: json['DESCRIPTION'],
      quantity: double.tryParse(json['QUANTITY'].toString()) ?? 0,
      companyid: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      id: int.tryParse(json['ID'].toString()) ?? 0,
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
  }
  @override
  ProductUnits fromJson(Map<String, dynamic> json) {
    return ProductUnits.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'UNIT': unit,
      'DESCRIPTION': description,
      'QUANTITY': quantity,
      'COMPANY_ID': companyid,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
