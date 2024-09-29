// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class ProjectCode extends BaseClass {
  int id;
  int project;
  String description;
  int company_id;
  int start_date;
  int end_date;
  ProjectCode({
    required this.id,
    required this.project,
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
