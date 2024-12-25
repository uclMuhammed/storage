import '../base/models.dart';

class Cities extends BaseModel<Cities> {
  final int city;
  final int countryId;
  final String description;
  Cities({
    required this.city,
    required this.countryId,
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

  factory Cities.empty() {
    return Cities(
      city: -1,
      countryId: -1,
      description: '',
      id: -1,
      isActive: false,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: DateTime.now(),
      updatedBy: '',
      deletedBy: '',
      deletedAt: DateTime.now(),
    );
  }

  factory Cities.insert(String description, int countriesId) {
    return Cities(
      city: -1,
      countryId: -1,
      description: description,
      id: -1,
      isActive: false,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: DateTime.now(),
      updatedBy: '',
      deletedBy: '',
      deletedAt: DateTime.now(),
    );
  }

  factory Cities.update(int id, String description) {
    return Cities(
      city: -1,
      countryId: -1,
      description: description,
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: DateTime.now(),
      updatedBy: '',
      deletedBy: '',
      deletedAt: DateTime.now(),
    );
  }

  factory Cities.delete(int id) {
    return Cities(
      city: -1,
      countryId: -1,
      description: '',
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime.now(),
      createdBy: '',
      updatedAt: DateTime.now(),
      updatedBy: '',
      deletedBy: '',
      deletedAt: DateTime.now(),
    );
  }

  factory Cities.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Cities.empty();
    return Cities(
      city: int.tryParse(json['CITY'].toString()) ?? -1,
      countryId: int.tryParse(json['COUNTRY_ID'].toString()) ?? -1,
      description: json['DESCRIPTION'].toString(),
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
  Cities fromJson(Map<String, dynamic> json) {
    return Cities.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'CITY': city,
      'COUNTRYID': countryId,
      'DESCRIPTION': description,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
