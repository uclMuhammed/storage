// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Regions extends BaseClass {
  int region;
  int company_id;
  int city_id;
  int country_id;
  String description;
  Regions({
    required super.id,
    required this.region,
    required this.company_id,
    required this.city_id,
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
