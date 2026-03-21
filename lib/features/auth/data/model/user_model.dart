import 'package:lux_estate/features/auth/domain/entity/user_entity.dart';

class UserModel extends UserEntity {
  UserModel({required super.email, required super.fullName, required super.id});

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
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

  UserModel copyWith({String? email, String? fullName, String? id}) {
    return UserModel(
      email: email ?? super.email,
      fullName: fullName ?? super.fullName,
      id: id ?? super.id,
    );
  }
}
