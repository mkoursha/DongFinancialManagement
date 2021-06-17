import 'package:dong/data/entities.dart';

extension UserFromJson on User {
  static User fromJson(Map<String, dynamic> json) {
    return User(
      json['id'],
      json['email'] ?? "",
      json['name'] ?? "",
      json['password'] ?? "",
      json['phoneNumber'] ?? "",
      json['lastName'] ?? "",
    );
  }
}
