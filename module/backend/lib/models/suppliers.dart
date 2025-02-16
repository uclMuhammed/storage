import '../abstract/models.dart';

class Suppliers extends IModel<Suppliers> {
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
      name: name.toString().trim().toUpperCase(),
      address: address.toString().trim().toUpperCase(),
      identityNo: identityNo.toString().trim().toUpperCase(),
      phone: phone.toString().trim().toUpperCase(),
      email: email.toString().trim().toUpperCase(),
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
      name: name.toString().trim().toUpperCase(),
      address: address.toString().trim().toUpperCase(),
      identityNo: identityNo.toString().trim().toUpperCase(),
      phone: phone.toString().trim().toUpperCase(),
      email: email.toString().trim().toUpperCase(),
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
      name: json['NAME']?.toString().trim().toUpperCase() ?? '',
      address: json['ADDRESS']?.toString().trim().toUpperCase() ?? '',
      identityNo: json['IDENTITY_NO']?.toString().trim().toUpperCase() ?? '',
      phone: json['PHONE']?.toString().trim().toUpperCase() ?? '',
      email: json['EMAIL']?.toString().trim().toUpperCase() ?? '',
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
      'NAME': name.toString().trim().toUpperCase(),
      'ADDRESS': address.toString().trim().toUpperCase(),
      'IDENTITY_NO': identityNo.toString().trim().toUpperCase(),
      'PHONE': phone.toString().trim().toUpperCase(),
      'EMAIL': email.toString().trim().toUpperCase(),
      'ID': id,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }

  @override
  Suppliers copyWith() {
    throw UnimplementedError();
  }
}
