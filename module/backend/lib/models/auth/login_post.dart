import 'package:backend/abstract/models.dart';

class LoginPostModel extends IModel {
  final int companyName;
  final String email;
  final String password;

  LoginPostModel({
    required this.companyName,
    required this.email,
    required this.password,
  });

  @override
  Map<String, dynamic> toJson() {
    return {
      'COMPANYNAME': companyName,
      'EMAIL': email,
      'PASSWORD': password,
    };
  }

  factory LoginPostModel.fromJson(Map<String, dynamic> json) {
    return LoginPostModel(
      companyName: json['COMPANYNAME'],
      email: json['EMAIL'],
      password: json['PASSWORD'],
    );
  }

  @override
  LoginPostModel copyWith({
    int? companyName,
    String? email,
    String? password,
  }) {
    return LoginPostModel(
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return LoginPostModel.fromJson(json);
  }
}
