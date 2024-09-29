// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Suppliers extends BaseClass {
  int id;
  int company_id;
  int region_id;
  int supplier;
  String name;
  String address;
  String identity_no;
  String phone;
  String email;
  Suppliers({
    required this.id,
    required this.company_id,
    required this.region_id,
    required this.supplier,
    required this.name,
    required this.address,
    required this.identity_no,
    required this.phone,
    required this.email,
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
