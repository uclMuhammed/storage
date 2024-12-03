import '../base/models.dart';

class Suppliers extends BaseModel<Suppliers> {
  final int companyId;
  final int regionId;
  final int supplier;
  final String name;
  final String address;
  final String identityNo;
  final String phone;
  final String email;

  Suppliers({
    required this.companyId,
    required this.regionId,
    required this.supplier,
    required this.name,
    required this.address,
    required this.identityNo,
    required this.phone,
    required this.email,
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

  factory Suppliers.empty() {
    return Suppliers(
      companyId: 0,
      regionId: 0,
      supplier: 0,
      name: '',
      address: '',
      identityNo: '',
      phone: '',
      email: '',
      id: 0,
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
  factory Suppliers.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Suppliers.empty();
    return Suppliers(
      companyId: json['COMPANY_ID'],
      regionId: json['REGION_ID'],
      supplier: json['SUPPLIER'],
      name: json['NAME'],
      address: json['ADDRESS'],
      identityNo: json['IDENTITY_NO'],
      phone: json['PHONE'],
      email: json['EMAIL'],
      id: json['ID'],
      isActive: json['ISACTIVE'],
      isDelete: json['ISDELETE'],
      createdAt: DateTime.tryParse(json['CREATEDAT']) ?? DateTime(1950),
      createdBy: json['CREATEDBY'],
      updatedAt: json['UPDATEDAT'] != null ? DateTime.tryParse(json['UPDATEDAT']) : null,
      updatedBy: json['UPDATEDBY'],
      deletedBy: json['DELETEDBY'],
      deletedAt: json['DELETEDAT'] != null ? DateTime.tryParse(json['DELETEDAT']) : null,
    );
  }
  @override
  Suppliers fromJson(Map<String, dynamic> json) {
    return Suppliers.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'CompanyId': companyId,
      'RegionId': regionId,
      'Supplier': supplier,
      'Name': name,
      'Address': address,
      'IdentityNo': identityNo,
      'Phone': phone,
      'Email': email,
      'Id': id,
      'IsActive': isActive,
      'IsDelete': isDelete,
      'CreatedAt': createdAt,
      'CreatedBy': createdBy,
      'UpdatedAt': updatedAt,
      'UpdatedBy': updatedBy,
      'DeletedBy': deletedBy,
      'DeletedAt': deletedAt,
    };
  }
}
