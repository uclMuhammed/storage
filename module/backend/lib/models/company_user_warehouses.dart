import '../base/models.dart';

class CompanyUserWarehouses extends BaseModel<CompanyUserWarehouses> {
  final int companyUserRoleId;
  final int warehousesId;

  CompanyUserWarehouses({
    required this.companyUserRoleId,
    required this.warehousesId,
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

  factory CompanyUserWarehouses.empty() {
    return CompanyUserWarehouses(
      companyUserRoleId: -1,
      warehousesId: -1,
      id: -1,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedBy: '',
      deletedAt: null,
    );
  }
  factory CompanyUserWarehouses.insert(int warehousesId, int userId) {
    return CompanyUserWarehouses(
      companyUserRoleId: userId,
      warehousesId: warehousesId,
      id: -1,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedBy: '',
      deletedAt: null,
    );
  }

  factory CompanyUserWarehouses.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return CompanyUserWarehouses.empty();
    return CompanyUserWarehouses(
      companyUserRoleId:
          int.tryParse(json['COMPANYUSERROLE_ID'].toString()) ?? -1,
      warehousesId: int.tryParse(json['WAREHOUSES_ID'].toString()) ?? -1,
      id: int.tryParse(json['ID'].toString()) ?? -1,
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
  CompanyUserWarehouses fromJson(Map<String, dynamic> json) =>
      CompanyUserWarehouses.fromJson(json);

  @override
  Map<String, dynamic> toJson() => <String, dynamic>{
        'COMPANYUSERROLE_ID': companyUserRoleId,
        'WAREHOUSES_ID': warehousesId,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
      };
}
