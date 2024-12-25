import '../base/models.dart';

class Brands extends BaseModel<Brands> {
  final int brand;
  final int companyId;
  final String description;

  Brands({
    required this.brand,
    required this.companyId,
    required this.description,
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

  factory Brands.empty() {
    return Brands(
      id: -1,
      brand: -1,
      companyId: -1,
      description: '',
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedBy: null,
      deletedAt: null,
    );
  }

  factory Brands.insert(String description) {
    return Brands(
      id: -1,
      brand: -1,
      companyId: -1,
      description: description,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedBy: null,
      deletedAt: null,
    );
  }

  factory Brands.update(int id, String description) {
    return Brands(
      id: id,
      brand: -1,
      companyId: -1,
      description: description,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedBy: null,
      deletedAt: null,
    );
  }
  factory Brands.delete(int id) {
    return Brands(
      id: id,
      brand: -1,
      companyId: -1,
      description: '',
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedBy: null,
      deletedAt: null,
    );
  }

  factory Brands.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Brands.empty();
    //
    return Brands(
      id: int.tryParse(json['ID'].toString()) ?? -1,
      brand: int.tryParse(json['BRAND'].toString()) ?? -1,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? -1,
      description: json['DESCRIPTION'].toString(),
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
      // Tarih alanları için null kontrolü ve parse işlemi
      createdAt: json['CREATEDAT'] != null
          ? DateTime.tryParse(json['CREATEDAT'].toString()) ?? DateTime(1950)
          : DateTime(1950),
      createdBy: json['CREATEDBY']?.toString() ?? '',
      updatedAt: json['UPDATEDAT'] != null
          ? DateTime.tryParse(json['UPDATEDAT'].toString())
          : null,
      updatedBy: json['UPDATEDBY']?.toString(),
      deletedAt: json['DELETEDAT'] != null
          ? DateTime.tryParse(json['DELETEDAT'].toString())
          : null,
      deletedBy: json['DELETEDBY']?.toString(),
    );
  }

  @override
  Brands fromJson(Map<String, dynamic> json) {
    return Brands.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'COMPANY_ID': companyId,
      'BRAND': brand,
      'DESCRIPTION': description,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
