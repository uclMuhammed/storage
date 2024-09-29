// ignore_for_file: public_member_api_docs, sort_constructors_first
abstract class BaseClass {
  bool isActive;
  bool isDelete;
  DateTime createDat;
  DateTime updateDat;
  DateTime deleteDat;
  String createBy;
  String updatedBy;
  String deletedBy;

  BaseClass({
    required this.isActive,
    required this.isDelete,
    required this.createDat,
    required this.updateDat,
    required this.deleteDat,
    required this.createBy,
    required this.updatedBy,
    required this.deletedBy,
  });
}
