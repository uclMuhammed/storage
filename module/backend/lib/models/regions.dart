import '../base/models.dart';

class Regions extends BaseModel<Regions> {
  final int region;
  final int companyId;
  final String description;

  Regions({
    required this.region,
    required this.companyId,
    required this.description,
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

  factory Regions.empty() {
    return Regions(
      region: -1,
      companyId: -1,
      description: '',
      id: -1,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedBy: '',
      deletedAt: null,
    );
  }
  factory Regions.insert(String description) {
    return Regions(
      region: -1,
      companyId: -1,
      description: description,
      id: -1,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedBy: '',
      deletedAt: null,
    );
  }
  factory Regions.update(int id, String description) {
    return Regions(
      region: -1,
      companyId: -1,
      description: description,
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedBy: '',
      deletedAt: null,
    );
  }
  factory Regions.delete(int id) {
    return Regions(
      region: -1,
      companyId: -1,
      description: '',
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedBy: '',
      deletedAt: null,
    );
  }
  factory Regions.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Regions.empty();
    return Regions(
      region: int.tryParse(json['REGION'].toString()) ?? -1,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? -1,
      description: json['DESCRIPTION'],
      id: int.tryParse(json['ID'].toString()) ?? -1,
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
      createdAt: DateTime.tryParse(json['CREATEDAT'] ?? '') ?? DateTime(1950),
      createdBy: json['CREATEDBY'],
      updatedAt: json['UPDATEDAT'] != null
          ? DateTime.tryParse(json['UPDATEDAT'])
          : null,
      updatedBy: json['UPDATEDBY'],
      deletedAt: json['DELETEDAT'] != null
          ? DateTime.tryParse(json['DELETEDAT'])
          : null,
      deletedBy: json['DELETEDBY'],
    );
  }

  @override
  Regions fromJson(Map<String, dynamic> json) {
    return Regions.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => {
        'REGION': region,
        'DESCRIPTION': description,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
      };
}
