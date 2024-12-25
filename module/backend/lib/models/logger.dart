import 'package:backend/base/models.dart';

class Logger extends BaseModel<Logger> {
  final String type;
  final String operation;
  final String message;
  final int runTime;
  final int companyId;
  final int hasError;

  Logger({
    required this.type,
    required super.id,
    required this.operation,
    required this.message,
    required this.runTime,
    required this.companyId,
    required this.hasError,
    required super.isActive,
    required super.isDelete,
    required super.createdAt,
    required super.createdBy,
    required super.updatedAt,
    required super.updatedBy,
    required super.deletedBy,
    required super.deletedAt,
  });

  factory Logger.empty() {
    return Logger(
      type: '',
      id: 0,
      operation: '',
      message: '',
      runTime: 0,
      companyId: 0,
      hasError: 0,
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
  factory Logger.fromJson(Map<String, dynamic> json) {
    if (json.isEmpty) return Logger.empty();
    return Logger(
      type: json['TYPE'],
      id: int.tryParse(json['ID'].toString()) ?? -1,
      operation: json['OPERATION'],
      message: json['MESSAGE'],
      runTime: int.tryParse(json['RUN_TIME'].toString()) ?? -1,
      companyId: int.tryParse(json['COMPANY_ID'].toString()) ?? -1,
      hasError: int.tryParse(json['HAS_ERROR'].toString()) ?? -1,
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
  Logger fromJson(Map<String, dynamic> json) {
    return Logger.fromJson(json);
  }

  @override
  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'TYPE': type,
      'ID': id,
      'OPERATION': operation,
      'MESSAGE': message,
      'RUN_TIME': runTime,
      'COMPANY_ID': companyId,
      'HAS_ERROR': hasError,
      'ISACTIVE': isActive,
      'ISDELETE': isDelete,
    };
  }
}
