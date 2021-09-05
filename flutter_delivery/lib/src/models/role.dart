// To parse this JSON data, do
//
//     final role = roleFromJson(jsonString);

import 'dart:convert';

Role roleFromJson(String str) => Role.fromJson(json.decode(str));

String roleToJson(Role data) => json.encode(data.toJson());

class Role {
  Role({
    this.id,
    this.name,
    this.image,
    this.route,
  });

  String id;
  String name;
  String image;
  String route;

  factory Role.fromJson(Map<String, dynamic> json) => Role(
        id: json["id"] is int ? json['id'].toString() : json['id'],
        name: json["name"],
        image: json["image"],
        route: json["route"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "image": image,
        "route": route,
      };
}
