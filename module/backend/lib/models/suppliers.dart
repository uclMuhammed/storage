import '../base/models.dart';

class Suppliers extends BaseModel<Suppliers> {
  final int companyId;
  final int regionId;
  final int supplier;
  final String name;
  final String address;
  final String identityNo;
  final String phone;
  final String email;

  Suppliers({
    required this.companyId,
    required this.regionId,
    required this.supplier,
    required this.name,
    required this.address,
    required this.identityNo,
    required this.phone,
    required this.email,
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

  factory Suppliers.empty() {
    return Suppliers(
      companyId: 0,
      regionId: 0,
      supplier: 0,
      name: '',
      address: '',
      identityNo: '',
      phone: '',
      email: '',
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
    );
  }
  factory Suppliers.insert(String name, String address, String identityNo,
      String phone, String email, int regionId) {
    return Suppliers(
      companyId: 0,
      regionId: regionId,
      supplier: 0,
      name: name,
      address: address,
      identityNo: identityNo,
      phone: phone,
      email: email,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
    );
  }
  factory Suppliers.update(int id, String name, int regionId, String address,
      String identityNo, String phone, String email) {
    return Suppliers(
      companyId: 0,
      regionId: regionId,
      supplier: 0,
      name: name,
      address: address,
      identityNo: identityNo,
      phone: phone,
      email: email,
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
    );
  }
  factory Suppliers.delete(int id) {
    return Suppliers(
      companyId: 0,
      regionId: 0,
      supplier: 0,
      name: '',
      address: '',
      identityNo: '',
      phone: '',
      email: '',
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: '',
    );
  }
  factory Suppliers.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Suppliers.empty();
    return Suppliers(
      id: int.tryParse(json['ID'].toString()) ?? -1,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? -1,
      regionId: int.tryParse(json['REGION_ID'].toString()) ?? -1,
      supplier: int.tryParse(json['SUPPLIER'].toString()) ?? -1,
      name: json['NAME'],
      address: json['ADDRESS'],
      identityNo: json['IDENTITY_NO'],
      phone: json['PHONE'],
      email: json['EMAIL'],
      isActive: bool.tryParse(json['ISACTIVE'].toString()) ?? false,
      isDelete: bool.tryParse(json['ISDELETE'].toString()) ?? false,
    );
  }
  @override
  Suppliers fromJson(Map<String, dynamic> json) {
    return Suppliers.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return {
      'COMPANYID': companyId,
      'REGION_ID': regionId,
      'SUPPLIER': supplier,
      'NAME': name,
      'ADDRESS': address,
      'IDENTITY_NO': identityNo,
      'PHONE': phone,
      'EMAIL': email,
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
