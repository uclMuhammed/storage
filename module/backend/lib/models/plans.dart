import '../base/models.dart';

class Plans extends BaseModel<Plans> {
  final int plans;
  final String description;
  final int price;
  final int subUser;
  final int region;
  final int warehouse;
  final int product;

  Plans({
    required this.plans,
    required this.description,
    required this.price,
    required this.subUser,
    required this.region,
    required this.warehouse,
    required this.product,
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

  factory Plans.empty() {
    return Plans(
      plans: 0,
      description: '',
      price: 0,
      subUser: 0,
      region: 0,
      warehouse: 0,
      product: 0,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }

  factory Plans.insert(String description) {
    return Plans(
      plans: 0,
      description: description,
      price: 0,
      subUser: 0,
      region: 0,
      warehouse: 0,
      product: 0,
      id: 0,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }

  factory Plans.update(int id, String description) {
    return Plans(
      plans: 0,
      description: description,
      price: 0,
      subUser: 0,
      region: 0,
      warehouse: 0,
      product: 0,
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }

  factory Plans.delete(int id) {
    return Plans(
      plans: 0,
      description: '',
      price: 0,
      subUser: 0,
      region: 0,
      warehouse: 0,
      product: 0,
      id: id,
      isActive: false,
      isDelete: false,
      createdAt: DateTime(1950),
      createdBy: "",
      updatedAt: DateTime(1950),
      updatedBy: "",
      deletedBy: "",
      deletedAt: DateTime(1950),
    );
  }

  factory Plans.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Plans.empty();
    return Plans(
      plans: int.tryParse(json['PLANS'].toString()) ?? 0,
      description: json['DESCRIPTION'],
      price: int.tryParse(json['PRICE'].toString()) ?? 0,
      subUser: int.tryParse(json['SUB_USER'].toString()) ?? 0,
      region: int.tryParse(json['REGION'].toString()) ?? 0,
      warehouse: int.tryParse(json['WAREHOUSE'].toString()) ?? 0,
      product: int.tryParse(json['PRODUCT'].toString()) ?? 0,
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
  Plans fromJson(Map<String, dynamic> json) => Plans.fromJson(json);

  @override
  Map<String, dynamic> toJson() => {
        'PLANS': plans,
        'DESCRIPTION': description,
        'PRICE': price,
        'SUB_USER': subUser,
        'REGION': region,
        'WAREHOUSE': warehouse,
        'PRODUCT': product,
        'ID': id,
        'ISACTIVE': isActive,
        'ISDELETE': isDelete,
      };
}
