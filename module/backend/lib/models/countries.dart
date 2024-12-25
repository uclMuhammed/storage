import '../base/models.dart';

class Countries extends BaseModel<Countries> {
  final int country;
  final String description;
  Countries({
    required this.country,
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

  factory Countries.empty() {
    return Countries(
      country: 0,
      description: '',
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedBy: null,
      deletedAt: null,
    );
  }

  factory Countries.insert(String description, int country) {
    return Countries(
      id: 0,
      country: country,
      description: description,
      isActive: true,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedAt: null,
      deletedBy: null,
    );
  }

  factory Countries.update(int id, String description) {
    return Countries(
      country: 0,
      description: description,
      id: id,
      isActive: true,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedBy: null,
      deletedAt: null,
    );
  }

  factory Countries.delete(int id) {
    return Countries(
      country: 0,
      description: '',
      id: id,
      isActive: true,
      isDelete: true,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: null,
      updatedBy: null,
      deletedBy: null,
      deletedAt: null,
    );
  }

  factory Countries.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return Countries.empty();
    }
    return Countries(
      country: int.tryParse(json['COUNTRY'].toString()) ?? 0,
      description: json['DESCRIPTION'],
      id: int.tryParse(json['ID'].toString()) ?? 0,
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
  Countries fromJson(Map<String, dynamic> json) => Countries.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'ID': id,
      'COUNTRY': country,
      'DESCRIPTION': description,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
