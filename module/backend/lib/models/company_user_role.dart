import '../base/models.dart';

class CompanyUserRole extends BaseModel<CompanyUserRole> {
  final int userID;
  final int companyID;
  final int roleID;

  CompanyUserRole({
    required this.userID,
    required this.companyID,
    required this.roleID,
    required super.id,
    required super.isActive,
    required super.isDelete,
    super.createdAt,
    super.createdBy,
    super.updatedAt,
    super.updatedBy,
    super.deletedBy,
    super.deletedAt,
  });

  factory CompanyUserRole.empty() => CompanyUserRole(
        userID: 0,
        companyID: 0,
        roleID: 0,
        id: 0,
        isActive: false,
        isDelete: false,
        createdAt: DateTime.now(),
        createdBy: '',
        updatedAt: null,
        updatedBy: null,
        deletedBy: null,
        deletedAt: null,
      );

  factory CompanyUserRole.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return CompanyUserRole.empty();
    return CompanyUserRole(
      userID: int.tryParse(json['USER_ID'].toString()) ?? -1,
      companyID: int.tryParse(json['COMPANY_ID'].toString()) ?? -1,
      roleID: int.tryParse(json['ROLE_ID'].toString()) ?? -1,
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
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'USER_ID': userID,
      'COMPANY_ID': companyID,
      'ROLE_ID': roleID,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }

  @override
  CompanyUserRole fromJson(Map<String, dynamic> json) =>
      CompanyUserRole.fromJson(json);
}
