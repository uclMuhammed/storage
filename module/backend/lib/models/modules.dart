import 'package:backend/base/models.dart';

class Modules extends BaseModel<Modules> {
  final int module;
  final String description;

  Modules({
    required this.module,
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

  factory Modules.empty() {
    return Modules(
      module: 0,
      description: '',
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedAt: null,
      deletedBy: '',
    );
  }
  factory Modules.insert(String description) {
    return Modules(
      module: 0,
      description: description,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedAt: null,
      deletedBy: '',
    );
  }
  factory Modules.update(int id, String description) {
    return Modules(
      module: 0,
      description: description,
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedAt: null,
      deletedBy: '',
    );
  }
  factory Modules.delete(int id) {
    return Modules(
      module: 0,
      description: '',
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: '',
      deletedAt: null,
      deletedBy: '',
    );
  }
  factory Modules.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Modules.empty();
    return Modules(
      module: int.tryParse(json['MODULE'].toString()) ?? -1,
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
  Modules fromJson(Map<String, dynamic> json) => Modules.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'MODULE': module,
        'DESCRIPTION': description,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
      };
}
