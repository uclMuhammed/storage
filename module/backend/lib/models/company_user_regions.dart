import '../base/models.dart';

class CompanyUserRegions extends BaseModel<CompanyUserRegions> {
  final int companyUserRoleId;
  final int regionId;
  CompanyUserRegions({
    required super.id,
    required this.companyUserRoleId,
    required this.regionId,
    required super.isActive,
    required super.isDelete,
    required super.createdAt,
    required super.createdBy,
    required super.updatedAt,
    required super.updatedBy,
    required super.deletedBy,
    required super.deletedAt,
  });

  factory CompanyUserRegions.empty() => CompanyUserRegions(
        id: -1,
        companyUserRoleId: -1,
        regionId: -1,
        isActive: false,
        isDelete: false,
        createdAt: DateTime(1950),
        createdBy: '',
        updatedAt: DateTime(1950),
        updatedBy: '',
        deletedBy: '',
        deletedAt: DateTime(1950),
      );

  factory CompanyUserRegions.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return CompanyUserRegions.empty();
    return CompanyUserRegions(
      id: int.tryParse(json['ID'].toString()) ?? -1,
      companyUserRoleId: int.tryParse(json['COMPANYUSERROLE_ID'].toString()) ?? -1,
      regionId: int.tryParse(json['REGION_ID'].toString()) ?? -1,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
      createdAt: DateTime.tryParse(json['CREATEDAT'] ?? '') ?? DateTime(1950),
      createdBy: json['CREATEDBY'],
      updatedAt: json['UPDATEDAT'] != null ? DateTime.tryParse(json['UPDATEDAT']) : null,
      updatedBy: json['UPDATEDBY'],
      deletedAt: json['DELETEDAT'] != null ? DateTime.tryParse(json['DELETEDAT']) : null,
      deletedBy: json['DELETEDBY'],
    );
  }
  @override
  CompanyUserRegions fromJson(Map<String, dynamic> json) => CompanyUserRegions.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'id': id,
        'companyUserRoleId': companyUserRoleId,
        'regionId': regionId,
        'isActive': isActive,
        'isDelete': isDelete,
        'createdAt': createdAt.toIso8601String(),
        'createdBy': createdBy,
        'updatedAt': updatedAt?.toIso8601String(),
        'updatedBy': updatedBy,
        'deletedAt': deletedAt?.toIso8601String(),
        'deletedBy': deletedBy
      };
}
