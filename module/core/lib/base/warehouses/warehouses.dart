// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Warehouses extends BaseClass {
  int warehouse;
  String description;
  int region_id;
  int company_id;
  String address;
  Warehouses({
    required this.warehouse,
    required this.description,
    required this.region_id,
    required this.company_id,
    required this.address,
    required super.isActive,
    required super.isDelete,
    required super.createDat,
    required super.updateDat,
    required super.deleteDat,
    required super.createBy,
    required super.updatedBy,
    required super.deletedBy,
    required super.id,
  });

  factory Warehouses.fromJson(Map<String, dynamic> json) => Warehouses(
        warehouse: json['warehouse'] as int,
        description: json['description'] as String,
        region_id: json['region_id'] as int,
        company_id: json['company_id'] as int,
        address: json['address'] as String,
        isActive: json['isActive'] as bool,
        isDelete: json['isDelete'] as bool,
        createDat: json['createDat'] as DateTime,
        updateDat: json['updateDat'] as DateTime,
        deleteDat: json['deleteDat'] as DateTime,
        createBy: json['createBy'] as String,
        updatedBy: json['updatedBy'] as String,
        deletedBy: json['deletedBy'] as String,
        id: json['id'] as int,
      );
}
