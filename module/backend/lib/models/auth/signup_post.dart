import 'package:backend/abstract/models.dart';

class SignupPostModel extends IModel {
  final String companyName;
  final String email;
  final String password;

  SignupPostModel({
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

  factory SignupPostModel.fromJson(Map<String, dynamic> json) {
    return SignupPostModel(
      companyName: json['COMPANYNAME'],
      email: json['EMAIL'],
      password: json['PASSWORD'],
    );
  }

  @override
  SignupPostModel copyWith({
    String? companyName,
    String? email,
    String? password,
  }) {
    return SignupPostModel(
      companyName: companyName ?? this.companyName,
      email: email ?? this.email,
      password: password ?? this.password,
    );
  }

  @override
  fromJson(Map<String, dynamic> json) {
    return SignupPostModel.fromJson(json);
  }
}
