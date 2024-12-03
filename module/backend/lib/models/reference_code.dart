import 'package:backend/base/models.dart';

class ReferenceCode extends BaseModel<ReferenceCode> {
  final int reference;
  final String description;
  final int companyId;
  final DateTime startDate;
  final DateTime endDate;

  ReferenceCode({
    required this.reference,
    required this.description,
    required this.companyId,
    required this.startDate,
    required this.endDate,
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

  factory ReferenceCode.empty() {
    return ReferenceCode(
      reference: 0,
      description: '',
      companyId: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      id: 0,
      isActive: true,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: DateTime.now(),
      updatedBy: '',
      deletedBy: '',
      deletedAt: DateTime.now(),
    );
  }

  factory ReferenceCode.fromJson(Map<String, dynamic> json) {
    return ReferenceCode(
      reference: int.tryParse(json['REFERENCE'].toString()) ?? 0,
      description: json['DESCRIPTION'],
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      startDate: DateTime.tryParse(json['START_DATE']) ?? DateTime.now(),
      endDate: DateTime.tryParse(json['END_DATE']) ?? DateTime.now(),
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
  ReferenceCode fromJson(Map<String, dynamic> json) {
    return ReferenceCode.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'REFERENCE': reference,
      'DESCRIPTION': description,
      'COMPANY_ID': companyId,
      'START_DATE': startDate,
      'END_DATE': endDate,
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
