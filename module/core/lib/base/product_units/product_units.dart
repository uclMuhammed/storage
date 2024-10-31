// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class ProductUnits extends BaseClass {
  int unit;
  String description;
  int quantity;
  int companyid;
  ProductUnits({
    required super.id,
    required this.unit,
    required this.description,
    required this.quantity,
    required this.companyid,
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
