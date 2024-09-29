// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class CompanyUserWarehouses extends BaseClass {
  int id;
  int companyUserRoleId;
  int warehouses_id;
  CompanyUserWarehouses({
    required this.id,
    required this.companyUserRoleId,
    required this.warehouses_id,
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
