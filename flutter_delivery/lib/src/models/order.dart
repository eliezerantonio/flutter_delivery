// To parse this JSON data, do
//
//     final order = orderFromJson(jsonString);

import 'dart:convert';

Order orderFromJson(String str) => Order.fromJson(json.decode(str));

String orderToJson(Order data) => json.encode(data.toJson());

class Order {
  Order({
    this.id,
    this.idClient,
    this.idDelivery,
    this.idAddress,
    this.status,
    this.lat,
    this.lng,
    this.timestamp,
  });

  String id;
  String idClient;
  String idDelivery;
  String idAddress;
  String status;
  double lat;
  double lng;
  int timestamp;

  factory Order.fromJson(Map<String, dynamic> json) => Order(
        id: json["id"],
        idClient: json["id_client"],
        idDelivery: json["id_delivery"],
        idAddress: json["id_address"],
        status: json["status"],
        lat: json["lat"].toDouble(),
        lng: json["lng"].toDouble(),
        timestamp: json["timestamp"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "id_client": idClient,
        "id_delivery": idDelivery,
        "id_address": idAddress,
        "status": status,
        "lat": lat,
        "lng": lng,
        "timestamp": timestamp,
      };
}
