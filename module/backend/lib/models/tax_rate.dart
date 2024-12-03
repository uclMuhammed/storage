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
    required super.createdAt,
    required super.createdBy,
    required super.updatedAt,
    required super.updatedBy,
    required super.deletedBy,
    required super.deletedAt,
  });

  factory TaxRate.empty() {
    return TaxRate(
      tax: 0,
      description: '',
      companyId: 0,
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

  factory TaxRate.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return TaxRate.empty();
    return TaxRate(
      tax: json['TAX'],
      description: json['DESCRIPTION'].toString(),
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
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
      'CREATEDAT': createdAt,
      'CREATEDBY': createdBy,
      'UPDATEDAT': updatedAt,
      'UPDATEDBY': updatedBy,
      'DELETEDAT': deletedAt,
      'DELETEDBY': deletedBy,
    };
  }
}
