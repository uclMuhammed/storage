import 'package:backend/abstract/models.dart';

class ReferenceCode extends IModel<ReferenceCode> {
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
    super.createdAt,
    super.createdBy,
    super.updatedAt,
    super.updatedBy,
    super.deletedBy,
    super.deletedAt,
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
    );
  }

  factory ReferenceCode.insert(String description) {
    final now = DateTime.now();
    final end = now.add(const Duration(days: 30));
    return ReferenceCode(
      reference: 0,
      description: description,
      companyId: 0,
      startDate: DateTime(now.year, now.month, now.day),
      endDate: DateTime(end.year, end.month, end.day),
      id: 0,
      isActive: true,
      isDelete: false,
    );
  }

  factory ReferenceCode.update(int id, String description) {
    final now = DateTime.now();
    return ReferenceCode(
      reference: 0,
      description: description,
      companyId: 0,
      startDate: now,
      endDate: now.add(const Duration(days: 30)),
      id: id,
      isActive: true,
      isDelete: false,
    );
  }

  factory ReferenceCode.delete(int id) {
    return ReferenceCode(
      reference: 0,
      description: '',
      companyId: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      id: id,
      isActive: true,
      isDelete: false,
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
    };
  }

  @override
  ReferenceCode copyWith() {
    // TODO: implement copyWith
    throw UnimplementedError();
  }
}
