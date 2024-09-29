// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class ProductMovement extends BaseClass {
  int id;
  int company_id;
  int warehouse_id;
  int supplier_id;
  int product_id;
  int product_price;
  int entry_price;
  int quantity;
  int tax_rate;
  int discount;
  int total_cost;
  DateTime transaction_date;
  int document_no;
  String description;
  int project_code;
  int reference_code;
  bool is_purchases;
  bool is_return;
  ProductMovement({
    required this.id,
    required this.company_id,
    required this.warehouse_id,
    required this.supplier_id,
    required this.product_id,
    required this.product_price,
    required this.entry_price,
    required this.quantity,
    required this.tax_rate,
    required this.discount,
    required this.total_cost,
    required this.transaction_date,
    required this.document_no,
    required this.description,
    required this.project_code,
    required this.reference_code,
    required this.is_purchases,
    required this.is_return,
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
