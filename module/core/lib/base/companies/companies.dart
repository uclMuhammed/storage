// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Companies extends BaseClass {
  int company;
  String name;
  int ownerId;
  Companies({
    required super.id,
    required this.company,
    required this.name,
    required this.ownerId,
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
