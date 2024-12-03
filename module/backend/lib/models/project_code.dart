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
    required super.createdAt,
    required super.createdBy,
    required super.updatedAt,
    required super.updatedBy,
    required super.deletedBy,
    required super.deletedAt,
  });
  factory ProjectCode.empty() {
    return ProjectCode(
      project: 0,
      description: '',
      companyId: 0,
      startDate: DateTime(1950),
      endDate: DateTime(1950),
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: null,
      updatedBy: "",
      deletedBy: "",
      deletedAt: null,
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
      createdAt: DateTime.tryParse(json['CREATEDAT'] ?? '') ?? DateTime(1950),
      createdBy: json['CREATEDBY'],
      updatedAt: json['UPDATEDAT'] != null ? DateTime.tryParse(json['UPDATEDAT']) : null,
      updatedBy: json['UPDATEDBY'],
      deletedAt: json['DELETEDAT'] != null ? DateTime.tryParse(json['DELETEDAT']) : null,
      deletedBy: json['DELETEDBY'],
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
      'STARTDATE': startDate,
      'ENDDATE': endDate,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
