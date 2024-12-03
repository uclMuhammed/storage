import '../base/models.dart';

class Roles extends BaseModel<Roles> {
  final int role;
  final String description;
  Roles({
    required this.role,
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

  factory Roles.empty() {
    return Roles(
      role: 0,
      description: '',
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
  factory Roles.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Roles.empty();
    //
    return Roles(
      role: json['ROLE'],
      description: json['DESCRIPTION'],
      id: int.tryParse(json['ID'].toString()) ?? -1,
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
  Roles fromJson(Map<String, dynamic> json) {
    return Roles.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() => {
        'ROLE': role,
        'DESCRIPTION': description,
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
