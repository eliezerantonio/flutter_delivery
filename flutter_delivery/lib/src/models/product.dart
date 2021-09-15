// To parse this JSON data, do
//
//     final product = productFromJson(jsonString);

import 'dart:convert';

Product productFromJson(String str) => Product.fromJson(json.decode(str));

String productToJson(Product data) => json.encode(data.toJson());

class Product {
  Product({
    this.id,
    this.name,
    this.description,
    this.image1,
    this.image2,
    this.image3,
    this.price,
    this.idCategory,
    this.quantity,
  });

  String id;
  String name;
  String description;
  String image1;
  String image2;
  String image3;
  double price;
  int idCategory;
  int quantity;
  List<Product> toList = [];

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"] is int ? json["id"].toString() : json["id"],
        name: json["name"],
        description: json["description"],
        image1: json["image1"],
        image2: json["image2"],
        image3: json["image3"],
        price: json["price"] is String
            ? double.parse(json["price"])
            : isInteger(json["price"])
                ? json["price"].toDouble()
                : json["price"],
        idCategory: json["idCategory"] is String
            ? int.parse(json["idCategory"])
            : json["idCategory"],
        quantity: json["quantity"],
      );

  Product.fromJsonList(List<dynamic> jsonList) {
    if (jsonList == null) return;

    jsonList.forEach((item) {
      Product product = new Product.fromJson(item);
      toList.add(product);
    });
  }
  Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
        "description": description,
        "image1": image1,
        "image2": image2,
        "image3": image3,
        "price": price,
        "idCategory": idCategory,
        "quantity": quantity,
      };

  static bool isInteger(num value) =>
      value is int || value == value.roundToDouble();
}
