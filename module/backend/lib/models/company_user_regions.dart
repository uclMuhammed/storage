import '../base/models.dart';

class CompanyUserRegions extends BaseModel<CompanyUserRegions> {
  final int companyUserId;
  final int companyUserRoleId; // Eklendi
  final int regionId;

  CompanyUserRegions({
    required this.companyUserId,
    required this.companyUserRoleId, // Eklendi
    required this.regionId,
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
  factory CompanyUserRegions.empty() {
    return CompanyUserRegions(
      id: -1,
      companyUserId: -1, // Alan adı değişti
      companyUserRoleId: -1,
      regionId: -1,
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

  factory CompanyUserRegions.insert(
    int regionId,
    int companyUserId,
    int companyUserRoleId,
  ) {
    return CompanyUserRegions(
      id: -1,
      companyUserId: companyUserId, // Token'dan gelen CompanyUserId (53)
      companyUserRoleId: companyUserRoleId, // Token'dan gelen RoleId (1)
      regionId: regionId,
      isActive: true,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedBy: null,
      deletedAt: null,
    );
  }

  factory CompanyUserRegions.update(int id) {
    return CompanyUserRegions(
      id: id,
      companyUserId: -1, // Alan adı değişti
      companyUserRoleId: -1,
      regionId: -1,
      isActive: true,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: DateTime(1950),
      updatedBy: '',
      deletedBy: '',
      deletedAt: DateTime(1950),
    );
  }

  factory CompanyUserRegions.delete(int id) {
    return CompanyUserRegions(
      id: id,
      companyUserId: -1, // Alan adı değişti
      regionId: -1,
      companyUserRoleId: -1,
      isActive: false,
      isDelete: true,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: DateTime(1950),
      updatedBy: '',
      deletedBy: '',
      deletedAt: DateTime(1950),
    );
  }

  factory CompanyUserRegions.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return CompanyUserRegions.empty();
    return CompanyUserRegions(
      id: int.tryParse(json['ID'].toString()) ?? -1,
      companyUserId: int.tryParse(json['COMPANY_USER_ID'].toString()) ?? -1,
      companyUserRoleId: int.tryParse(json['COMPANYUSERROLE_ID'].toString()) ??
          -1, // Alan adını değiştirdik
      regionId: int.tryParse(json['REGION_ID'].toString()) ?? -1,
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
  CompanyUserRegions fromJson(Map<String, dynamic> json) =>
      CompanyUserRegions.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'ID': id,
        'COMPANY_USER_ID': companyUserId,
        'COMPANYUSERROLE_ID': companyUserRoleId, // Alan adını değiştirdik
        'REGION_ID': regionId,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
      };
}
