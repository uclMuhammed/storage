// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class ProductStats extends BaseClass {
  int product_id;
  int purchases;
  int sales;
  double avr_cost;
  double avr_sale;
  ProductStats({
    required super.id,
    required this.product_id,
    required this.purchases,
    required this.sales,
    required this.avr_cost,
    required this.avr_sale,
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
