import 'package:backend/base/models.dart';

class Warehouses extends BaseModel<Warehouses> {
  final int warehouse;
  final String description;
  final int regionId;
  final int companyId;
  final int cityId;
  final String address;

  Warehouses({
    required this.cityId,
    required this.warehouse,
    required this.description,
    required this.regionId,
    required this.companyId,
    required this.address,
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

  factory Warehouses.empty() {
    return Warehouses(
      cityId: 0,
      warehouse: 0,
      description: '',
      regionId: 0,
      companyId: 0,
      address: '',
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: "",
      updatedAt: DateTime.now(),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime.now(),
    );
  }
  factory Warehouses.insert(String description,int regionId,int cityId,String address) {
    return Warehouses(
      cityId: cityId,
      warehouse: 0,
      description: description,
      regionId: regionId,
      companyId: 0,
      address: address,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: "",
      updatedAt: DateTime.now(),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime.now(),
    );
  }
  factory Warehouses.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Warehouses.empty();
    return Warehouses(
      cityId: int.tryParse(json['CITY_ID'].toString()) ?? -1,
      warehouse: int.tryParse(json['WAREHOUSE'].toString()) ?? -1,
      description: json['DESCRIPTION'],
      regionId: int.tryParse(json['REGION_ID'].toString()) ?? -1,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? -1,
      address: json['ADDRESS'],
      id: int.tryParse(json['ID'].toString()) ?? -1,
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
  Warehouses fromJson(Map<String, dynamic> json) => Warehouses.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'CITY_ID': cityId,
      'WAREHOUSE': warehouse,
      'DESCRIPTION': description,
      'REGION_ID': regionId,
      'COMPANY_ID': companyId,
      'ADDRESS': address,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
