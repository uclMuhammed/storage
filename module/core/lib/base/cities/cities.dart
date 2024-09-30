// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Cities extends BaseClass {
  int city;
  int country_id;
  String description;
  Cities({
    required super.id,
    required this.city,
    required this.country_id,
    required this.description,
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
