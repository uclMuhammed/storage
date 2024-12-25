import '../base/models.dart';

class Users extends BaseModel<Users> {
  final int userCode;
  final String email;
  final String password;
  final bool isAdmin;
  Users({
    required this.userCode,
    required this.email,
    required this.password,
    required this.isAdmin,
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

  factory Users.empty() {
    return Users(
      userCode: -1,
      email: '',
      password: '',
      isAdmin: false,
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
  factory Users.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Users.empty();
    //
    return Users(
      userCode: int.tryParse(json['USER_CODE'].toString()) ?? -1,
      email: json['EMAIL'],
      password: json['PASSWORD'],
      isAdmin: bool.tryParse(json['ISADMIN'].toString()) ?? false,
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
  Users fromJson(Map<String, dynamic> json) {
    return Users.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'USER_CODE': userCode,
      'EMAIL': email,
      'PASSWORD': password,
      'ISADMIN': isAdmin,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
