import 'package:backend/base/models.dart';

class TaxRate extends BaseModel<TaxRate> {
  final double tax;
  final String description;
  final int companyId;

  TaxRate({
    required this.tax,
    required this.description,
    required this.companyId,
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

  factory TaxRate.empty() {
    return TaxRate(
      tax: 0,
      description: '',
      companyId: 0,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory TaxRate.insert(double tax, String description) {
    return TaxRate(
      tax: tax,
      description: description,
      companyId: 1,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory TaxRate.update(int id, double tax, String description) {
    return TaxRate(
      tax: tax,
      description: description,
      companyId: 1,
      id: id,
      isActive: false,
      isDelete: false,
    );
  }
  factory TaxRate.delete(int id) {
    return TaxRate(
      tax: 0,
      description: '',
      companyId: 0,
      id: id,
      isActive: false,
      isDelete: true,
    );
  }
  factory TaxRate.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return TaxRate.empty();
    return TaxRate(
      tax: double.tryParse(json['TAX'].toString()) ?? 0,
      description: json['DESCRIPTION'],
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      id: int.tryParse(json['ID'].toString()) ?? 0,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? true,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
    );
  }

  @override
  TaxRate fromJson(Map<String, dynamic> json) {
    return TaxRate.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'TAX': tax,
      'DESCRIPTION': description,
      'COMPANY_ID': companyId,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
