// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Products extends BaseClass {
  int id;
  int product;
  int barcode;
  String description;
  int category_id;
  int company_id;
  int brand_id;
  int unit_id;
  int price;
  String dimensions;
  double weight;
  Products({
    required this.id,
    required this.product,
    required this.barcode,
    required this.description,
    required this.category_id,
    required this.company_id,
    required this.brand_id,
    required this.unit_id,
    required this.price,
    required this.dimensions,
    required this.weight,
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
