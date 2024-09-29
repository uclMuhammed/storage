// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Warehouses extends BaseClass {
  int id;
  int warehouse;
  String description;
  int region_id;
  int company_id;
  String address;
  Warehouses({
    required this.id,
    required this.warehouse,
    required this.description,
    required this.region_id,
    required this.company_id,
    required this.address,
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
