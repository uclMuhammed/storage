// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Categories extends BaseClass {
  int category;
  String description;
  int company_id;
  Categories({
    required super.id,
    required this.category,
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
