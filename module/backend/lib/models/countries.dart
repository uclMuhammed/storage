import '../base/models.dart';

class Countries extends BaseModel<Countries> {
  final int countries;
  final String description;
  Countries({
    required this.countries,
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
      countries: 0,
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

  factory Countries.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) {
      return Countries.empty();
    }
    return Countries(
      countries: int.tryParse(json['COUNTRIES'].toString()) ?? 0,
      description: json['DESCRIPTION'],
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
  Countries fromJson(Map<String, dynamic> json) => Countries.fromJson(json);

  @override
  Map<String, dynamic> toJson() {
    return {
      'COUNTRIES': countries,
      'DESCRIPTION': description,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
      'CREATEDAT': createdAt.toIso8601String(),
      'CREATEDBY': createdBy,
      'UPDATEDAT': updatedAt?.toIso8601String(),
      'UPDATEDBY': updatedBy,
      'DELETEDBY': deletedBy,
      'DELETEDAT': deletedAt?.toIso8601String(),
    };
  }
}
