// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Users extends BaseClass {
  int code;
  String email;
  String password;
  bool isOwner;
  bool isAdmin;
  Users({
    required this.code,
    required this.email,
    required this.password,
    required this.isOwner,
    required this.isAdmin,
    required super.id,
    required super.isActive,
    required super.isDelete,
    required super.createDat,
    required super.updateDat,
    required super.deleteDat,
    required super.createBy,
    required super.updatedBy,
    required super.deletedBy,
  });

  factory Users.fromJson(Map<String, dynamic> json) => Users(
        code: json['companyCode'] as int,
        email: json['email'] as String,
        password: json['password'] as String,
        isOwner: json['isOwner'] as bool,
        isAdmin: json['isAdmin'] as bool,
        id: json['id'] as int,
        isActive: json['isActive'] as bool,
        isDelete: json['isDelete'] as bool,
        createDat: json['createDat'] as DateTime,
        updateDat: json['updateDat'] as DateTime,
        deleteDat: json['deleteDat'] as DateTime,
        createBy: json['createBy'] as String,
        updatedBy: json['updatedBy'] as String,
        deletedBy: json['deletedBy'] as String,
      );

  Map<String, dynamic> toJson() => <String, dynamic>{
        'companyCode': code,
        'email': email,
        'password': password,
        'isOwner': isOwner,
        'isAdmin': isAdmin,
        'id': id,
        'isActive': isActive,
        'isDelete': isDelete,
        'createDat': createDat,
        'updateDat': updateDat,
        'deleteDat': deleteDat,
        'createBy': createBy,
        'updatedBy': updatedBy,
        'deletedBy': deletedBy,
      };
}
