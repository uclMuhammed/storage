// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Brands extends BaseClass {
  int id;
  int brand;
  String description;
  int company_id;
  Brands({
    required this.id,
    required this.brand,
    required this.description,
    required this.company_id,
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
