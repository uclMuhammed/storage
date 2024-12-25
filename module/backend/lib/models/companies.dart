import 'package:backend/base/models.dart';

class Companies extends BaseModel<Companies> {
  final int company;
  final String name;
  final int ownerId;
  final int planID;
  final DateTime planAt;

  Companies({
    required this.planID,
    required this.planAt,
    required this.company,
    required this.name,
    required this.ownerId,
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
  factory Companies.empty() {
    return Companies(
      planID: -1,
      planAt: DateTime(1950),
      company: -1,
      name: '',
      ownerId: -1,
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

  factory Companies.insert(String name) {
    return Companies(
      planID: -1,
      planAt: DateTime(1950),
      company: -1,
      name: name,
      ownerId: -1,
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

  factory Companies.update(int id) {
    return Companies(
      planID: -1,
      planAt: DateTime(1950),
      company: -1,
      name: '',
      ownerId: -1,
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

  factory Companies.delete(int id) {
    return Companies(
      planID: -1,
      planAt: DateTime(1950),
      company: -1,
      name: '',
      ownerId: -1,
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

  factory Companies.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Companies.empty();
    return Companies(
      planID: int.tryParse(json['PLAN_ID'].toString()) ?? -1,
      planAt: DateTime.tryParse(json['PLANAT'] ?? '') ?? DateTime(1950),
      company: int.tryParse(json['COMPANY'].toString()) ?? -1,
      name: json['NAME'],
      ownerId: int.tryParse(json['OWNERID'].toString()) ?? -1,
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
  Companies fromJson(Map<String, dynamic> json) => Companies.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'PLAN_ID': planID,
      'PLANAT': planAt.toIso8601String(),
      'COMPANY': company,
      'NAME': name,
      'OWNERID': ownerId,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
