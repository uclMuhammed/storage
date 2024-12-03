import '../base/models.dart';

class ProductStats extends BaseModel<ProductStats> {
  final int productId;
  final int companyId;
  final double purchasesQuantity;
  final double salesQuantity;
  final double purchasesTotal;
  final double salesTotal;
  final double costPrice;
  final double profitPerSale;

  ProductStats({
    required this.productId,
    required this.companyId,
    required this.purchasesQuantity,
    required this.salesQuantity,
    required this.purchasesTotal,
    required this.salesTotal,
    required this.costPrice,
    required this.profitPerSale,
    required super.id,
    required super.isActive,
    required super.isDelete,
    required super.createdAt,
    required super.createdBy,
    required super.updatedAt,
    required super.updatedBy,
    required super.deletedBy,
    required super.deletedAt,
  });

  factory ProductStats.empty() {
    return ProductStats(
      companyId: 0,
      purchasesQuantity: 0,
      salesQuantity: 0,
      purchasesTotal: 0,
      salesTotal: 0,
      costPrice: 0,
      profitPerSale: 0,
      productId: 0,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: "",
      updatedAt: DateTime.now(),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime.now(),
    );
  }
  factory ProductStats.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProductStats.empty();
    return ProductStats(
      productId: int.tryParse(json['PRODUCT_ID'].toString()) ?? 0,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      purchasesQuantity: double.tryParse(json['PURCHASES_QUANTITY'].toString()) ?? 0,
      salesQuantity: double.tryParse(json['SALES_QUANTITY'].toString()) ?? 0,
      purchasesTotal: double.tryParse(json['PURCHASES_TOTAL'].toString()) ?? 0,
      salesTotal: double.tryParse(json['SALES_TOTAL'].toString()) ?? 0,
      costPrice: double.tryParse(json['COST_PRICE'].toString()) ?? 0,
      profitPerSale: double.tryParse(json['PROFIT_PER_SALE'].toString()) ?? 0,
      id: int.tryParse(json['ID'].toString()) ?? 0,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
      createdAt: DateTime.tryParse(json['CREATEDAT'] ?? '') ?? DateTime(1950),
      createdBy: json['CREATEDBY'],
      updatedAt: json['UPDATEDAT'] != null ? DateTime.tryParse(json['UPDATEDAT']) : null,
      updatedBy: json['UPDATEDBY'],
      deletedAt: json['DELETEDAT'] != null ? DateTime.tryParse(json['DELETEDAT']) : null,
      deletedBy: json['DELETEDBY'],
    );
  }

  @override
  ProductStats fromJson(Map<String, dynamic> json) => ProductStats.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'PRODUCT_ID': productId,
        'COMPANY_ID': companyId,
        'PURCHASES_QUANTITY': purchasesQuantity,
        'SALES_QUANTITY': salesQuantity,
        'PURCHASES_TOTAL': purchasesTotal,
        'SALES_TOTAL': salesTotal,
        'COST_PRICE': costPrice,
        'PROFIT_PER_SALE': profitPerSale,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
        'CREATEDAT': createdAt.toIso8601String(),
        'CREATEDBY': createdBy,
        'UPDATEDAT': updatedAt?.toIso8601String(),
        'UPDATEDBY': updatedBy,
        'DELETEDBY': deletedBy,
        'DELETEDAT': deletedAt?.toIso8601String(),
      };
}
