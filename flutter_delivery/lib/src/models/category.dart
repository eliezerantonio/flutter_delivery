// To parse this JSON data, do
//
//     final category = categoryFromJson(jsonString);

import 'dart:convert';

Category categoryFromJson(String str) => Category.fromJson(json.decode(str));

String categoryToJson(Category data) => json.encode(data.toJson());

class Category {
  Category({
    this.id,
    this.name,
    this.description,
  });

  String id;
  String name;
  String description;
  List<Category> toList = [];

  factory Category.fromJson(Map<String, dynamic> json) => Category(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        name: json["name"],
        description: json["description"],
      );

  Category.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      Category category = new Category.fromJson(item);
      toList.add(category);
    });
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
      };
}
