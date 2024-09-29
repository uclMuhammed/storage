// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class TaxRate extends BaseClass {
  int id;
  String tax;
  String description;
  int company_id;
  TaxRate({
    required this.id,
    required this.tax,
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
