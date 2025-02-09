import 'package:backend/abstract/models.dart';

class LoginPostModel extends IModel {
  final int companyCode;
  final String email;
  final String password;

  LoginPostModel({
    required this.companyCode,
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'COMPANYCODE': companyCode,
      'EMAIL': email,
      'PASSWORD': password,
    };
  }

  factory LoginPostModel.fromJson(Map<String, dynamic> json) {
    return LoginPostModel(
      companyCode: json['COMPANYCODE'],
      email: json['EMAIL'],
      password: json['PASSWORD'],
    );
  }

  @override
  LoginPostModel copyWith({
    int? companyCode,
    String? email,
    String? password,
  }) {
    return LoginPostModel(
      companyCode: companyCode ?? this.companyCode,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return LoginPostModel.fromJson(json);
  }
}
