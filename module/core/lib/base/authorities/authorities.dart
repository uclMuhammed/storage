// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:core/base/base.dart';

class Authorities extends BaseClass {
  int id;
  int author;
  bool read_at;
  bool write_at;
  bool update_at;
  bool delete_at;
  String description;
  Authorities({
    required this.id,
    required this.author,
    required this.read_at,
    required this.write_at,
    required this.update_at,
    required this.delete_at,
    required this.description,
    required super.isActive,
    required super.isDelete,
    required super.createDat,
    required super.updateDat,
    required super.deleteDat,
    required super.createBy,
    required super.updatedBy,
    required super.deletedBy,
  });
}
