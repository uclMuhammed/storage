// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class ReferenceCode extends BaseClass {
  int id;
  int reference;
  String description;
  int company_id;
  DateTime start_date;
  DateTime end_date;
  ReferenceCode({
    required this.id,
    required this.reference,
    required this.description,
    required this.company_id,
    required this.start_date,
    required this.end_date,
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
