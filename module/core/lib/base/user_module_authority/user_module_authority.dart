// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class UserModuleAuthority extends BaseClass {
  int id;
  int companyUserRoleID;
  int moduleID;
  int authorID;
  UserModuleAuthority({
    required this.id,
    required this.companyUserRoleID,
    required this.moduleID,
    required this.authorID,
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
