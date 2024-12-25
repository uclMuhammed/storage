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

  factory Authorities.insert(String description, bool readAt, bool writeAt,
      bool updateAt, bool deleteAt) {
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

  factory Authorities.update(String description, bool readAt, bool writeAt,
      bool updateAt, bool deleteAt) {
    return Authorities(
      id: -1,
      author: 0,
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
  factory Authorities.delete(int id) {
    return Authorities(
      id: -1,
      author: id,
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
      'ID': id,
      'AUTHOR': author,
      'READ_AT': readAt,
      'WRITE_AT': writeAt,
      'UPDATE_AT': updateAt,
      'DELETE_AT': deleteAt,
      'DESCRIPTION': description,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
