// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class CompanyUserRole extends BaseClass {
  int userID;
  int companyID;
  int roleID;
  CompanyUserRole({
    required super.id,
    required this.userID,
    required this.companyID,
    required this.roleID,
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
