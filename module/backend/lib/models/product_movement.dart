import '../base/models.dart';

// ignore: depend_on_referenced_packages
import 'package:intl/intl.dart';

class ProductMovement extends BaseModel<ProductMovement> {
  final int warehouseId;
  final int supplierId;
  final int companyId;
  final int productId;
  final int price;
  final double quantity;
  final int taxId;
  final double taxRate;
  final int discount;
  final double totalCost;
  final DateTime transactionDate;
  final String documentNo;
  final String description;
  final int projectId;
  final int referenceId;
  final bool isPurchases;
  final bool isReturn;

  ProductMovement({
    required this.taxId,
    required this.warehouseId,
    required this.supplierId,
    required this.companyId,
    required this.productId,
    required this.price,
    required this.quantity,
    required this.taxRate,
    required this.discount,
    required this.totalCost,
    required this.transactionDate,
    required this.documentNo,
    required this.description,
    required this.projectId,
    required this.referenceId,
    required this.isPurchases,
    required this.isReturn,
    required super.id,
    required super.isActive,
    required super.isDelete,
    super.createdAt,
    super.createdBy,
    super.updatedAt,
    super.updatedBy,
    super.deletedBy,
    super.deletedAt,
  });

  factory ProductMovement.empty() {
    return ProductMovement(
      taxId: 0,
      warehouseId: 0,
      supplierId: 0,
      companyId: 0,
      productId: 0,
      price: 0,
      quantity: 0,
      taxRate: 0,
      discount: 0,
      totalCost: 0,
      transactionDate: DateTime.now(),
      documentNo: "",
      description: '',
      projectId: 0,
      referenceId: 0,
      isPurchases: false,
      isReturn: false,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }

  factory ProductMovement.insert(
    int warehouseId,
    int supplierId,
    int productId,
    int price,
    double quantity,
    int taxId,
    DateTime transactionDate,
    String documentNo,
    String description,
    int projectId,
    int referenceId,
    bool isPurchases,
    bool isReturn,
  ) {
    return ProductMovement(
      taxId: taxId,
      warehouseId: warehouseId,
      supplierId: supplierId,
      companyId: 0,
      productId: productId,
      price: price,
      quantity: quantity,
      taxRate: 0,
      discount: 0,
      totalCost: 0,
      transactionDate: DateTime.now(),
      documentNo: documentNo,
      description: description,
      projectId: projectId,
      referenceId: referenceId,
      isPurchases: isPurchases,
      isReturn: isReturn,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }

  factory ProductMovement.update(
    int warehouseId,
    int supplierId,
    int productId,
    int price,
    double quantity,
    int taxId,
    DateTime transactionDate,
    String documentNo,
    String description,
    int projectId,
    int referenceId,
    bool isPurchases,
    bool isReturn,
  ) {
    return ProductMovement(
      taxId: taxId,
      warehouseId: warehouseId,
      supplierId: supplierId,
      companyId: 0,
      productId: productId,
      price: price,
      quantity: quantity,
      taxRate: 0,
      discount: 0,
      totalCost: 0,
      transactionDate: DateTime.now(),
      documentNo: documentNo,
      description: description,
      projectId: projectId,
      referenceId: referenceId,
      isPurchases: isPurchases,
      isReturn: isReturn,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }

  factory ProductMovement.delete() {
    return ProductMovement(
      taxId: 0,
      warehouseId: 0,
      supplierId: 0,
      companyId: 0,
      productId: 0,
      price: 0,
      quantity: 0,
      taxRate: 0,
      discount: 0,
      totalCost: 0,
      transactionDate: DateTime.now(),
      documentNo: "",
      description: '',
      projectId: 0,
      referenceId: 0,
      isPurchases: false,
      isReturn: false,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory ProductMovement.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProductMovement.empty();
    return ProductMovement(
      id: int.tryParse(json['ID'].toString()) ?? 0,
      projectId: int.tryParse(json['PROJECT_ID'].toString()) ?? 0,
      taxId: int.tryParse(json['TAX_ID'].toString()) ?? 0,
      referenceId: int.tryParse(json['REFERENCE_ID'].toString()) ?? 0,
      price: int.tryParse(json['PRICE'].toString()) ?? 0,
      warehouseId: int.tryParse(json['WAREHOUSE_ID'].toString()) ?? 0,
      supplierId: int.tryParse(json['SUPPLIER_ID'].toString()) ?? 0,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      productId: int.tryParse(json['PRODUCT_ID'].toString()) ?? 0,
      quantity: double.tryParse(json['QUANTITY'].toString()) ?? 0,
      taxRate: double.tryParse(json['TAX_RATE'].toString()) ?? 0,
      discount: int.tryParse(json['DISCOUNT'].toString()) ?? 0,
      totalCost: double.tryParse(json['TOTAL_COST'].toString()) ?? 0,
      transactionDate:
          DateTime.tryParse(json['TRANSACTION_DATE'] ?? '') ?? DateTime(1950),
      documentNo: json['DOCUMENT_NO'],
      description: json['DESCRIPTION'],
      isPurchases: bool.tryParse(json['IS_PURCHASES'].toString()) ?? false,
      isReturn: bool.tryParse(json['IS_RETURN'].toString()) ?? false,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
    );
  }
  @override
  ProductMovement fromJson(Map<String, dynamic> json) =>
      ProductMovement.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'TAX_ID': taxId,
      'PROJECT_ID': projectId,
      'REFERENCE_ID': referenceId,
      'PRICE': price,
      'WAREHOUSE_ID': warehouseId,
      'SUPPLIER_ID': supplierId,
      'COMPANY_ID': companyId,
      'PRODUCT_ID': productId,
      'QUANTITY': quantity,
      'TAX_RATE': taxRate,
      'DISCOUNT': discount,
      'TOTAL_COST': totalCost,
      'TRANSACTION_DATE': DateFormat('yyyy-MM-dd').format(transactionDate),
      'DOCUMENT_NO': documentNo,
      'DESCRIPTION': description,
      'IS_PURCHASES': isPurchases,
      'IS_RETURN': isReturn,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
