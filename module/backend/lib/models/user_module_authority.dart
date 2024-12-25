import 'package:backend/base/models.dart';

class UserModuleAuthority extends BaseModel<UserModuleAuthority> {
  final int companyUserRoleID;
  final int moduleID;
  final int authorID;
  UserModuleAuthority({
    required this.companyUserRoleID,
    required this.moduleID,
    required this.authorID,
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

  factory UserModuleAuthority.empty() {
    return UserModuleAuthority(
      companyUserRoleID: -1,
      moduleID: -1,
      authorID: -1,
      id: -1,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedAt: null,
      deletedBy: '',
    );
  }
  factory UserModuleAuthority.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return UserModuleAuthority.empty();
    return UserModuleAuthority(
      companyUserRoleID:
          int.tryParse(json['COMPANYUSERROLE_ID'].toString()) ?? -1,
      moduleID: int.tryParse(json['MODULE_ID'].toString()) ?? -1,
      authorID: int.tryParse(json['AUTHOR_ID'].toString()) ?? -1,
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
  UserModuleAuthority fromJson(Map<String, dynamic> json) {
    return UserModuleAuthority.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => {
        'COMPANYUSERROLE_ID': companyUserRoleID,
        'MODULE_ID': moduleID,
        'AUTHOR_ID': authorID,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
      };
}
