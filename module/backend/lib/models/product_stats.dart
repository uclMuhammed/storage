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
    super.createdAt,
    super.createdBy,
    super.updatedAt,
    super.updatedBy,
    super.deletedBy,
    super.deletedAt,
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
    );
  }
  factory ProductStats.insert(int productId) {
    return ProductStats(
      companyId: 0,
      purchasesQuantity: 1,
      salesQuantity: 1,
      purchasesTotal: 1,
      salesTotal: 1,
      costPrice: 1,
      profitPerSale: 1,
      productId: productId,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory ProductStats.update(
      int productId,
      double? purchasesQuantity,
      double? salesQuantity,
      double? purchasesTotal,
      double? salesTotal,
      double? costPrice,
      double? profitPerSale) {
    return ProductStats(
      companyId: 0,
      purchasesQuantity: purchasesQuantity ?? 1,
      salesQuantity: salesQuantity ?? 1,
      purchasesTotal: purchasesTotal ?? 1,
      salesTotal: salesTotal ?? 1,
      costPrice: costPrice ?? 1,
      profitPerSale: profitPerSale ?? 1,
      productId: productId,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory ProductStats.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProductStats.empty();
    return ProductStats(
      productId: int.tryParse(json['PRODUCT_ID'].toString()) ?? 0,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      purchasesQuantity:
          double.tryParse(json['PURCHASES_QUANTITY'].toString()) ?? 0,
      salesQuantity: double.tryParse(json['SALES_QUANTITY'].toString()) ?? 0,
      purchasesTotal: double.tryParse(json['PURCHASES_TOTAL'].toString()) ?? 0,
      salesTotal: double.tryParse(json['SALES_TOTAL'].toString()) ?? 0,
      costPrice: double.tryParse(json['COST_PRICE'].toString()) ?? 0,
      profitPerSale: double.tryParse(json['PROFIT_PER_SALE'].toString()) ?? 0,
      id: int.tryParse(json['ID'].toString()) ?? 0,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
    );
  }

  @override
  ProductStats fromJson(Map<String, dynamic> json) =>
      ProductStats.fromJson(json);

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
      };
}
