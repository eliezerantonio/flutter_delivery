import 'package:flutter_delivery/src/models/role.dart';

class User {
  User({
    this.id,
    this.email,
    this.name,
    this.lastname,
    this.phone,
    this.image,
    this.password,
    this.isAvailable,
    this.sessionToken,
    this.roles,
  });

  String id;
  String email;
  String name;
  String lastname;
  String phone;
  dynamic image;
  String password;
  dynamic isAvailable;
  dynamic sessionToken;
  List<Role> roles = [];

  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json["id"] is int ? json['id'].toString() : json['id'],
        email: json["email"],
        name: json["name"],
        lastname: json["lastname"],
        phone: json["phone"],
        image: json["image"],
        password: json["password"],
        isAvailable: json["is_available"],
        sessionToken: json["session_token"],
        roles: json["roles"] == null
            ? []
            : List<Role>.from(
                    json['roles'].map((model) => Role.fromJson(model))) ??
                [],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "name": name,
        "lastname": lastname,
        "phone": phone,
        "image": image,
        "password": password,
        "is_available": isAvailable,
        "session_token": sessionToken,
        "roles": roles,
      };
}
