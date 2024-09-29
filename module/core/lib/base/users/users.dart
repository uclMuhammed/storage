import 'package:core/base/base.dart';

class Users extends BaseClass {
  int id;
  int code;
  String email;
  String passwordHash;
  Users({
    required this.id,
    required this.code,
    required this.email,
    required this.passwordHash,
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
