import 'package:lux_estate/features/auth/domain/entity/Auth_entity.dart';

class AuthModel extends AuthEntity {
  AuthModel({required super.email, required super.fullName, required super.id});

  factory AuthModel.fromJson(Map<String, dynamic> json) {
    return AuthModel(
      email: json['email'],
      fullName: json['fullName'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() => {
    'email': email,
    'fullName': fullName,
    'id': id,
  };

  AuthModel copyWith({String? email, String? fullName, String? id}) {
    return AuthModel(
      email: email ?? super.email,
      fullName: fullName ?? super.fullName,
      id: id ?? super.id,
    );
  }
}
