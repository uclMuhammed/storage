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
}
