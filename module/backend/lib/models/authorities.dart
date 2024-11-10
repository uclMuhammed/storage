import '../base/models.dart';

class Authorities extends BaseModel<Authorities> {
  final int author;
  final bool readAt;
  final bool writeAt;
  final bool updateAt;
  final bool deleteAt;
  final String description;

  Authorities({
    required super.id,
    required this.author,
    required this.readAt,
    required this.writeAt,
    required this.updateAt,
    required this.deleteAt,
    required this.description,
    required super.isActive,
    required super.isDelete,
    required super.createdAt,
    required super.createdBy,
    required super.updatedAt,
    required super.updatedBy,
    required super.deletedBy,
    required super.deletedAt,
  });

  factory Authorities.empty() {
    return Authorities(
      id: -1,
      author: -1,
      readAt: false,
      writeAt: false,
      updateAt: false,
      deleteAt: false,
      description: '',
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

  factory Authorities.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Authorities.empty();
    //
    return Authorities(
      id: int.tryParse(json['ID'].toString()) ?? -1,
      author: int.tryParse(json['AUTHOR'].toString()) ?? -1,
      readAt: bool.tryParse(json['READ_AT'].toString()) ?? false,
      writeAt: bool.tryParse(json['WRITE_AT'].toString()) ?? false,
      updateAt: bool.tryParse(json['UPDATE_AT'].toString()) ?? false,
      deleteAt: bool.tryParse(json['DELETE_AT'].toString()) ?? false,
      description: json['DESCRIPTION'],
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
  Authorities fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Authorities.empty();
    //
    return Authorities(
      id: int.tryParse(json['ID'].toString()) ?? -1,
      author: int.tryParse(json['AUTHOR'].toString()) ?? -1,
      readAt: bool.tryParse(json['READ_AT'].toString()) ?? false,
      writeAt: bool.tryParse(json['WRITE_AT'].toString()) ?? false,
      updateAt: bool.tryParse(json['UPDATE_AT'].toString()) ?? false,
      deleteAt: bool.tryParse(json['DELETE_AT'].toString()) ?? false,
      description: json['DESCRIPTION'],
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
  Map<String, dynamic> toJson() {
    return {
      'ID': id.toString(),
      'AUTHOR': author,
      'READ_AT': readAt.toString(),
      'WRITE_AT': writeAt.toString(),
      'UPDATE_AT': updateAt.toString(),
      'DELETE_AT': deleteAt.toString(),
      'DESCRIPTION': description,
      'ISACTIVE': isActive.toString(),
      'ISDELETE': isDelete.toString(),
      'CREATEDAT': createdAt.toIso8601String(),
      'CREATEDBY': createdBy,
      'UPDATEDAT': updatedAt?.toIso8601String(),
      'UPDATEDBY': updatedBy,
      'DELETEDBY': deletedBy,
      'DELETEDAT': deletedAt?.toIso8601String(),
    };
  }
}
