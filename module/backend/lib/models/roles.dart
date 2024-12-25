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
    super.createdAt,
    super.createdBy,
    super.updatedAt,
    super.updatedBy,
    super.deletedBy,
    super.deletedAt,
  });

  factory Roles.empty() {
    return Roles(
      role: 0,
      description: '',
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory Roles.insert(
    String description,
  ) {
    return Roles(
      role: 0,
      description: description,
      id: 0,
      isActive: false,
      isDelete: false,
    );
  }
  factory Roles.update(
    int id,
    String description,
  ) {
    return Roles(
      role: 0,
      description: description,
      id: id,
      isActive: false,
      isDelete: false,
    );
  }
  factory Roles.delete(int id) {
    return Roles(
      role: 0,
      description: '',
      id: id,
      isActive: false,
      isDelete: true,
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
      };
}
