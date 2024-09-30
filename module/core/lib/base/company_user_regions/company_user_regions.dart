// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class CompanyUserRegions extends BaseClass {
  int companyUserRoleId;
  int regionId;
  CompanyUserRegions({
    required super.id,
    required this.companyUserRoleId,
    required this.regionId,
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
