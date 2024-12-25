import '../base/models.dart';

class ProjectCode extends BaseModel<ProjectCode> {
  final int project;
  final String description;
  final int companyId;
  final DateTime startDate;
  final DateTime endDate;

  ProjectCode({
    required this.project,
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
  factory ProjectCode.empty() {
    return ProjectCode(
      project: 0,
      description: '',
      companyId: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory ProjectCode.insert(String description) {
    return ProjectCode(
      project: 0,
      description: description,
      companyId: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory ProjectCode.update(int id, String description) {
    return ProjectCode(
      project: 0,
      description: description,
      companyId: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      id: id,
      isActive: false,
      isDelete: false,
    );
  }

  factory ProjectCode.delete(int id) {
    return ProjectCode(
      project: 0,
      description: '',
      companyId: 0,
      startDate: DateTime.now(),
      endDate: DateTime.now(),
      id: id,
      isActive: false,
      isDelete: false,
    );
  }

  factory ProjectCode.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return ProjectCode.empty();
    return ProjectCode(
      project: int.tryParse(json['PROJECT'].toString()) ?? 0,
      description: json['DESCRIPTION'],
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? 0,
      startDate: DateTime.tryParse(json['START_DATE'] ?? '') ?? DateTime(1950),
      endDate: DateTime.tryParse(json['END_DATE'] ?? '') ?? DateTime(1950),
      id: int.tryParse(json['ID'].toString()) ?? 0,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
    );
  }

  @override
  ProjectCode fromJson(Map<String, dynamic> json) {
    return ProjectCode.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'PROJECT': project,
      'DESCRIPTION': description,
      'COMPANYID': companyId,
      'START_DATE': startDate.toIso8601String(),
      'END_DATE': endDate.toIso8601String(),
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
